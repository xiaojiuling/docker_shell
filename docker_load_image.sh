#!/bin/bash
function load_image(){
    read -p "请输入导入的.tar文件,(如：/tmp/out.tar ./out.tar):" load_file
  if [[ $load_file =~ (.*\.tar$) ]]; then
    docker load -i $load_file
    if [ $? -eq 1 ];then
    echo '请检查导入的文件或者目录是否正确'
    load_image
    fi
    else
    echo "导入的必须是.tar文件"
    load_image
  fi
}
