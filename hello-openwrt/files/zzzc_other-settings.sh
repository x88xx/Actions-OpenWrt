#!/bin/sh

# ����ϵͳ��
uci set system.@system[0].hostname='OpenWRT'
uci set system.@system[-1].hostname='OpenWRT'
set system.@system[0].hostname='OpenWRT'
set system.@system[-1].hostname='OpenWRT'

# ����DDNS���õ������ļ���
rm -rf /etc/config/ddns
cp /root/ddns /etc/config/ddns

# ɾ�������ļ�
rm -rf /root/*

# ����һ��
reboot

exit 0