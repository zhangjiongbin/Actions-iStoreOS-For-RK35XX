#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================


# update ubus git HEAD
cp -f $GITHUB_WORKSPACE/configfiles/ubus_Makefile package/system/ubus/Makefile


# 近期istoreos网站文件服务器不稳定，临时增加一个自定义下载网址
sed -i "s/push @mirrors, 'https:\/\/mirror2.openwrt.org\/sources';/&\\npush @mirrors, 'https:\/\/github.com\/xiaomeng9597\/files\/releases\/download\/iStoreosFile';/g" scripts/download.pl


# 移植黑豹x2

# rm -f target/linux/rockchip/image/rk35xx.mk
# cp -f $GITHUB_WORKSPACE/configfiles/rk35xx.mk target/linux/rockchip/image/rk35xx.mk


# rm -f target/linux/rockchip/rk35xx/base-files/lib/board/init.sh
# cp -f $GITHUB_WORKSPACE/configfiles/init.sh target/linux/rockchip/rk35xx/base-files/lib/board/init.sh


# rm -f target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network
# cp -f $GITHUB_WORKSPACE/configfiles/02_network target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network




# 修改内核配置文件
# rm -f target/linux/rockchip/rk35xx/config-5.10
# cp -f $GITHUB_WORKSPACE/configfiles/config-5.10 target/linux/rockchip/rk35xx/config-5.10
sed -i "/.*CONFIG_ROCKCHIP_RGA2.*/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/# CONFIG_ROCKCHIP_RGA2 is not set/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_DEBUGGER=y/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_DEBUG_FS=y/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_PROC_FS=y/d" target/linux/rockchip/rk35xx/config-5.10




# 替换dts文件
cp -f $GITHUB_WORKSPACE/configfiles/rk3566-jp-tvbox.dts target/linux/rockchip/dts/rk3568/rk3566-jp-tvbox.dts

cp -f $GITHUB_WORKSPACE/configfiles/rk3566-panther-x2.dts target/linux/rockchip/dts/rk3568/rk3566-panther-x2.dts




#修改uhttpd配置文件，启用nginx
# sed -i "/.*uhttpd.*/d" .config
# sed -i '/.*\/etc\/init.d.*/d' package/network/services/uhttpd/Makefile
# sed -i '/.*.\/files\/uhttpd.init.*/d' package/network/services/uhttpd/Makefile
sed -i "s/:80/:81/g" package/network/services/uhttpd/files/uhttpd.config
sed -i "s/:443/:4443/g" package/network/services/uhttpd/files/uhttpd.config
cp -a $GITHUB_WORKSPACE/configfiles/etc/* package/base-files/files/etc/
# ls package/base-files/files/etc/






# 增加ido3568 DG NAS
echo -e "\\ndefine Device/dg_nas
\$(call Device/rk3568)
  DEVICE_VENDOR := DG
  DEVICE_MODEL := NAS
  DEVICE_DTS := rk3568-dg-nas
  SUPPORTED_DEVICES += dg,nas
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core
endef
TARGET_DEVICES += dg_nas" >> target/linux/rockchip/image/rk35xx.mk


sed -i "s/panther,x2|\\\/&\\n	dg,nas|\\\/g" target/linux/rockchip/rk35xx/base-files/lib/board/init.sh

sed -i "s/panther,x2|\\\/&\\n	dg,nas|\\\/g" target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network

# 增加YS-F3588A
echo -e "\\ndefine Device/rk3588-evb7-lp4-v10
\$(call Device/rk3588)
  DEVICE_VENDOR := Rockchip
  DEVICE_MODEL := RK3588 EVB7 LP4 V10 Board
  DEVICE_DTS := YS-F3588A
  SUPPORTED_DEVICES += rockchip,rk3588-evb7-lp4-v10
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core
endef
TARGET_DEVICES += rockchip_rk3588-evb7-lp4-v10" >> target/linux/rockchip/image/rk35xx.mk

# 增加RK3566-HJQ
echo -e "\\ndefine Device/rk3566-evb2-lp4x-v10
\$(call Device/rk3566)
  DEVICE_VENDOR := Rockchip
  DEVICE_MODEL := RK3566 EVB2 LP4X V10 Board
  DEVICE_DTS := rk3566-hjq
  SUPPORTED_DEVICES += rockchip,rk3566-evb2-lp4x-v10
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core
endef
TARGET_DEVICES += rockchip_rk3566-evb2-lp4x-v10" >> target/linux/rockchip/image/rk35xx.mk


cp -f $GITHUB_WORKSPACE/configfiles/rk3568-firefly-roc-pc-se-core.dtsi target/linux/rockchip/dts/rk3568/rk3568-firefly-roc-pc-se-core.dtsi

cp -f $GITHUB_WORKSPACE/configfiles/rk3568-dg-nas.dts target/linux/rockchip/dts/rk3568/rk3568-dg-nas.dts

cp -f $GITHUB_WORKSPACE/configfiles/YS-F3588A.dts target/linux/rockchip/dts/rk3588/YS-F3588A.dts

cp -f $GITHUB_WORKSPACE/configfiles/rk3566-hjq.dts target/linux/rockchip/dts/rk3568/rk3566-hjq.dts




#轮询检查ubus服务是否崩溃，崩溃就重启ubus服务
cp -f $GITHUB_WORKSPACE/configfiles/httpubus package/base-files/files/etc/init.d/httpubus
cp -f $GITHUB_WORKSPACE/configfiles/ubus-status.sh package/base-files/files/sbin/ubus-status.sh
chmod 755 package/base-files/files/etc/init.d/httpubus
chmod 755 package/base-files/files/sbin/ubus-status.sh



#集成黑豹X2和荐片TV盒子无线功能并且开启无线功能
cp -a $GITHUB_WORKSPACE/configfiles/firmware/* package/firmware/
cp -f $GITHUB_WORKSPACE/configfiles/opwifi package/base-files/files/etc/init.d/opwifi
chmod 755 package/base-files/files/etc/init.d/opwifi
sed -i "s/wireless.radio\${devidx}.disabled=1/wireless.radio\${devidx}.disabled=0/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh



#集成CPU性能跑分脚本
cp -a $GITHUB_WORKSPACE/configfiles/coremark/* package/base-files/files/sbin/
chmod 755 package/base-files/files/sbin/coremark
chmod 755 package/base-files/files/sbin/coremark.sh
