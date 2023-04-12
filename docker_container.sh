#/bin/bash
# function dis_run_container(){
    
# }
function dis_container(){
    echo "——————————————————————————————————————————"
    echo "1、查看当前启动容器     2、 执行容器内命令"
    echo "3、查看某个容器信息     4、 常用容器部署"
    echo "5、删除存在的容器             0、返回上一步操作"
    echo "——————————————————————————————————————————"
    read -p "请输入需要执行的操作：" rq
      case "${rq}" in
    1)
        docker ps |awk -F'[ ][ ]+' '{printf("| %-15s| %-60s| %-20s|\n", $1, $2,$NF)}'|sed 's/CONTAINER ID/容器ID/g'|sed 's/IMAGE/来源镜像/g'|sed 's/PORTS/端口/g'|sed 's/NAMES/容器名/g'|column -t
        docker_cs2 $?
        dis_container
    ;;
    2)
       container_shell
    ;;
    3)
        con_name_if
    ;;
    4)
      container_run
    ;;
    5)
     container_remove
    ;;
    0)
        display
    ;;
    *)
        echo "序号错误，请重新输入"
        dis_container
    ;;
   esac
}