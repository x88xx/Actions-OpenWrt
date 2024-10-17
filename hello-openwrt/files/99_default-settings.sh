#!/bin/sh

function set_disk(){
	# 寻找磁盘路径
	disk_boot=$(echo $(mount | grep "on /boot " | awk '{print $1}' | head -n 1))
	disk_main=$(echo $disk_boot | sed 's/vda1/vda2/')
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
        chmod 600 "$swap_file"
        mkswap "$swap_file"
    fi

	# 设置 tmpfs 空间为128M,# 激活swap文件
	echo "" > /etc/rc.local
	echo "mount -o remount rw /
mount -o remount,size=128M tmpfs /tmp
swapon '$swap_file'
/etc/rc.d/S9999print.sh
exit 0" >> /etc/rc.local


    # 将swap设置添加到/etc/fstab，以便开机自动挂载swap
    # echo "$swap_file none swap sw 0 0" >> /etc/fstab
}

# 调用函数
chmod 0777 /root/print.sh
/root/print.sh
cp /root/print.sh /etc/rc.d/S9999print.sh

# 扩展内存
set_disk
# 创建Swap文件
create_swap

# 删除无用文件
rm -rf /root/*
# 重启一遍
reboot

exit 0