# Few topics for VNC usage
## 1. Client application
Client application to connect VNC must be RealVNC Viewer (for Windows); Remmina (for Linux)
## 2. Replace password for VNC session

> x11vnc --storepasswd **Passw0rd** /etc/x11vnc.passwd 

## 3. Keyboard errors
**3.1.** To troubleshoot the transmission of keyboard presses through VNC, you must:


Create a file (for example, fix.sh) with the contents in any convenient place


> #!/bin/sh 


> xmodmap -e "keycode 59 = 0x002c 0x003c 0x06c2 0x06e2"


> xmodmap -e "keycode 60 = 0x002e 0x003e 0x06c0 0x06e0"


> xmodmap -e "keycode 94 = 0x003c 0x003c 0x06c2 0x06e2"

In the "Start menu", in the search, write autostart,
In the window that opens, click the "Add script" button
Select the script we created in the previous step.
Select a way to use the "Startup" script (when loading).
On the host (home) machine, English should always be selected; the layout should be changed only on the remote machine.

**3.2.** To solve problems with sticky keys, we can use several methods:

**a)** manually, in the console, if you need to enable this functionality, enter the command

> xset r on

Checking the state change

>xset q

**b)** in the VNC server configuration settings (you need to add the ** - repeat ** key) - this will automatically enable the "sticky" keyboard option

## 4. Screen_Blinking

You must go to the Start menu


Find and select System Settings


Then, go to the Display and Monitor section


Select Compositor:


=>  Rendering backend == XRender


=>  Scale method == Crisp

