#!/bin/bash
if [ `id -u` -eq 0 ]
then
	:
else
	echo -e "\033[32m请用root用户执行本脚本!\033[0m"
        exit
fi

option1(){
echo "请输入端口:"
read -p ">>" port
echo "请输入域名(确保已解析到本机IP):"
read -p ">>" domain
echo "请输入ssl公钥路径:"
read -p ">>" pem
echo "请输入ssl私钥路径:"
read -p ">>" key
echo "请输入obfs:"
read -p ">>" obfs
echo "请输入上传限速,单位为m:"
read -p ">>" up_mbps
echo "请输入下载限速,单位为m:"
read -p ">>" down_mbps
cat>config.json<<EOF
{
  "listen": ":${port}",
  "cert": "${pem}",
  "key": "${key}",
  "obfs": "${obfs}",
  "up_mbps": ${up_mbps},
  "down_mbps": ${down_mbps}
}
EOF


}
echo -e "\033[32m欢迎使用hysteria一键安装脚本\033[0m"
echo -e "\033[32m脚本仅支持debian/ubuntu系统!\033[0m" 
echo -e "\033[32m请选择系统架构\033[0m" 
echo 1.amd64
echo 2.arm64
echo 3.arm
echo 4.i386
echo 0.退出脚本
read -p ">>" m1
if	[ "$m1" == 1 ]
then
	wget https://github.com/HyNetwork/hysteria/releases/download/v0.9.4/hysteria-tun-linux-amd64
  chmod 777 hysteria-tun-linux-amd64
  mv hysteria-tun-linux-amd64 hysteria
  option1
  ./hysteria server
elif	[ "$m1" == 2 ]
then
	wget https://github.com/HyNetwork/hysteria/releases/download/v0.9.4/hysteria-tun-linux-arm64
  chmod 777 hysteria-tun-linux-arm64
  mv hysteria-tun-linux-arm64 hysteria
  option1
  ./hysteria server		
elif	[ "$m1" == 3 ]
then
	wget https://github.com/HyNetwork/hysteria/releases/download/v0.9.4/hysteria-tun-linux-arm-7
  chmod 777 hysteria-tun-linux-arm-7
  mv hysteria-tun-linux-arm-7 hysteria
  option1
  ./hysteria server
elif	[ "$m1" == 4 ]
then
  wget https://github.com/HyNetwork/hysteria/releases/download/v0.9.4/hysteria-tun-linux-386
  chmod 777 hysteria-tun-linux-386 
  mv hysteria-tun-linux-386 hysteria
  option1
  ./hysteria server
elif	[ "$m1" == 0 ]
then
	echo -e "\033[32m退出完成,执行./hysteria.sh再次打开本脚本\033[0m"	
else
	echo -e "\033[32m输入错误\033[0m"

fi

