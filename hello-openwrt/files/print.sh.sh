#!/bin/sh

# 定义一个函数，接收输出设备作为参数
output_info() {
    local output_device="$1"

    # 输出分隔符
    {
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo "  OOOOO   PPPP    EEEEE  N   N  W     W  RRRR   TTTTT  "
        echo " O     O  P   P   E      NN  N  W     W  R   R    T    "
        echo " O     O  PPPP    EEEE   N N N  W  W  W  RRRR     T    "
        echo " O     O  P       E      N  NN  W W W W  R R      T    "
        echo "  OOOOO   P       EEEEE  N   N   W   W   R  RR    T    "
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo "Dear Server Administrators and Providers,"
        echo "   Greetings! First and foremost, I would like to express my heartfelt gratitude for your relentless efforts and round-the-clock maintenance in the server room, which has ensured the secure and stable operation of our VPS services. Due to the needs of our business development, we have upgraded our system to OpenWRT. This may result in some anomalies that you might notice when monitoring the backend. For any inconvenience this may cause, I sincerely apologize and ask for your understanding of the necessity of this change. Thank you for your support and cooperation!"
        echo ""
        echo ""
        echo ""
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo ""
        echo "              Hello OpenWRT"
        echo ""
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    } > "$output_device"

    # 输出网络信息
    echo "Net Information:" >> "$output_device"

    # 读取网络配置文件
    config_file="/etc/config/network"
    {
        # 提取 IPv4 和 IPv6 地址
        awk '/option ipaddr/ { if (index($3, "127.0.0.1") == 0) print $3 }
             /option ip6addr/ {print $3}' "$config_file"
    } >> "$output_device"
    echo "" >> "$output_device"

    # 输出内存和存储信息
    echo "Storage Information:" >> "$output_device"

    # 获取内存和存储信息
    {
        # 获取总内存并转换为 MB
        total_memory_mb=$(grep MemTotal /proc/meminfo | awk '{print $2 / 1024}')
        
        # 获取根文件系统的总大小并转换为 GB
        total_storage_gb=$(df -h / | awk 'NR==2 {print $2}' | sed 's/G//')

        # 输出结果
        echo " RAM: ${total_memory_mb} MB ROM: ${total_storage_gb} GB"
    } >> "$output_device"
    echo "" >> "$output_device"

    # 显示CPU信息
    echo "CPU Information:" >> "$output_device"
    {
        cat /proc/cpuinfo | grep "model name" | cut -d ":" -f2
    } >> "$output_device"
    echo "" >> "$output_device"
}

# 遍历 /dev/tty* 设备并传入函数
for tty_device in /dev/tty*; do
    output_info "$tty_device"
done
