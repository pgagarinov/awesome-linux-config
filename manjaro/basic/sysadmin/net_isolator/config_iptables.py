import argparse
import logging
import shutil
import sys
import subprocess
import glob
import uuid
from pathlib import Path
from typing import List, Dict, Optional, IO
from enum import Flag, auto


MAIN_CMD_NAME: str = __file__
CURRENT_PATH: Path = Path(__file__).absolute().parent


FIREWALL_SERVICES_CHECK_TO_BE_INACTIVE_LIST = [
    "nftables",
    "ebtables",
    "fail2ban",
    "firehol",
    "firewalld",
    "ipset",
    "nft-blackhole",
    "pgl",
    "shorewall",
    "sshguard",
    "ufw",
    "ip6tables",
]
SYSCTL_FOLDERS: List[Path] = [
    Path(path_str) / "sysctl.d"
    for path_str in ["/etc", "/run", "/usr/local/lib", "/usr/lib"]
]
SYS_PARAMS_DICT: Dict[str, int] = {
    # Drop ICMP echo-request messages sent to broadcast or multicast addresses
    "net.ipv4.icmp_echo_ignore_broadcasts": 1,
    # Drop source routed packets
    "net.ipv4.conf.all.accept_source_route": 0,
    # Enable TCP SYN cookie protection from SYN floods
    "net.ipv4.tcp_syncookies": 1,
    # Don't accept ICMP redirect messages
    "net.ipv4.conf.all.accept_redirects": 0,
    # Don't send ICMP redirect messages
    "net.ipv4.conf.all.send_redirects": 0,
    # Enable source address spoofing protection
    "net.ipv4.conf.all.rp_filter": 1,
    # Log packets with impossible source addresses
    "net.ipv4.conf.all.log_martians": 1,
}


class Scope(Flag):
    LOCALHOST = auto()
    DOCKER = auto()
    ALL = LOCALHOST | DOCKER

    @classmethod
    def list(cls):
        return cls._member_names_


SCOPE_NAMES_LIST = ", ".join(["`" + scope.lower() + "'" for scope in Scope.list()])
MAX_MULTIPORT_ELEMS = 15
IPTABLES_RULES_FILE: Path = Path("/etc/iptables/iptables.rules")


class Defaults:
    PROFILE_FILE: Optional[Path] = CURRENT_PATH / "default.profile"


class Arguments:
    __slots__ = (
        "profile_file",
        "noconfirm",
        "nopersist",
        "persist",
    )

    def __init__(self):
        self.profile_file: Optional[Path] = Defaults.PROFILE_FILE


class ScopePortInfo:
    __slots__ = ("scope", "protocol_with_ports_arg")

    def __init__(self, scope: Scope, protocol_with_ports_arg: str):
        self.scope: Scope = scope
        self.protocol_with_ports_arg: str = protocol_with_ports_arg


