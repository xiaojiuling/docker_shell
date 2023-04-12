#/bin/bash
pid=$(ps -p 1 |grep 1 |cut -d " " -f 17)
# echo $pid
core=$(uname -r |sed -r 's#([0-6]).([0-9]+).[0-9]-.*#\1\2#g')
# echo ${core:0:4}
function docker_chack(){
if [[ "${pid}" == "systemd" ]]; then
    if (( ${core} >= 310 )); then
        download_docker
    else
        echo '内核版本不足'
    fi
else 
    echo "该系统pid(1)不是由systemd进行管理"  
fi
}

function download_docker () {
    wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz && tar -xvf docker-20.10.9.tgz  && cp ./docker/* /bin/ &&rm -rf docker docker-20.10.9.tgz
    cat>>/etc/systemd/system/docker.service<<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=infinity
LimitNPROC=infinity
TimeoutStartSec=0
Delegate=yes
KillMode=process
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
EOF
chmod +x /etc/systemd/system/docker.service
systemctl daemon-reload
systemctl start docker
docker run hello-world
}


function docker_compos_install () {
    curl -SL http://www.mywjh.cn:5244/d/data/%E5%B7%A5%E5%85%B7%E8%BD%AF%E4%BB%B6/Linux/docker/docker-compose/docker-compose-linux-x86_64?sign=Qadgxa5_eO4zxQ0NmcPcq63RuaGRlEyZv8JKE8bM-cw=:0 -o /usr/local/bin/docker-compose
  if [ $? -ne 0 ]; then
    curl -SL https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
  fi
    chmod 777 /usr/local/bin/docker-compose
}


function wget_chack () {
rpm -qa | grep wget
if [ $? -eq 0 ]; then
    docker_chack
    docker_compos_install
else
yum install wget -y
wget_chack
fi
}

function start(){
wget_chack

echo -e "\033[0;31;40m恭喜你已完成docker及docker-compose的安装\033[0m"
 
}
function cs_start(){
if [ -f "/bin/docker" ]; then
    echo "已安装docker"
    display
fi
}

