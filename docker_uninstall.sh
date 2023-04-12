#!/bin/bash
function docker_unstall(){
  killall dockerd >/dev/null 2>&1
  sleep 5s
  if [ $? -le 1 ]; then
    rm -rf /bin/containerd /bin/containerd-shim /bin/containerd-shim-runc-v2 /bin/ctr /bin/docker /bin/dockerd /bin/docker-init /bin/docker-proxy /bin/runc /etc/systemd/system/docker.service /etc/firewalld/zones/docker.xml /etc/docker /usr/lib/firewalld/services/docker-registry.xml /usr/lib/firewalld/services/docker-swarm.xml
    rm -rf /run/docker
    rm -rf /var/lib/docker
    rm -rf /usr/local/bin/docker-compose
  fi
}