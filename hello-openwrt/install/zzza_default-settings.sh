#!/bin/sh

# 扩容磁盘
/root/soft/set_disk.sh

# 添加SWAP
/root/other/create_swap.sh

# 定义 开启自启信息
mv -f /root/config/rc.local /etc/rc.local && chmod 0644 /etc/rc.local

# 设置空密码
mv -f /root/config/shadow /etc/shadow && chmod 0644 /etc/shadow

# 设置Shell终端显示
mv -f /root/config/shadow /etc/banner && chmod 0644 /etc/banner

# 覆盖配置信息
cp -rf /root/config/* /etc/config

chmod -R 0644 /etc/config

exit 0
