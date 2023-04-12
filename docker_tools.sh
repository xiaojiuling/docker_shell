#!/bin/bash
function jdt(){
i=0
str=""
label=('|' '/' '-' '\\')
index=0
while [ $i -le 20 ]
do
    let index=i%4
    let jinshu=$i*5
    printf "\e[47m\e[31m[%-20s]\e[0m\e[47;32m[%c]\e[1;0m\e[47;35m[%-3d%%]\e[1;0m\r" $str ${label[$index]} $jinshu
    let i++
    str+="#"
    sleep 0.1
done
echo
echo "正在执行>>>>>>>请稍后"
}
