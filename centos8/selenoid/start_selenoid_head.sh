#!/bin/bash
set -e
LOCAL_IP=`hostname -I | awk '{print $1}'`
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
#

docker stop ggr||true&&docker rm ggr||true
docker stop ggr-ui||true&&docker rm ggr-ui||true

./cm selenoid stop
./cm selenoid cleanup
./cm selenoid-ui stop
./cm selenoid-ui cleanup

./cm selenoid start --browsers "chrome:75" --last-versions 2 --tmpfs 512 --vnc --port 4445 --args "-limit 24"
docker run -d --name ggr -p 4444:4444 -v ${SCRIPT_DIR}/selenoid_quotas:/etc/grid-router/quota:ro aerokube/ggr:latest-release
docker run -d --name ggr-ui -p 8888:8888 -v ${SCRIPT_DIR}/selenoid_quotas:/etc/grid-router/quota:ro aerokube/ggr-ui:latest-release
./cm selenoid-ui start --args "--period 1000ms --selenoid-uri=http://${LOCAL_IP}:8888" --port 8080
