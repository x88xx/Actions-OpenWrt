#!/bin/sh

# 设置系统名
uci set system.@system[0].hostname='OpenWRT'
uci set system.@system[-1].hostname='OpenWRT'
set system.@system[0].hostname='OpenWRT'
set system.@system[-1].hostname='OpenWRT'

# 复制DDNS配置到配置文件夹
rm -rf /etc/config/ddns
cp /root/ddns /etc/config/ddns

# 删除无用文件
rm -rf /root/*

# 重启一遍
reboot

exit 0