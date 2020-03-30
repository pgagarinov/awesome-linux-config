#!/bin/bash
# specify number of browser sessions as input parameter
set -e
./cm selenoid stop
./cm selenoid cleanup
./cm selenoid-ui stop
./cm selenoid-ui cleanup
./cm selenoid start --browsers "chrome:75" --last-versions 2 --tmpfs 512 --vnc --port 4444 --args "-limit $1"
./cm selenoid-ui start --args "--period 1000ms" --port 8080

