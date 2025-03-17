include $(TOPDIR)/rules.mk

# PAK NAME 必须和包所在文件夹一样.
PKG_NAME:=hello-openwrt

# 下面三个参数随便填写.
PKG_VERSION:=20241221
PKG_RELEASE:=1
PKG_MAINTAINER:=H.E.L.L.O

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk
# 下面是显示在menuconfig中的菜单路径
# SUBMENU后面跟着的是我自己diy的一个菜单选项,
# 这个菜单里面全是自己的包,比较好找.

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=00.H.E.L.L.O
	PKGARCH:=all
	TITLE:=hello-openwrt
endef

# 包介绍说明,不要用中文.
define Package/$(PKG_NAME)/description
    Hello!
endef

define Package/$(PKG_NAME)/preinst
endef

# 安装后执行的脚本
# 这里大概作用就是安装后给./usr/bin/v2ray添加执行权限.

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	chmod 755 13600{IPKG_INSTROOT}/home >/dev/null 2>&1
fi
exit 0

endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

# 安装作业
# 这里一般就是复制文件
# 如果有更多文件直接参考修改,非常简单.

define Package/$(PKG_NAME)/install

	# 两条命令一组
	# 第一条是指定复制到的目录
	# 第二条是拷贝文件.

	# 拷贝文件到目录
	$(INSTALL_DIR) $(1)/root
	$(INSTALL_BIN) ./files/* $(1)/root/

	# UI/显示设置
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/zzzb_default-settings.sh $(1)/etc/uci-defaults/zzzb_default-settings.sh
	
	# 网络设置
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/zzza_network-settings.sh $(1)/etc/uci-defaults/zzza_network-settings.sh	
	
	# 其它设置
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/zzzc_other-settings.sh $(1)/etc/uci-defaults/zzzc_other-settings.sh

endef

$(eval $(call BuildPackage,$(PKG_NAME)))