def parse_arguments() -> Arguments:
    arg_parser: argparse.ArgumentParser = argparse.ArgumentParser(
        prog=MAIN_CMD_NAME,
        formatter_class=argparse.RawTextHelpFormatter,
        description="Configure network isolation of localhost "
        + "by changing system parameters and modifying iptables rules",
    )
    arg_parser.add_argument(
        "--profile-file",
        "-p",
        help=(
            f"Path to profile file (DEFAULT VALUE: {Defaults.PROFILE_FILE}),\n"
            + "this file should be a simple text file with lines\nhaving the following format:\n"
            + "\n"
            + "<scope> <protocol> <port(s)>\n"
            + "\n"
            + f"here <scope> equals either to one of {SCOPE_NAMES_LIST},\n"
            + "<protocol> may be given by number or name (e.g. `tcp', `udp')\n"
            + "while <port(s)> contains either a single port or a port range\n"
            + "given as <start-port>:<end-port> or a comma-separated list of\n"
            + f"ports and port ranges, but their number should not exceed {MAX_MULTIPORT_ELEMS}\n"
            + "(see multiport module of iptables for details), each port is allowed\n"
            + "for external access in INPUT, DOCKER-USER chains or both of them\n\n"
        ),
    )
    arg_parser.add_argument(
        "--noconfirm",
        action="store_true",
        help="Modify system parameters and iptables rules without confirmation\n\n",
    )
    arg_parser.add_argument(
        "--nopersist",
        action="store_true",
        help=(
            "Modify system parameters and iptables rules in a not persistent way\n"
            + "(system reboot reverts the changes), may be used for validation,\n"
            + "if something goes wrong it is sufficient to reboot to\n"
            + "restore previous parameters\n\n"
        ),
    )
    arg_parser.add_argument(
        "--persist",
        action="store_true",
        help=(
            "Modify system parameters and iptables rules in a persistent way\n"
            + "so that the changes are kept after system reboot.\n"
            + "In the case --noconfirm is passed while\n"
            + "--nopersist is not passed, the behavior is the same as if\n"
            + "--persist is given\n\n"
        ),
    )
    arg_parser.add_argument(
        "--run",
        action="store_true",
        required=True,
        help=(
            "Should be given to proceed with modifications,\n"
            + "otherwise help is displayed, this is just for safety\n\n"
        ),
    )
    if len(sys.argv) == 1:
        arg_parser.print_help(sys.stderr)
        print(f"{MAIN_CMD_NAME}: error: the following argument is required: --run")
        sys.exit(1)
    inp_args = arg_parser.parse_args()
    if inp_args.nopersist and inp_args.persist:
        arg_parser.error("--nopersist and --persist can not be given together")
    processed_args: Arguments = Arguments()
    processed_args.profile_file: Optional[Path] = Path(
        inp_args.profile_file
    ) if inp_args.profile_file else Defaults.PROFILE_FILE
    processed_args.noconfirm: bool = inp_args.noconfirm
    processed_args.nopersist: bool = inp_args.nopersist
    processed_args.persist: bool
    if inp_args.noconfirm and not inp_args.nopersist:
        processed_args.persist = True
    else:
        processed_args.persist = inp_args.persist
    return processed_args


def confirm(text: str, default: bool = False):
    prompt: str = f"{text} [{default and 'Y/n' or 'y/N'}]: "
    while True:
        try:
            value = input(prompt).lower().strip()
        except (KeyboardInterrupt, EOFError):
            sys.exit(0)
        if value in ("y", "yes"):
            confirm_answer = True
        elif value in ("n", "no"):
            confirm_answer = False
        elif value == "":
            confirm_answer = default
        else:
            print("Error: invalid input")
            continue
        break
    return confirm_answer


