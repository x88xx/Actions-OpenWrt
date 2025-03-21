#!/bin/sh

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
}

# 调用函数
create_swap
exit 0