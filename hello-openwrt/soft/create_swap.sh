#!/bin/sh

create_swap() {

    # 创建路径
    local swap_file="/www/swapfile"

    # 128M
    local swap_size=128

    # 确保/www目录存在
    mkdir -p /www

    # 如果swap文件不存在，则创建它
    if [ ! -f "$swap_file" ]; then
        dd if=/dev/zero of="$swap_file" bs=1M count=$swap_size
        chmod 0755 "$swap_file"
        mkswap "$swap_file"
    fi
}

# 调用函数
create_swap

exit 0
