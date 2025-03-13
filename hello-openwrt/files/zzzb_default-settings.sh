#!/bin/sh

function set_disk(){
	# 寻找磁盘路径
	disk_boot=$(echo $(mount | grep "on /boot " | awk '{print $1}' | head -n 1))
	disk_main=$(echo "$disk_boot" | sed 's/[0-9]$/2/')
	disk=$(echo $disk_boot | sed 's/1$//')

	# disk_main=/dev/vda2
	# disk=/dev/vda

	# 判断是否安装了parted,如果安装在卸载，系统会报错.
	if command -v parted &> /dev/null ; then
		# opkg update
		opkg install /root/losetup*
		opkg install /root/resize2fs*

	else
		opkg install /root/losetup*
		opkg install /root/resize2fs*
		opkg install /root/libparted*
		opkg install /root/parted*

	fi
	# 开始分区
	echo -e "ok\nfix" | parted -l ---pretend-input-tty
	echo yes | parted $disk ---pretend-input-tty resizepart 2 100%
	losetup /dev/loop0 $disk_main 2> /dev/null
	resize2fs -f /dev/loop0
	}

	# 判断是否安装了parted,如果已安装，则卸载.
	if command -v parted &> /dev/null ; then
        # 删除包
        opkg uninstall /root/parted*
        opkg uninstall /root/losetup*
        opkg uninstall /root/resize2fs*
        opkg uninstall /root/libparted*
	fi
    
# 创建一个128MB大小的Swap文件
create_swap() {
    local swap_file="/www/swapfile"
    local swap_size="128M"

    # 确保/www目录存在
    mkdir -p /www

    # 如果swap文件不存在，则创建它
    if [ ! -f "$swap_file" ]; then
        dd if=/dev/zero of="$swap_file" bs=1M count=128
        chmod 0755 "$swap_file"
        mkswap "$swap_file"
    fi

	# 设置 tmpfs 空间为128M,# 激活swap文件 # 禁用ICMP # 30分钟后，自动关闭SSH 和UHTTP功能
	echo "" > /etc/rc.local
	echo "mount -o remount rw /
mount -o remount,size=128M tmpfs /tmp
swapon '$swap_file'
# 禁用ICMP
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
echo 1 > /proc/sys/net/ipv6/icmp/echo_ignore_all
# 30分钟后，自动关闭SSH 和UHTTP功能
# (sleep 1800 && /etc/init.d/dropbear stop && /etc/init.d/uhttpd stop) &
exit 0" >> /etc/rc.local


    # 将swap设置添加到/etc/fstab，以便开机自动挂载swap
    # echo "$swap_file none swap sw 0 0" >> /etc/fstab
}

# 扩展内存
set_disk
# 创建Swap文件
create_swap

# 修正终端不显示错误
# /etc/init.d/ttyd restart




exit 0
