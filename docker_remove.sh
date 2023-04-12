function container_remove(){
  read -p "请输入需要删除的容器名称，删除全部容器输入(container_any)" con_remove_name
  if [[ "${con_remove_name}" == "container_any" ]]; then
    docker rm -f $(docker ps -aq)
    echo "已全部删除"
  else
    if_remove $con_remove_name
  fi
}

function if_remove(){
  name=$(docker ps | awk 'NR!=1{print $NF}')
  if [[ -z "${name// }" ]]; then
    echo "没有容器存在"
    return
  fi
  for xyz in ${name[*]}; do
    if [[ "${xyz}" == "${1}" ]]; then
      docker rm -f $1
      echo "容器${1}已成功删除"
      return
    fi
  done
  echo "输入的容器名错误，请重新输入"
  container_remove
}