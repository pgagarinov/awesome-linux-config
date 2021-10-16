#!/bin/bash
# specify number of browser sessions as input parameter
set -e
N_MAX_SESSIONS=24
./cm selenoid stop
./cm selenoid cleanup
./cm selenoid-ui stop
./cm selenoid-ui cleanup
./cm selenoid start --browsers "chrome:75" --last-versions 2 --tmpfs 1024 --vnc --port 4444 --args "-limit $N_MAX_SESSIONS"
./cm selenoid-ui start --args "--period 1000ms" --port 8080

