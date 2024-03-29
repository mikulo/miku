#!/bin/bash
if [ `id -u` -eq 0 ]
then
	:
else
	echo -e "\033[32m请用root用户执行本脚本!\033[0m"
        exit
fi
if type miku >/dev/null 2>&1; then 
    rm /usr/bin/miku
    path=`pwd`
    ln -s "$path/miku.sh" /usr/bin/miku
else 
    path=`pwd`
    ln -s "$path/miku.sh" /usr/bin/miku
fi	
echo -e "\033[32m欢迎使用多功能脚本,请输入序号选择功能\033[0m"
echo -e "\033[32m脚本仅支持debian/ubuntu系统!\033[0m" 
echo -e "\033[32m当前版本为:0.70\033[0m" 
echo 1.科学上网脚本集合
echo 2.各种工具脚本集合
echo 3.系统优化脚本集合
echo 4.计算圆周率
echo 5.更新脚本
echo 6.卸载脚本
echo 0.退出脚本
read -p ">>" m1
#pip安装Python库
pipinstall()
{
all=("requests" "pinyin" "telegram" "flask")
if type pip3 >/dev/null 2>&1; then 
	echo 'python3-pip已安装' 
else 
	apt-get -y install python3-pip
	echo 'python3-pip安装完成'
fi	
doneins=`pip3 list`
for ku in ${all[@]}
do
if [[ $doneins =~ $ku ]]
then
    echo "$ku已安装"
else
    pip3 install $ku
    echo -e "\033[32m$ku安装完成\033[0m"
fi    
done
echo -e "\033[32m全部安装完成\033[0m"
}
#选项1
option1(){
	echo 1.SSR多用户管理系统安装脚本
	echo 2.V2RAY安装脚本
	echo 3.brook安装脚本
	echo 4.goflyway安装脚本
	echo 5.lightsocks安装脚本
	echo 6.daze安装脚本
	echo 7.mtproxy安装脚本
	echo 8.AnyConnect安装脚本
	read -p ">>" m2
	if [ "$m2" == 1 ]
	then
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh && chmod +x ssrmu.sh && bash ssrmu.sh
	elif	[ "$m2" == 2 ]
	then
		bash <(curl -s -L https://git.io/v2ray.sh)	
	elif	[ "$m2" == 3 ]
	then	
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/brook.sh && chmod +x brook.sh && bash brook.sh
	elif	[ "$m2" == 0 ]
	then
		echo -e "\033[32m退出完成,执行./miku.sh再次打开本脚本\033[0m"
	elif	[ "$m2" == 4 ]
	then
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/goflyway.sh && chmod +x goflyway.sh && bash goflyway.sh
	elif	[ "$m2" == 5 ]
	then
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/lightsocks.sh && chmod +x lightsocks.sh && bash lightsocks.sh	
	elif	[ "$m2" == 6 ]
	then
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/daze.sh && chmod +x daze.sh && bash daze.sh
	elif	[ "$m2" == 7 ]
	then
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/mtproxy.sh && chmod +x mtproxy.sh && bash mtproxy.sh
	elif	[ "$m2" == 8 ]
	then
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/ocserv.sh && chmod +x ocserv.sh && bash ocserv.sh
	else	
		echo -e "\033[32m输入错误\033[0m"
	fi
}
#选项2
option2()
{
	echo 1.aria2安装脚本
	echo 2.rclone安装脚本
	echo 3.linux性能测试脚本\(来源www.94ish.me\)
	echo 4.禁止指定国家ip访问vps\(来源www.moerats.com\)
	echo 5.vps回程路由测试
	echo 6.网速测试
	echo 0.退出脚本
	read -p ">>" m2
	if [ "$m2" == 1 ]
	then
		wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/aria2.sh && chmod +x aria2.sh && bash aria2.sh
	elif	[ "$m2" == 2 ]
	then		
		curl https://rclone.org/install.sh | sudo bash	
	elif	[ "$m2" == 3 ]
	then	
		wget -N --no-check-certificate https://raw.githubusercontent.com/chiakge/Linux-Server-Bench-Test/master/linuxtest.sh&&bash linuxtest.sh
	elif	[ "$m2" == 4 ]
	then	
		wget -N https://raw.githubusercontent.com/rmrfalll/miku/master/block-ips.sh&&chmod +x block-ips.sh&&./block-ips.sh
	elif	[ "$m2" == 5 ]
	then
		wget -N https://raw.githubusercontent.com/rmrfalll/miku/master/testrace.sh&&chmod +x testrace.sh&&bash testrace.sh
	elif	[ "$m2" == 6 ]
	then
		wget -N http://yun.789888.xyz/speedtest.sh&&chmod +x speedtest.sh&&bash speedtest.sh
	elif	[ "$m2" == 0 ]
	then
		echo -e "\033[32m退出完成,执行./miku.sh再次打开本脚本\033[0m"
		
	else	
		echo -e "\033[32m输入错误\033[0m"
		
	fi
	
}
#选项3
option3()
{
	echo 1.安装BBR
	echo 2.添加\/删除swap虚拟内存\(来源:www.moerats.com\)
	echo 3.一键安装linux基础指令
	echo 4.一键安装python3库
	echo 0.退出脚本
	read -p ">>" m2
	if [ "$m2" == 1 ]
	then
		echo 1.debian9或ubuntu18快速开启BBR
		echo 2.更换内核开启BBR
		echo 0.退出脚本
		read -p ">>" m2
		if [ "$m2" == 1 ]
			then
				echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
				echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
				sysctl -p
				lsmod | grep bbr
				echo -e  "\033[32m⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆\033[0m"
				echo  -e   "\033[32m如果上面输出显示\"tcp_bbr  20480  14\"类似字样即为开启成功\033[0m"
		elif	[ "$m2" == 2 ]
			then
				wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
		elif	[ "$m2" == 0 ]
			then	
				echo -e "\033[32m退出完成,执行./miku.sh再次打开本脚本\033[0m"
		else	
				echo -e "\033[32m输入错误\033[0m"
		
		fi
	elif	[ "$m2" == 2 ]	
	then		
		wget -N https://raw.githubusercontent.com/rmrfalll/miku/master/swap.sh && bash swap.sh
	
	elif	[ "$m2" == 3 ]	
	then	
		unset insall
		apt-get update
		#apt-get upgrade
	    if type wget >/dev/null 2>&1; then 
            	echo 'wget已安装' 
            else 
		apt-get -y install wget
		insall[${#insall[@]}]="wget"
            	echo 'wget安装完成'
            fi
	    if type curl >/dev/null 2>&1; then 
            	echo 'curl已安装' 
            else 
		apt-get -y install curl
		insall[${#insall[@]}]="curl"
                echo 'curl安装完成'
            fi
	    if type ping >/dev/null 2>&1; then 
                echo 'ping已安装' 
            else 
		apt-get -y install iputils-ping
		insall[${#insall[@]}]="ping"
                echo 'ping安装完成'
            fi
	    if type vim >/dev/null 2>&1; then 
                echo 'vim已安装' 
            else 
		apt-get -y install vim
		insall[${#insall[@]}]="vim"
                echo 'vim安装完成'
            fi	
	    if type screen >/dev/null 2>&1; then 
                echo 'screen已安装' 
            else 
		apt-get -y install screen
		insall[${#insall[@]}]="screen"
                echo 'screen安装完成'
            fi		
	    if type unzip >/dev/null 2>&1; then 
                echo 'unzip已安装' 
            else 
		apt-get -y install unzip
		insall[${#insall[@]}]="unzip"
                echo 'unzip安装完成'
            fi	
	    if type pip >/dev/null 2>&1; then 
                echo 'python-pip已安装' 
            else 
		apt-get -y install python-pip
		insall[${#insall[@]}]="python-pip"
                echo 'python-pip安装完成'
            fi	
	    if type pip3 >/dev/null 2>&1; then 
                echo 'python3-pip已安装' 
            else 
		apt-get -y install python3-pip
		insall[${#insall[@]}]="python3-pip"
                echo 'python3-pip安装完成'
            fi		    
	    if [ ${#insall[*]} == 0 ] 
	    then
	    	echo "没有需要安装的软件!"
	    else
	    	echo -e "\033[32m全部安装完成!\033[0m"
	    	echo -e "\033[32m安装了下列软件: ${insall[*]}\033[0m"
	    fi
	elif	[ "$m2" == 4 ]	
	then	
		pipinstall
	elif	[ "$m2" == 0 ]
	then
		echo -e "\033[32m退出完成,执行./miku.sh再次打开本脚本\033[0m"
		
	else	
		echo -e "\033[32m输入错误\033[0m"

	fi	
}
#选项4
option4()
{
	read -p "请输入要计算圆周率的小数点后的位数:" pi
	time echo "scale=$pi; a(1)*4" | bc -l
}
#选项5
option5()
{
	wget -N --no-check-certificate "https://raw.githubusercontent.com/mikulo/miku/master/miku.sh" && chmod +x miku.sh
	echo -e "\033[32m更新完成\033[0m"
	#echo -e "\033[32m请手动执行:\033[0m"
        #echo -e "\033[31mwget -N --no-check-certificate "https://raw.githubusercontent.com/mikulo/miku/master/miku.sh" && chmod +x miku.sh\033[0m"
	#echo -e "\033[32m来更新脚本\033[0m"
}
#选项6
option6()
{
	rm -rf /root/miku.sh
	rm -rf /usr/local/sbin/miku
	echo -e "\033[32m卸载完成\033[0m"	
}
if	[ "$m1" == 1 ]
then
	option1	
elif	[ "$m1" == 2 ]
then
	option2
	
elif	[ "$m1" == 3 ]
then
	option3
elif	[ "$m1" == 4 ]
then
	option4
elif	[ "$m1" == 5 ]
then
	option5
elif	[ "$m1" == 0 ]
then
	echo -e "\033[32m退出完成,执行miku再次打开本脚本\033[0m"	
elif	[ "$m1" == 6 ]
then
	option6
else
	echo -e "\033[32m输入错误\033[0m"

fi

