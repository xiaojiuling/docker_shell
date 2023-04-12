#!/bin/bash
# source ./start.sh
function docker_cs1(){
  if [ $1 -ne 0 ]; then
    echo "请检查网络或者配置"
    display
  fi
}
function docker_cs2(){
    if [ $1 -eq 127 ]; then
        echo '命令不存在，检查docker是否安装'
        exit
    elif [ $1 -eq 125 ];then
        echo "1、请检查端口是否冲突"
        echo "2、请检查容器名称是否冲突"
        echo "3、请检查容器名称是否符合规范，[a-zA-Z0-9][a-zA-Z0-9_.-]"
        exit
    fi 
}
function shuzi (){              ##通过正则表达式来对输入的参数进行判断是否满足1-12
    # if [[ $1 =~ (^[0-9]$)|(^1[0-2]$) ]]; then
    if [[ $1 =~ (^[0-6]$) ]]; then
    # echo "shuzi() ok"
    shili $1
else 
    echo "序号错误，请重新输入"
    display
fi
}