#!/bin/sh  
  
# 清空原网络配置
echo "" > /etc/config/network

# 写入新内容，其中 gateway、ipaddr、dns，这三项自己按需修改。如果你的VPS使用DHCP获取IP，建议也配置使用static方式获取，以免发生意外

echo "config interface 'loopback'
        option device 'lo'
        option proto 'static'
        option ipaddr '127.0.0.1'
        option netmask '255.0.0.0'

config interface 'wan'
        option ifname 'eth0'
        option proto 'static'
        
        option ipaddr '154.17.229.139'
        option gateway '154.17.229.1'
        option netmask '255.255.255.0'
        
        option ip6addr '2605:52c0:1:413:e0f6:4bff:fe63:1c6f/64'
        option ip6gw 'fe80::14a7:b9ff:fe92:b46c'

        list dns '8.8.8.8'
        list dns '1.1.1.1'
        list dns '2001:4860:4860::8888'
        " > /etc/config/network

# 清空原防火墙配置
echo "" > /etc/config/firewall

# 写入新内容
echo "config defaults
        option input 'ACCEPT'
        option output 'ACCEPT'
        option fullcone '1'
        option forward 'ACCEPT'

config zone
        option name 'wan'
        list network 'wan'
        option input 'ACCEPT'
        option output 'ACCEPT'
        option forward 'ACCEPT' "> /etc/config/firewall

# 清空源ssh配置
echo "" > /etc/config/dropbear

# 写入新配置，Port请修改为自己需要的端口。
# SSH服务默认绑定了lan口，本文中使用了wan口，此配置为绑定所有接口
echo "config dropbear
        option PasswordAuth 'on'
        option RootPasswordAuth 'on'
        option Port         '33022'
        option Interface    'wan'" > /etc/config/dropbear
        

# 清空UHTTP配置
echo "" > /etc/config/uhttpd

# 写入新配置
echo "config uhttpd 'main'
        list listen_http '0.0.0.0:33080'
        list listen_http '[::]:33080'
        option home '/www'
        option rfc1918_filter '1'
        option max_requests '3'
        option max_connections '100'
        option cgi_prefix '/cgi-bin'
        list lua_prefix '/cgi-bin/luci=/usr/lib/lua/luci/sgi/uhttpd.lua'
        option script_timeout '60'
        option network_timeout '30'
        option http_keepalive '20'
        option tcp_keepalive '1'
        option ubus_prefix '/ubus'
        list index_page 'cgi-bin/luci'" > /etc/config/uhttpd

# 不使用ttyd        
# echo "" > /etc/config/ttyd

# echo "config ttyd
#         option ipv6 'on'  
#         option command '/bin/login'" > /etc/config/ttyd

exit 0
