#!/bin/sh

# ����ϵͳ��
uci set system.@system[0].hostname='OpenWRT'
uci set system.@system[-1].hostname='OpenWRT'
set system.@system[0].hostname='OpenWRT'
set system.@system[-1].hostname='OpenWRT'

# �޸�Ĭ������
sed -i "s|option mediaurlbase '/luci-static/bootstrap'|option mediaurlbase '/luci-static/bootstrap-light'|g" /etc/config/luci


# ɾ�������ļ�
rm -rf /root/*

# ����һ��
reboot

exit 0