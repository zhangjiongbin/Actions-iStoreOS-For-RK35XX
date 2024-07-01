include $(TOPDIR)/rules.mk

PKG_NAME:=ap6275p2

PKG_SOURCE_URL:=https://github.com/zhangjiongbin/ap6275p2.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=72b01a367f7e718250de12e7c0d5d335ab9866a8

include $(INCLUDE_DIR)/package.mk

define Package/brcmfmac-firmware-fs-f3588a
  SECTION:=firmware
  CATEGORY:=Firmware
  URL:=https://github.com/zhangjiongbin/ap6275p2.git
  TITLE:=fs-y3588a AP6275P Firmware
endef

define Build/Compile
	true
endef

define Package/fw_bcmmac-firmware-fs-f3588a/install
	$(INSTALL_DIR) $(1)/lib/firmware/brcm
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/BCM4362A2.hcd \
		$(1)/lib/firmware/brcm/BCM4362A2.hcd
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/fw_bcm43752a2_pcie_ag.bin \
		$(1)/lib/firmware/brcm/fw_bcm43752a2_pcie_ag.bin.bin
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/nvram_AP6275P.txt \
		$(1)/lib/firmware/brcm/nvram_AP6275P.txt
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/clm_bcm43752a2_pcie_ag.blob \
		$(1)/lib/firmware/brcm/clm_bcm43752a2_pcie_ag.blob
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/fw_bcm43752a2_pcie_ag.bin \
		$(1)/lib/firmware/brcm/fw_bcm43752a2_pcie_ag.ys,f3588a.bin
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/nvram_AP6275P.txt \
		$(1)/lib/firmware/brcm/fw_bcm43752a2_pcie_ag.ys,f3588a.txt
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/clm_bcm43752a2_pcie_ag.blob \
		$(1)/lib/firmware/fw_bcm43752a2_pcie_ag.ys,f3588a.blob
endef

$(eval $(call BuildPackage,fw_bcmmac-firmware-fs-f3588a))
