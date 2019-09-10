while true
do
echo -e "\033[32m欢迎使用多功能脚本,请输入序号选择功能\033[0m"
echo 1.tar打包备份系统
echo 2.一键安装SSR多用户管理系统
echo 3.一键安装V2RAY
echo 4.debian9或ubuntu18快速开启BBR
echo 5.安装rclone
echo 8.退出脚本
read -p ">>" m1
if [ "$m1" == 1 ]
then
	rm /back/backup.tgz
	echo $(date)" 删除原来的备份一次" >> /root/backuplog.txt
	tar -cvpzf /back/backup.tgz --exclude=/proc --exclude=/lost+found --exclude=/home --exclude=/mnt --exclude=/sys --exclude=/media  --exclude=/back --exclude=/dev --exclude=/etc/default/grub --exclude=/etc/grub.d/ --exclude=/etc/group --exclude=/etc/group- --exclude=/boot /
	echo $(date) "备份一次" >> /root/backuplog.txt
	echo -e "\033[32m备份完成!输入y上传云盘\(默认不上传\)\033[0m"
	read m2
	if [ "$m2" == "y" ]
	then
		rclone delete gdrive3:/gcpbackup/
		echo $(date) "删除云盘备份一次" >> /root/backuplog.txt
		rclone copy /back/backup.tgz gdrive3:/gcpbackup/ -P
		echo $(date) "上传到云盘一次" >> /root/backuplog.txt
		echo -e "\033[32m上传云盘成功!\033[0m"
	fi
elif	[ "$m1" == 2 ]
then
	wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh && chmod +x ssrmu.sh && bash ssrmu.sh
elif	[ "$m1" == 3 ]
then
	bash <(curl -s -L https://git.io/v2ray.sh)
elif	[ "$m1" == 4 ]
then
	echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
	echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
	sysctl -p
	lsmod | grep bbr
	echo -e  "\033[32m⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆\033[0m"
	echo  -e   "\033[32m如果上面输出显示\"tcp_bbr  20480  14\"类似字样即为开启成功\033[0m"
elif	[ "$m1" == 5 ]
then
	wget https://www.moerats.com/usr/shell/rclone_debian.sh && bash rclone_debian.sh
elif	[ "$m1" == 8 ]
then
	break


else
	echo -e "\033[32m输入错误\033[0m"

fi
done
