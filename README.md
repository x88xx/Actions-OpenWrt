##### 使用 GitHub Actions 在线云编译 OpenWrt 固件

以下是通过 `dd` 命令刷写 `openwrt-x86-64-generic-ext4-combined-efi.img.gz` 文件到设备的步骤：

### 准备工作
1. **下载固件文件**：从 OpenWrt 网站下载 `openwrt-x86-64-generic-ext4-combined-efi.img.gz` 文件。
2. **解压固件文件**：在 Linux 环境下，使用以下命令解压：
   ```bash
   gzip -d openwrt-x86-64-generic-ext4-combined-efi.img.gz
   ```
   解压后会得到 `openwrt-x86-64-generic-ext4-combined-efi.img` 文件。
3. **准备 SSH 工具**：用于连接目标设备，推荐使用 FinalShell。
4. **确保网络连接**：你的电脑和目标设备（如软路由）需处于同一局域网。

### 刷写步骤
1. **上传固件文件**：
   - 使用 SSH 工具连接到目标设备。
   - 将解压后的 `openwrt-x86-64-generic-ext4-combined-efi.img` 文件上传到目标设备的 `/tmp` 目录。
2. **执行 `dd` 命令**：
   - 在目标设备的终端中，输入以下命令：
     ```bash
     dd if=/tmp/openwrt-x86-64-generic-ext4-combined-efi.img of=/dev/vda bs=4M
     ```
     - `if` 参数指定输入文件为上传的固件文件。
     - `of` 参数指定输出设备为目标设备的系统盘（如 `/dev/sda`），请根据实际情况确认设备名称。
     - `bs=4M` 设置块大小为 4MB，可加快写入速度。
3. **等待写入完成**：写入完成后，终端会显示类似以下信息：
   ```
   3771704+0 records in
   3771704+0 records out
   ```
   表示刷写成功。
4. **重启设备**：输入以下命令重启设备：
   ```bash
   sync && reboot
   ```
   重启后，设备将运行新的 OpenWrt 系统。

### 注意事项
- **备份数据**：刷写前请备份重要数据，因为此操作会清除原有系统和数据。
- **确认设备名称**：使用 `lsblk` 命令确认目标设备的磁盘名称（如 `/dev/vda`），避免误操作。
- **确保电源稳定**：在刷写过程中，不要断电，否则可能导致设备变砖。