if __name__ == "__main__":
    __args: Arguments = parse_arguments()

    logging.basicConfig(format="%(asctime)-15s %(message)s")
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.DEBUG)

    def exec_shell_command(
        command_str: str, return_exit_code: bool = False,
    ):
        def log_subprocess_output(pipe: IO, subp_logger: logging.Logger):
            for line in iter(pipe.readline, b""):  # b'\n'-separated lines
                subp_logger.info(line.decode("utf-8", "replace").rstrip("\r\n"))

        proc: subprocess.Popen = subprocess.Popen(
            [command_str], shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT
        )
        with proc.stdout:
            log_subprocess_output(proc.stdout, logger)
        call_res: int = proc.wait()
        if return_exit_code:
            return call_res
        elif call_res != 0:
            raise Exception(
                f'Execution of command "{command_str}" failed with exit code {call_res}'
            )

    if (
        not sys.platform.startswith("linux")
        or shutil.which("pacman") is None
        or shutil.which("sysctl") is None
        or shutil.which("iptables") is None
        or shutil.which("iptables-save") is None
    ):
        logger.fatal("This tool should be executed only on Arch Linux or Arch-based OS")
        sys.exit(1)
    for firewall_service in FIREWALL_SERVICES_CHECK_TO_BE_INACTIVE_LIST:
        if (
            exec_shell_command(
                f"systemctl is-active {firewall_service} > /dev/null",
                return_exit_code=True,
            )
            == 0
        ):
            logger.fatal(
                f"Firewall service {firewall_service} should be inactive, please execute the following:\n"
                + f"\nsudo systemctl stop {firewall_service}\nsudo systemctl disable {firewall_service}\n"
            )
            sys.exit(1)
    if not __args.noconfirm and not confirm(
        "!!!!!!!!!!!!!!!!!!!!!!!!!! ATTENTION !!!!!!!!!!!!!!!!!!!!!!!!!!\n"
        + "This tool should be used with caution as it modifies system\n"
        + "parameters and iptable configuration, the changes are applyed to\n"
        + "in-memory configurations only and will be lost after the systerm reboot.\n"
        + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
        + "Are you sure you want to continue?",
        default=False,
    ):
        sys.exit(0)

    __allowed_port_info_list: List[ScopePortInfo] = []
    if __args.profile_file is not None:
        if not __args.profile_file.exists():
            if __args.noconfirm:
                logger.warning(
                    f"Profile file {__args.profile_file} is not found, "
                    + "no additional ports given by profiles are assumed to be allowed for external access"
                )
            elif not confirm(
                "!!!!!!!!!!!!!!!!!!!!!!!!!! ATTENTION !!!!!!!!!!!!!!!!!!!!!!!!!!\n"
                + f"Profile file {__args.profile_file} is not found, the execution\n"
                + "may be continued only with the assumption that no additional\n"
                + "ports (potentially given by this absent profile file) are to be\n"
                + "allowed for external access, again currently only for in-memory\n"
                + "changes that will be lost after the system reboot.\n"
                + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
                + "Are you sure you want to continue with this assumption?",
                default=False,
            ):
                sys.exit(1)
        else:
            with open(__args.profile_file, "r") as f:
                i_line: int = -1
                for inp_line in f:
                    i_line += 1
                    error_str: str = f"Line #{i_line} of {__args.profile_file} has wrong format:\n\n{inp_line}\n"
                    processed_line: str = inp_line
                    if "#" in processed_line:  # remove comments
                        processed_line = processed_line.split("#", 1)[0]
                    processed_line = processed_line.strip()
                    if len(processed_line) == 0:  # not to process empty lines
                        continue
                    val_list: List[str] = processed_line.split(" ")
                    if len(val_list) != 3:
                        logger.fatal(
                            error_str
                            + "Not enough parameters, see help for details"
                        )
                        sys.exit(1)
                    port_info_dict = {}
                    scope_str: str = val_list[0].upper().strip()
                    if scope_str not in Scope.list():
                        logger.fatal(
                            error_str
                            + f"Scope `{scope_str}' is wrong, it should be one of {SCOPE_NAMES_LIST}"
                        )
                    scope: Scope = Scope[scope_str]
                    protocol: str = val_list[1].lower().strip()
                    if not protocol.isalpha():
                        logger.fatal(
                            error_str
                            + f"Protocol `{protocol}' is wrong, see help for details"
                        )
                    ports_str: str = val_list[2].strip()
                    if ports_str.isdigit():
                        ports_str = f"--dport {ports_str}"
                    else:
                        ports_info_list = ports_str.split(",")
                        if not all(
                            [
                                ports_info.isdigit()
                                or (
                                    ports_info.count(":") == 1
                                    and ports_info[0] != ":"
                                    and ports_info[-1] != ":"
                                    and ports_info.replace(":", "").isdigit()
                                )
                                for ports_info in ports_info_list
                            ]
                        ):
                            logger.fatal(
                                error_str
                                + f"Ports {ports_str} are wrong, see help for details"
                            )
                            sys.exit(1)
                        if len(ports_info_list) > MAX_MULTIPORT_ELEMS:
                            logger.fatal(
                                error_str
                                + f"Number of ports and port ranges in {ports_str} exceeds {MAX_MULTIPORT_ELEMS}, "
                                + "see help for details"
                            )
                            sys.exit(1)
                        ports_str = f"-m multiport --dports {ports_str}"
                    __allowed_port_info_list.append(
                        ScopePortInfo(scope, f"-p {protocol} {ports_str}")
                    )

    try:
        logger.info("Modifying system parameters...")
        for sys_param_name, sys_param_val in SYS_PARAMS_DICT.items():
            exec_shell_command(f"sysctl {sys_param_name}={sys_param_val}")
        logger.info("Modifying system parameters: done")
        logger.info("Modifying iptables rules...")
        # Check whether DOCKER-USER chain exists, if not, create this chain
        if (
            exec_shell_command(
                "/sbin/iptables -n --list DOCKER-USER >/dev/null 2>&1",
                return_exit_code=True,
            )
            != 0
        ):
            exec_shell_command("/sbin/iptables -N DOCKER-USER")
        # Flush all necessary chains
        exec_shell_command("/sbin/iptables -F INPUT")
        exec_shell_command("/sbin/iptables -F DOCKER-USER")
        exec_shell_command("/sbin/iptables -F OUTPUT")
        # Allow unlimited traffic on the loopback interface
        exec_shell_command("/sbin/iptables -A INPUT -i lo -j ACCEPT")
        exec_shell_command("/sbin/iptables -A OUTPUT -o lo -j ACCEPT")
        # Set default policies
        exec_shell_command("/sbin/iptables --policy INPUT DROP")
        exec_shell_command("/sbin/iptables --policy OUTPUT DROP")
        exec_shell_command("/sbin/iptables --policy FORWARD DROP")
        # Previously initiated and accepted exchanges bypass rule checking
        # Allow unlimited outbound traffic
        exec_shell_command(
            "/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT"
        )
        exec_shell_command(
            "/sbin/iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT"
        )
        logger.info("Modifying iptables rules: done")
        # Ratelimit SSH for attack protection
        exec_shell_command(
            "/sbin/iptables -A INPUT -p tcp --dport 22 -m state --state NEW "
            + "-m recent --update --seconds 60 --hitcount 4 -j DROP"
        )
        exec_shell_command(
            "/sbin/iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set"
        )
        exec_shell_command(
            "/sbin/iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT"
        )
        # Add rules for Docker
        exec_shell_command(
            "/sbin/iptables -A DOCKER-USER -m state --state ESTABLISHED,RELATED -j ACCEPT"
        )
        for allowed_port_info in __allowed_port_info_list:
            if Scope.DOCKER in allowed_port_info.scope:
                exec_shell_command(
                    f"/sbin/iptables -A DOCKER-USER {allowed_port_info.protocol_with_ports_arg} "
                    + "-m state --state NEW -j ACCEPT"
                )
        exec_shell_command(
            "ip route | grep '^default' | grep -Po '(?<=(dev )).*(?= src| proto)' | "
            + "xargs -I {} /sbin/iptables -A DOCKER-USER -i {} ! -s 127.0.0.1 -j DROP"
        )
        exec_shell_command("/sbin/iptables -A DOCKER-USER -j RETURN")
        # Allow certain ports to be accessible from the outside
        for allowed_port_info in __allowed_port_info_list:
            if Scope.LOCALHOST in allowed_port_info.scope:
                exec_shell_command(
                    f"/sbin/iptables -A INPUT {allowed_port_info.protocol_with_ports_arg} "
                    + "-m state --state NEW -j ACCEPT"
                )
        # Allow pinging of your server
        exec_shell_command(
            "/sbin/iptables -A INPUT -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT"
        )
        # Drop all other traffic
        exec_shell_command("/sbin/iptables -A INPUT -j DROP")
        # print the activated rules to the console when script is completed
        exec_shell_command("/sbin/iptables -nL")
        if __args.nopersist:
            sys.exit(0)

        def get_sys_params_conf_file_name_lexicographically_greater_than_given(
            conf_file_name: str,
        ):
            if len(conf_file_name) == 0:
                sys_params_file_prefix = "99-"
            else:
                sys_params_file_prefix = ""
                conf_file_prefix: str = ""
                elem: str
                i_char: int = 0
                n_chars: int = len(conf_file_name)
                for idx_char in range(i_char, n_chars):
                    elem = conf_file_name[idx_char]
                    if not elem.isdigit():
                        i_char = idx_char
                        break
                    else:
                        conf_file_prefix += elem
                        sys_params_file_prefix += "9"
                if conf_file_prefix < sys_params_file_prefix or elem < "-":
                    sys_params_file_prefix += "-"
                else:
                    if elem == "-":
                        sys_params_file_prefix += "9-"
                    else:
                        for idx_char in range(i_char, n_chars):
                            elem = conf_file_name[idx_char]
                            if elem < "z":
                                sys_params_file_prefix += "z-"
                                break
                            else:
                                conf_file_prefix += elem
                                sys_params_file_prefix += "z"
                        if len(conf_file_prefix) == n_chars:
                            sys_params_file_prefix += "-"
            return sys_params_file_prefix + sys_params_conf_file_suffix

        sys_params_conf_file_name: Optional[Path] = None
        iptables_rules_backup_file: Optional[Path] = None
        if not __args.persist:
            sys_params_conf_file_suffix = f"net_isolation_{uuid.getnode()}.conf"
            last_conf_file_name: str = ""
            for sysctl_folder in SYSCTL_FOLDERS:
                conf_file_name_list = sorted(
                    [
                        conf_file_name
                        for conf_file_name in glob.glob(str(sysctl_folder / "*.conf"))
                        if not conf_file_name.endswith(sys_params_conf_file_suffix)
                    ]
                )
                if len(conf_file_name_list) > 0:
                    cur_last_conf_file_name = Path(conf_file_name_list[-1]).name
                    if last_conf_file_name < cur_last_conf_file_name:
                        last_conf_file_name = cur_last_conf_file_name
            sys_params_conf_file_name: Path = SYSCTL_FOLDERS[
                0
            ] / get_sys_params_conf_file_name_lexicographically_greater_than_given(
                last_conf_file_name
            )

            if IPTABLES_RULES_FILE.exists():
                iptables_rules_backup_file: Path = IPTABLES_RULES_FILE.parent / (
                    IPTABLES_RULES_FILE.name + ".backup"
                )
                if iptables_rules_backup_file.exists():
                    iptables_rules_backup_file_prefix: str = str(
                        iptables_rules_backup_file
                    )
                    iptables_rules_backup_file_prefix_len: int = len(
                        iptables_rules_backup_file_prefix
                    )
                    suffices_list: List[str] = [
                        iptables_rules_backup_file_name[
                            iptables_rules_backup_file_prefix_len:
                        ]
                        for iptables_rules_backup_file_name in glob.glob(
                            iptables_rules_backup_file_prefix + "*"
                        )
                    ]
                    int_suffices_list: List[int] = [
                        int(suffix) for suffix in suffices_list if suffix.isdigit()
                    ]
                    if len(int_suffices_list) == 0:
                        iptables_rules_backup_file = IPTABLES_RULES_FILE.parent / (
                            IPTABLES_RULES_FILE.name + ".backup1"
                        )
                    else:
                        iptables_rules_backup_file = IPTABLES_RULES_FILE.parent / (
                            IPTABLES_RULES_FILE.name
                            + ".backup"
                            + str(max(int_suffices_list) + 1)
                        )

            if __args.nopersist or not confirm(
                "!!!!!!!!!!!!!!!!!!!!!!!!!! ATTENTION !!!!!!!!!!!!!!!!!!!!!!!!!!\n"
                + "The next step is to make the modified system parameters and\n"
                + "iptables rules persistent between boots, to do this created are\n"
                + f"{sys_params_conf_file_name} setting\n"
                + "necessary system parameters (to rollback these changes you will\n"
                + "need just to delete this file and to reboot the computer) and\n"
                + f"{IPTABLES_RULES_FILE} with all modified iptables rules"
                + (
                    "\n"
                    if iptables_rules_backup_file is None
                    else f",\nold file {IPTABLES_RULES_FILE} will be copied to backup\n"
                    + f"file {iptables_rules_backup_file} (to rollback these\n"
                    + f"changes just replace new {IPTABLES_RULES_FILE} by\n"
                    + f"{iptables_rules_backup_file} and reboot the computer)\n"
                )
                + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
                + "Are you sure you really want to make the above changes?",
                default=False,
            ):
                sys.exit(0)

        with open(sys_params_conf_file_name, "wt") as f:
            for sys_param_name, sys_param_val in SYS_PARAMS_DICT.items():
                f.write(f"{sys_param_name} = {sys_param_val}\n")
        logger.info(
            f"Created {sys_params_conf_file_name}, if you need to rollback changed system parameters, "
            + "just delete this file and reboot the computer"
        )

        if iptables_rules_backup_file is not None:
            shutil.copyfile(str(IPTABLES_RULES_FILE), str(iptables_rules_backup_file))
            logger.info(
                f"Copied old file {IPTABLES_RULES_FILE} to backup file {iptables_rules_backup_file}, "
                + "if you need to rollback changed iptables rules, just replace "
                + f"new {IPTABLES_RULES_FILE} by {iptables_rules_backup_file} and reboot the computer"
            )

        exec_shell_command(f"iptables-save > {IPTABLES_RULES_FILE}")
        logger.info(f"Saved modified iptables rules to {IPTABLES_RULES_FILE}")
        exec_shell_command("systemctl enable iptables")
        logger.info(
            "Enabled iptables service to make modified iprules persistent between boots"
        )
    except Exception as exc:
        logger.fatal(exc)
        sys.exit(1)
