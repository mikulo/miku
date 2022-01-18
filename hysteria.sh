#!/bin/bash
if [ `id -u` -eq 0 ]
then
	:
else
	echo -e "\033[32m请用root用户执行本脚本!\033[0m"
        exit
fi
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
elif	[ "$m1" == 2 ]
then
	wget https://github.com/HyNetwork/hysteria/releases/download/v0.9.4/hysteria-tun-linux-arm64
  chmod 777 hysteria-tun-linux-arm64
  mv hysteria-tun-linux-arm64 hysteria
	
elif	[ "$m1" == 3 ]
then
	wget https://github.com/HyNetwork/hysteria/releases/download/v0.9.4/hysteria-tun-linux-arm-7
  chmod 777 hysteria-tun-linux-arm-7
  mv hysteria-tun-linux-arm-7 hysteria
  
elif	[ "$m1" == 4 ]
then
	wget https://github.com/HyNetwork/hysteria/releases/download/v0.9.4/hysteria-tun-linux-386
  chmod 777 hysteria-tun-linux-386 
  mv hysteria-tun-linux-386 hysteria

elif	[ "$m1" == 0 ]
then
	echo -e "\033[32m退出完成,执行./hysteria.sh再次打开本脚本\033[0m"	
else
	echo -e "\033[32m输入错误\033[0m"

fi

