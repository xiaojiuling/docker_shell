
function container_shell(){
  read -p "请输入需要查看信息信息容器的名称" con_name_inst
  name=$(docker ps |awk -F'[ ][ ]+' 'NR!=1{print $NF}')
  array=($name)
  for xyz in ${array[*]}; do
  if [[ "${xyz}" == "${con_name_inst}" ]]; then
    read -p '请输入你需要容器执行的命令，如：bash,ls等' con_com
    mod_if_shell $con_com $con_name_inst
  fi
  done
  # else
    echo "输入的容器名错误，请重新输入"
    container_shell
}
function mod_if_shell(){
  if [[ $1 == 'bash'  ]]; then
  echo abcd
  docker exec -it $2 bash
  elif [[ $1 == 'sh' ]]; then
  docker exec -it $2 sh
  else
  docker exec $con_name_inst $con_com
  fi
  dis_container
}
function container_inspect(){
    gateway=$(docker inspect $1 |grep '"Gateway":'|awk -F'["]' 'NR==1{print $4}')
    ipadd=$(docker inspect $1 |grep '"IPAddress":'|awk -F'["]' 'NR==1{print $4}')
    macadd=$(docker inspect $1 |grep '"MacAddress":'|awk -F'["]' 'NR==1{print $4}')
    mak=$(docker inspect $1 |grep '"IPPrefixLen":'|awk -F'[: ]|[,]' 'NR!=1{print $23}')
    port=$(docker ps |grep $1|awk -F'[ ][ ]+' '{print $6}')
    network=$(docker inspect $1 |grep -A1 Networks|awk -F'["]' 'NR!=1{print $2}')
    driver=$(docker network ls|awk -F'[ ][ ]+' '$2~/'$network'/{print $3}')
    volue=$(docker inspect $1 |grep -A1 Binds|awk -F'["]' 'NR!=1{print $2}'|sed 's/ContainerIDFile/无任何挂载/g')
    echo -e "网络名称及类型 $network $driver  \nip地址 $ipadd/$mak \n网关地址 $gateway\n端口映射信息 $port \n数据卷挂载 $volue"|column -t
    dis_container
}
function con_name_if(){
  read -p "请输入需要查看信息信息容器的名称" con_ins_name
  name=$(docker ps |awk -F'[ ][ ]+' 'NR!=1{print $NF}')
  array=($name)
  for xyz in ${array[*]}; do
  if [[ "${xyz}" == "${con_ins_name}" ]]; then
    container_inspect $con_ins_name
  fi
  done
  # else
    echo "输入的容器名错误，请重新输入"
    con_name_if
}

