function input(){
        read -p "请输入容器映射主机的端口：" port
        read -p "请输入容器的名称：" name
       if [ -z "$port" ]; then
        echo "请勿输入空值"
        container_run
       fi
        if [ -z "$name" ]; then
        echo "请勿输入空值"
        container_run
       fi
}
function shuju_con(){
    read -p "是否需要设置数据卷映射，请输入yes或者no" vol_con
    if [[ $vol_con == "no" ]]; then
   echo 'text here'
   
    fi
}
function output(){
     echo "已经完成部署$name容器，端口：$port"
}
function kms(){
    docker run -d -p $1:1688 --restart=always --name $2 mikolatero/vlmcsd >/dev/null 2>&1
    error="$?"
    docker_cs2 $error
}
function httpd(){
    docker run -d -p $1:80 --name $2 httpd >/dev/null 2>&1
    error="$?"
    docker_cs2 $error
}
function php(){
    docker run -d -p $1:9000 --name $2 php:8.2-fpm >/dev/null 2>&1
    error="$?"
    docker_cs2 $error
}
function mysql(){
    read -p "请输入mysql数据的root密码：" password
    if [[ "${password}" == " " ]]; then
    echo "请勿输入空值"
    container_run
    fi
    docker run -d -e MYSQL_ROOT_PASSWORD=$password -p $1:3306 --name $2 mysql >/dev/null 2>&1
        error="$?"
    docker_cs2 $error
}
function tomcat(){
        docker run -d -p $1:8080 --name $2 tomcat:8.0.22-jre8 >/dev/null 2>&1
        error="$?"
    docker_cs2 $error
}
function alist(){
    docker run -d -p $1:5244 --name $2 xhofe/alist:latest >/dev/null 2>&1
    error="$?"
    docker_cs2 $error
    sleep 5
    echo "$(cat $(docker inspect --format='{{.LogPath}}' $2)|grep password |awk '{print $6,$13}')"

}
function nginx(){
        docker run -d -p $1:80 --name $2 nginx >/dev/null 2>&1
        error="$?"
    docker_cs2 $error
}
function container_run(){
    echo "——————————————————————————————————————————"
    echo "1、httpd     2、php-fpm"
    echo "3、mysql     4、tomcat "
    echo "5、alist     6、kms    "
    echo "7、nginx     8、返回上一级"
    echo "——————————————————————————————————————————"
    read -p "请输入你的操作需要部署的容器：" run
    case "${run}" in
    1)
        input
        httpd $port $name 
        output
    ;;
    2)
        input
        php $port $name 
        output
    ;;
    3)
        input
        mysql $port $name 
        output
    ;;
    4)
        input
        tomcat $port $name 
        output
    ;;
    5)
        input
        alist $port $name 
        output
    ;;
    6)
        input
        kms $port $name 
        output
    ;;
    7)
        input
        nginx $port $name 
        output
    ;;
    8)
        dis_container
    ;;
    *)
        echo '请输入正确的序号'
        dis_container
   esac
}