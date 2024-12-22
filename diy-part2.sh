#!/bin/bash
# 创建自定义配置文件
mkdir -p package/tmp
git clone https://github.com/x88xx/Actions-OpenWrt.git package/tmp
cp -r package/tmp/hello-openwrt package/ && rm -rf package/tmp/
