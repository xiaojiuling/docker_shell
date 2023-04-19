#!/bin/bash
function shili(){
   case "${1}" in
    1)
    cs_start
    jdt
    start >/dev/null 2>&1
    docker_cs1 $?
    echo "完成安装"
    display
    ;;
    2)
    jdt
    docker_unstall >/dev/null 2>&1
    docker_cs1 $?
    echo "完成卸载"
    display
    ;;
    3)
    dis_image
    
        # input
        # kms $port $name
        # jdt 
        # output
    ;;
    4)
    load_image
    echo "导入完成"
    ;;
    5)
    dis_container
    ;;
    6)
     echo "感谢使用,如有问题联系2678857625@qq.com"
        exit
    ;;
   esac
}
function display () {
echo "###########################################"
echo "1、docker工具安装         2、 docker工具卸载"
echo "3、image镜像导出          4、 image镜像导入"
echo "5、docker容器管理         6、 退出该程序"
echo "###########################################"
read -p "请输入您的需求：" id
shuzi $id
}