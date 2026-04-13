#!/bin/bash

# --- 
# sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# --- Passwall/V2ray ---
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-passwall-en=y" >> .config
echo "CONFIG_PACKAGE_xray-core=y" >> .config
echo "CONFIG_PACKAGE_chinadns-ng=y" >> .config
echo "CONFIG_PACKAGE_dns2socks=y" >> .config

# --- Optimize ---
echo "CONFIG_PACKAGE_luci-app-access-control=n" >> .config
echo "CONFIG_PACKAGE_luci-app-stats=n" >> .config

# --- Optimize & Reduce Size (For 16MB Flash) ---
# Remove the full Linux command (use Busybox instead, which is already available).
echo "CONFIG_PACKAGE_coreutils=n" >> .config
echo "CONFIG_PACKAGE_boost=n" >> .config

# Select only Xray-core (excluding other bundled programs in Passwall).
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_Libev_Client=n" >> .config
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Libev_Client=n" >> .config
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_Plus=n" >> .config
echo "CONFIG_PACKAGE_shadowsocks-libev-ss-local=n" >> .config
echo "CONFIG_PACKAGE_shadowsocks-libev-ss-redir=n" >> .config
echo "CONFIG_PACKAGE_shadowsocksr-libev-ssr-local=n" >> .config
echo "CONFIG_PACKAGE_shadowsocksr-libev-ssr-redir=n" >> .config
echo "CONFIG_PACKAGE_trojan-plus=n" >> .config

# Reduce unnecessary features of dnsmasq-full to save extra space.
echo "CONFIG_PACKAGE_dnsmasq_full_dnssec=n" >> .config
echo "CONFIG_PACKAGE_dnsmasq_full_auth=n" >> .config
echo "CONFIG_PACKAGE_dnsmasq_full_tftp=n" >> .config

# Close any other apps that may have been installed unknowingly.
echo "CONFIG_PACKAGE_luci-app-access-control=n" >> .config
echo "CONFIG_PACKAGE_luci-app-stats=n" >> .config
echo "CONFIG_PACKAGE_luci-app-wol=n" >> .config

##################


# Remove any remaining Coreutils files (very important).
echo "CONFIG_PACKAGE_coreutils=n" >> .config
echo "CONFIG_PACKAGE_coreutils-base64=n" >> .config
echo "CONFIG_PACKAGE_coreutils-nohup=n" >> .config

# Remove Simple-Obfs (if you're not using the old Shadowsocks version which required this plugin).
# This one takes up a fair amount of space, and the X-ray support for VLESS/Reality is already better.
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Simple_Obfs=n" >> .config
echo "CONFIG_PACKAGE_simple-obfs-client=n" >> .config

# Remove unnecessary features from Libcurl (this one is heavy).
echo "CONFIG_LIBCURL_COOKIES=n" >> .config
echo "CONFIG_LIBCURL_FILE=n" >> .config
echo "CONFIG_LIBCURL_FTP=n" >> .config
echo "CONFIG_LIBCURL_PROXY=n" >> .config

# Remove IPv6 (if your network doesn't need it, this will save a lot of space).
# If you really don't need it, uncomment the line below.
# echo "CONFIG_PACKAGE_luci-proto-ipv6=n" >> .config
# echo "CONFIG_PACKAGE_dnsmasq_full_dhcpv6=n" >> .config

# Reduce the website size (use a lighter theme than the standard theme)
echo "CONFIG_PACKAGE_luci-theme-bootstrap=n" >> .config
echo "CONFIG_PACKAGE_luci-theme-argne=y" >> .config 

# remove geodata
rm -rf staging_dir/target-mipsel_24kc_musl/root-ramips/usr/share/xray/*.dat

# remove manual 
rm -rf staging_dir/target-mipsel_24kc_musl/root-ramips/usr/share/doc
rm -rf staging_dir/target-mipsel_24kc_musl/root-ramips/usr/share/man
