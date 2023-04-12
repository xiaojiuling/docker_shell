#!/bin/bash
source ./docker_cs.sh
source ./docker_disply.sh
function image(){
    docker version >/dev/null 2>&1
    ver=$?
    docker_cs2 $ver
    docker images | awk '{printf("| %-10s | %-7s| %-7s|\n", $1, $2, $NF)}' | sed -r 's#REPOSITORY#镜像#g' | sed -r 's#TAG#标签#g' | sed -r 's#SIZE#镜像大小#g' | column -t
}

function dis_image(){
    echo "——————————————————————————————————————————"
    echo "1、查看当前镜像         2、 导出镜像"
    echo "0、返回上一步操作"
    echo "——————————————————————————————————————————"
    read -p "请输入需要执行的操作：" zhi
   case "${zhi}" in
    1)
        image
        dis_image
    ;;
    2)
        save_image
    ;;
    0)
        display
    ;;
    *)
        echo "序号错误，请重新输入"
        dis_image
    ;;
   esac
   
}

function save_if_image(){
if [[ $pwd_image =~ (.*\.tar$) ]]; then    
    docker save -o $pwd_image $name_image >/dev/null 2>&1
      if [ $? -eq 1 ];then
         echo '请检查镜像是否存在,或路径是否正确'
        dis_image
        fi
  else
    echo "导出的必须是.tar文件"
    save_image
  fi
}

function save_image(){
    read -p "请输入需要保存的路径（默认文件为/tmp/out.tar,格式:/tmp/名称.tar或者./名称.tar):" pwd_image
    read -p "请输入导出的镜像名称,(默认是latest标签,如果标签不一样请加上标签，如:mysql:5.7):" name_image
if [ -z $pwd_image ];then
    pwd_image='/tmp/out.tar'
    save_if_image
    else
    save_if_image
fi
}