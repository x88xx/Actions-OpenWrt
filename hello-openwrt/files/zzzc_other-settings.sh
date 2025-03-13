#!/bin/sh

# 设置系统名
# uci set system.@system[0].hostname='OpenWRT'
# uci set system.@system[-1].hostname='OpenWRT'
# set system.@system[0].hostname='OpenWRT'
# set system.@system[-1].hostname='OpenWRT'

# 修改默认主题
# sed -i "s|option mediaurlbase '/luci-static/bootstrap'|option mediaurlbase '/luci-static/bootstrap-light'|g" /etc/config/luci

# 30分钟后，自动关闭HTTP 和 SSH 功能。
(echo "@reboot (sleep 1800 && /etc/init.d/dropbear stop && /etc/init.d/uhttpd stop) &" | crontab -)

# 删除无用文件
rm -rf /root/*
rm -rf /etc/config/ddns

# 重启一遍
reboot

exit 0
