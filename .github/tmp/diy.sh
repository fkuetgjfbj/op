#!/bin/bash

config_generate=package/base-files/files/bin/config_generate
[ ! -d files/root ] || mkdir -p files/root

[[ -n $CONFIG_S ]] || CONFIG_S=Super

export github="github.com"
export mirror="raw.githubusercontent.com/coolsnowwolf/lede/master"

# 使用 O2 级别的优化
sed -i 's/Os/O2/g' include/target.mk

# 更新 Feeds
./scripts/feeds update -a
./scripts/feeds install -a

sed -i "s/ImmortalWrt/OpenWrt/" {package/base-files/files/bin/config_generate,include/version.mk}
sed -i "s/ImmortalWrt/openwrt/" ./feeds/luci/modules/luci-mod-system/htdocs/luci-static/resources/view/system/flash.js  #改登陆域名
#删除冲突插件
# rm -rf $(find ./feeds/luci/ -type d -regex ".*\(argon\|design\|openclash\).*")
# rm -rf package/feeds/packages/prometheus-node-exporter-lua
# rm -rf feeds/packages/prometheus-node-exporter-lua
#samrtdns
rm -rf ./feeds/luci/applications/luci-app-smartdns
rm -rf  ./feeds/packages/net/smartdns

# daed-next
rm -rf package/emortal/daed-next
git clone -b rebase --depth 1 https://github.com/QiuSimons/luci-app-daed-next package/emortal/daed-next
find ./package/emortal/daed-next/luci-app-daed-next/root/etc -type f -exec chmod +x {} \;
# 更换 Nodejs 版本
rm -rf ./feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt feeds/packages/lang/node

# alist
 rm -rf ./feeds/packages/net/alist
 rm -rf  ./feeds/luci/applications/luci-app-alist
# alist
# git clone https://$github/sbwml/luci-app-alist package/alist
git clone -b v3.32.0 --depth 1 https://$github/sbwml/luci-app-alist package/alist
sed -i 's/网络存储/存储/g' ./package/alist/luci-app-alist/po/zh-cn/alist.po

case "${CONFIG_S}" in
Free-Plus)
;;
Vip-Super)
sed -i '/45)./d' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua  #zerotier
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua   #zerotier
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/zerotier_status.htm   #zerotier
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua 
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua 
sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json

sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/root/usr/share/luci/menu.d/luci-app-alist.json
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/luasrc/controller/alist.lua
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/view/alist/*.htm
sed -i 's/nas/services/g' ./package/alist/luci-app-alist/luasrc/controller/alist.lua
sed -i 's/nas/services/g' ./package/alist/luci-app-alist/luasrc/view/alist/*.htm
;;
Vip-Mini)
sed -i '/45)./d' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua  #zerotier
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua   #zerotier
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/zerotier_status.htm   #zerotier
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua 
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua 
sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json

sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/root/usr/share/luci/menu.d/luci-app-alist.json
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/luasrc/controller/alist.lua
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/view/alist/*.htm
sed -i 's/nas/services/g' ./package/alist/luci-app-alist/luasrc/controller/alist.lua
sed -i 's/nas/services/g' ./package/alist/luci-app-alist/luasrc/view/alist/*.htm
;;
Vip-Plus)
;;
Vip-Bypass)
;;
Free-Mini)
sed -i '/45)./d' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua  #zerotier
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua   #zerotier
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/zerotier_status.htm   #zerotier
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua
sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json

sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/root/usr/share/luci/menu.d/luci-app-alist.json
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/luasrc/controller/alist.lua
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/view/alist/*.htm
sed -i 's/nas/services/g' ./package/alist/luci-app-alist/luasrc/controller/alist.lua
sed -i 's/nas/services/g' ./package/alist/luci-app-alist/luasrc/view/alist/*.htm
;;
*)
sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json

sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/root/usr/share/luci/menu.d/luci-app-alist.json
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/luasrc/controller/alist.lua
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-alist/view/alist/*.htm
sed -i 's/nas/services/g' ./package/alist/luci-app-alist/luasrc/controller/alist.lua
sed -i 's/nas/services/g' ./package/alist/luci-app-alist/luasrc/view/alist/*.htm
;;
esac

case "${CONFIG_S}" in
"Free"*)
#修改默认IP地址
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate
;;
*)
#修改默认IP地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
;;
esac

sed -i 's/services/status/g' ./feeds/luci/applications/luci-app-nlbwmon/root/usr/share/luci/menu.d/luci-app-nlbwmon.json
# rm -rf ./package/emortal2
#rm -rf  package/js2

rm -rf  feeds/packages/net/wrtbwmon
rm -rf  ./feeds/luci/applications/luci-app-wrtbwmon
rm -rf  ./feeds/luci/applications/luci-app-arpbind
rm -rf  ./feeds/packages/net/open-app-filter
rm -rf  ./feeds/packages/net/oaf
rm -rf  ./feeds/luci/applications/luci-app-appfilter
rm -rf  ./feeds/luci/applications/luci-app-timecontrol
rm -rf  ./feeds/luci/applications/luci-app-socat
rm -rf  ./feeds/luci/applications/luci-app-fileassistant
rm -rf  ./feeds/luci/applications/luci-app-control-speedlimit

# rm -rf  ./feeds/packages/net/wget
# mv -rf ./package/wget  ./feeds/packages/net/wget
#aria2
rm -rf ./feeds/packages/net/aria2
rm -rf ./feeds/luci/applications/luci-app-aria2  package/feeds/packages/luci-app-aria2


# Passwall

rm -rf ./feeds/luci/applications/luci-app-ssr-plus  package/feeds/packages/luci-app-ssr-plus
rm -rf ./feeds/luci/applications/luci-app-passwall  package/feeds/packages/luci-app-passwall
rm -rf ./feeds/luci/applications/luci-app-passwall2  package/feeds/packages/luci-app-passwall2

# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 ./package/passwall2
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall ./package/passwall
git clone https://github.com/sbwml/openwrt_helloworld  ./package/ssr
git clone https://github.com/loso3000/other ./package/other
rm -rf ./package/ssr/luci-app-passwall2/htdocs/luci-static/resources/
#bypass
rm -rf ./package/ssr/luci-app-ssr-plus
# rm -rf ./package/ssr/luci-app-passwall
# rm -rf ./package/ssr/luci-app-passwall2
#rm -rf ./package/ssr/brook
#rm -rf ./package/ssr/chinadns-ng
#rm -rf ./package/ssr/dns2socks
#rm -rf ./package/ssr/dns2tcp
#rm -rf ./package/ssr/pdnsd-alt
#rm -rf ./package/ssr/ipt2socks
#rm -rf ./package/ssr/microsocks
#rm -rf ./package/ssr/lua-neturl
#rm -rf ./package/ssr/naiveproxy
# rm -rf ./package/ssr/redsocks2
# rm -rf ./package/ssr/simple-obfs
# rm -rf ./package/ssr/tcping
# rm -rf ./package/ssr/trojan
# rm -rf ./package/ssr/tuic-client
rm -rf ./package/ssr/shadowsocks-libev
rm -rf ./package/ssr/shadowsocks-rust
rm -rf ./package/ssr/mosdns
rm -rf ./package/ssr/trojan-plus
rm -rf ./package/ssr/xray-core
rm -rf ./package/ssr/xray-plugin
rm -rf ./package/ssr/naiveproxy
rm -rf ./package/ssr/v2ray-plugin
rm -rf ./package/ssr/v2ray-core
# rm -rf ./package/ssr/pdnsd

rm -rf ./package/ssr/lua-neturl
rm -rf ./package/ssr/redsocks2
rm -rf ./package/ssr/shadow-tls

rm -rf ./feeds/packages/net/brook
rm -rf ./feeds/packages/net/chinadns-ng
rm -rf ./feeds/packages/net/dns2socks
rm -rf ./feeds/packages/net/dns2tcp
rm -rf ./feeds/packages/net/pdnsd-alt
rm -rf ./feeds/packages/net/hysteria
rm -rf ./feeds/packages/net/gn
rm -rf ./feeds/packages/net/ipt2socks
rm -rf ./feeds/packages/net/microsocks
rm -rf ./feeds/packages/net/lua-neturl
rm -rf ./feeds/packages/net/naiveproxy
rm -rf ./feeds/packages/net/pdnsd
rm -rf ./feeds/packages/net/redsocks2
 rm -rf ./feeds/packages/net/simple-obfs
 rm -rf ./feeds/packages/net/tcping
 rm -rf ./feeds/packages/net/trojan
 rm -rf ./feeds/packages/net/tuic-client
 rm -rf ./feeds/packages/net/v2ray-geodata

#rm -rf ./feeds/packages/net/shadowsocks-libev
#rm -rf ./feeds/packages/net/shadowsocks-rust
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/xray-plugin

rm -rf ./feeds/packages/net/sing-box

rm -rf ./feeds/packages/net/mosdns
rm -rf ./feeds/packages/net/trojan-plus
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/xray-plugin
rm -rf ./feeds/packages/net/naiveproxy
rm -rf ./feeds/packages/net/v2ray-plugin
rm -rf ./feeds/packages/net/v2ray-core
rm -rf ./feeds/packages/net/pdnsd
rm -rf ./feeds/packages/net/lua-neturl
rm -rf ./feeds/packages/net/redsocks2
rm -rf ./feeds/packages/net/shadow-tls

rm -rf  ./feeds/luci/applications/luci-app-netdata
mv -f ./package/other/up/netdata/ ./package/

rm -rf ./package/other/up/tool/luci-app-socat
# rm -rf ./feeds/luci/applications/luci-app-socat  ./package/feeds/luci/luci-app-socat

mv -f ./package/other/up/tool ./package/
mv -f ./package/other/up/pass ./package/
sed -i 's,default n,default y,g' ./package/pass/luci-app-bypass/Makefile


#dae
#rm -rf  ./feeds/packages/net/daed
#rm -rf  ./package/kernel/bpf-headers
#rm -rf  ./feeds/luci/applications/luci-app-daed

rm -rf ./package/other

cat  patch/banner > ./package/base-files/files/etc/banner
cat  patch/profile > ./package/base-files/files/etc/profile
cat  patch/profiles > ./package/base-files/files/etc/profiles
cat  patch/sysctl.conf > ./package/base-files/files/etc/sysctl.conf

mkdir -p files/usr/share
mkdir -p files/etc/root
# rm -rf $(find ./package/emortal/ -type d -regex ".*\(autocore\|automount\|autosamba\|default-settings\).*")
rm -rf ./package/emortal/autocore ./package/emortal/automount  ./package/emortal/autosamba  ./package/emortal/default-settings 
mv -rf ./package/emortal2/autocore  ./package/emortal/autocore 
mv -rf  ./package/emortal2/default-settings   ./package/emortal/default-settings 
mv -rf  ./package/emortal2/automount   ./package/emortal/automount
mv -rf  ./package/emortal2/autosamba   ./package/emortal/autosamba


#修改默认主机名
sed -i "s/hostname='.*'/hostname='EzOpWrt'/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate

#  coremark
sed -i '/echo/d' ./feeds/packages/utils/coremark/coremark

git clone https://github.com/sirpdboy/luci-app-lucky ./package/lucky
rm ./package/lucky/luci-app-lucky/po/zh_Hans
mv ./package/lucky/luci-app-lucky/po/zh-cn ./package/ddns-go/luci-app-lucky/po/zh_Hans
rm -rf ./feeds/packages/net/ddns-go
rm -rf  ./feeds/luci/applications/luci-app-ddns-go
git clone https://github.com/sirpdboy/luci-app-ddns-go ./package/ddns-go
rm ./package/ddns-go/luci-app-ddns-go/po/zh_Hans
mv ./package/ddns-go/luci-app-ddns-go/po/zh-cn ./package/ddns-go/luci-app-ddns-go/po/zh_Hans

# nlbwmon
sed -i 's/524288/16777216/g' feeds/packages/net/nlbwmon/files/nlbwmon.config
# 可以设置汉字名字
sed -i '/o.datatype = "hostname"/d' feeds/luci/modules/luci-mod-admin-full/luasrc/model/cbi/admin_system/system.lua
# sed -i '/= "hostname"/d' /usr/lib/lua/luci/model/cbi/admin_system/system.lua

git clone  https://github.com/linkease/nas-packages-luci ./package/nas-packages-luci
git clone  https://github.com/linkease/nas-packages ./package/nas-packages
git clone  https://github.com/linkease/istore ./package/istore
sed -i 's/1/0/g' ./package/nas-packages/network/services/linkease/files/linkease.config
sed -i 's/luci-lib-ipkg/luci-base/g' package/istore/luci/luci-app-store/Makefile

rm -rf ./feeds/packages/net/mosdns
rm -rf ./feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone https://github.com/sbwml/v2ray-geodata feeds/packages/net/v2ray-geodata

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 21.x feeds/packages/lang/golang
# git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
# alist 
# rm -rf ./feeds/packages/net/alist
# rm -rf  ./feeds/luci/applications/luci-app-alist
# git clone https://github.com/sbwml/luci-app-alist package/alist
# sed -i 's/网络存储/存储/g' ./package/alist/luci-app-alist/po/zh-cn/alist.po

#设置upnpd
#sed -i 's/option enabled.*/option enabled 0/' feeds/*/*/*/*/upnpd.config
#sed -i 's/option dports.*/option enabled 2/' feeds/*/*/*/*/upnpd.config

sed -i "s/ImmortalWrt/EzOpWrt/" {package/base-files/files/bin/config_generate,include/version.mk}
sed -i "s/OpenWrt/EzOpWrt/" {package/base-files/files/bin/config_generate,include/version.mk}
sed -i "/listen_https/ {s/^/#/g}" package/*/*/*/files/uhttpd.config
sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' ./feeds/luci/applications/luci-app-socat/po/*/socat.po

sed -i 's/"Argon 主题设置"/"Argon设置"/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' `grep "Turbo ACC 网络加速" -rl ./`
sed -i 's/"网络存储"/"存储"/g' `grep "网络存储" -rl ./`
sed -i 's/"USB 打印服务器"/"打印服务"/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/"P910nd - 打印服务器"/"打印服务"/g' `grep "P910nd - 打印服务器" -rl ./`
sed -i 's/"带宽监控"/"监控"/g' `grep "带宽监控" -rl ./`
sed -i 's/实时流量监测/流量/g'  `grep "实时流量监测" -rl ./`
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g'  `grep "解锁网易云灰色歌曲" -rl ./`
sed -i 's/解除网易云音乐播放限制/解锁灰色歌曲/g'  `grep "解除网易云音乐播放限制" -rl ./`
sed -i 's/家庭云//g'  `grep "家庭云" -rl ./`

sed -i 's/监听端口/监听端口 用户名admin密码adminadmin/g' ./feeds/luci/applications/luci-app-qbittorrent/po/*/qbittorrent.po
# echo  "        option tls_enable 'true'" >> ./feeds/luci/applications/luci-app-frpc/root/etc/config/frp   #FRP穿透问题
sed -i 's/invalid/# invalid/g' ./package/network/services/samba36/files/smb.conf.template  #共享问题
sed -i '/mcsub_renew.datatype/d'  ./feeds/luci/applications/luci-app-udpxy/luasrc/model/cbi/udpxy.lua  #修复UDPXY设置延时55的错误
sed -i '/filter_/d' ./package/network/services/dnsmasq/files/dhcp.conf   #DHCP禁用IPV6问题
sed -i 's/请输入用户名和密码。/管理登陆/g' ./feeds/luci/modules/luci-base/po/*/base.po   #用户名密码

#cifs挂pan
sed -i 's/mount -t cifs/busybox mount -t cifs/g' ./feeds/luci/applications/luci-app-cifs-mount/root/etc/init.d/cifs
#cifs
sed -i 's/nas/services/g' ./feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua   #dnsfilter
sed -i 's/a.default = "0"/a.default = "1"/g' ./feeds/luci/applications/luci-app-cifsd/luasrc/controller/cifsd.lua   #挂问题
echo  "        option tls_enable 'true'" >> ./feeds/luci/applications/luci-app-frpc/root/etc/config/frp   #FRP穿透问题
sed -i 's/invalid/# invalid/g' ./package/network/services/samba36/files/smb.conf.template  #共享问题
sed -i '/mcsub_renew.datatype/d'  ./feeds/luci/applications/luci-app-udpxy/luasrc/model/cbi/udpxy.lua  #修复UDPXY设置延时55的错误

#断线不重拨
sed -i 's/q reload/q restart/g' ./package/network/config/firewall/files/firewall.hotplug

#echo "其他修改"
sed -i 's/option commit_interval.*/option commit_interval 1h/g' feeds/packages/net/nlbwmon/files/nlbwmon.config #修改流量统计写入为1h
# sed -i 's#option database_directory /var/lib/nlbwmon#option database_directory /etc/config/nlbwmon_data#g' feeds/packages/net/nlbwmon/files/nlbwmon.config #修改流量统计数据存放默认位置

# echo '默认开启 Irqbalance'
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

# NPS内网穿透的客户端NPC
# rm -rf  ./feeds/luci/applications/luci-app-npc
# rm -rf  ./feeds/packages/net/npc
# git clone https://github.com/yhl452493373/npc.git package/npc
# git clone https://github.com/yhl452493373/luci-app-npc.git package/luci-app-npc
#luci-app-npc
# sed -i '/msgid "Nps Client"/i\msgid "Npc"\nmsgstr "NPS穿透"\n' package/luci-app-npc/po/zh_Hans/npc.po
#luci-app-upnp
sed -i 's/msgstr "UPnP"/msgstr "即插即用"/g' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po
sed -i 's/msgstr "通用即插即用（UPnP）"/msgstr "即插即用（UPnP）"/g' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po
#luci-app-nft-qos
sed -i 's/msgstr "QoS Nftables 版"/msgstr "服务质量"/g' feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
#luci-app-ttyd
# sed -i 's/msgstr "终端"/msgstr "网页终端"/g' feeds/luci/applications/luci-app-ttyd/po/zh_Hans/ttyd.po
# sed -i "s/src: (ssl === '1' ? 'https' : 'http')/src: (ssl === '1' ? 'https' : window.location.protocol.replace(':',''))/g" feeds/luci/applications/luci-app-ttyd/htdocs/luci-static/resources/view/ttyd/term.js


if [ ${CONFIG_S}='xxx' ]; then

# Try dnsmasq v2.89 with pkg version 7
dnsmasq_path="package/network/services/dnsmasq"
dnsmasq_ver=$(grep -m1 'PKG_UPSTREAM_VERSION:=2.89' ${dnsmasq_path}/Makefile)
if [ -z "${dnsmasq_ver}" ]; then
    rm -rf $dnsmasq_path
    cp ./data/etc/ipcalc.sh package/base-files/files/bin/ipcalc.sh
    cp -r ./data/dnsmasq ${dnsmasq_path}
    echo "Try dnsmasq v2.89"
else
# upgrade dnsmasq to version 2.89
    pkg_ver=$(grep -m1 'PKG_RELEASE:=7' ${dnsmasq_path}/Makefile)
    if [ -z "${pkg_ver}" ]; then
        # rm -rf $dnsmasq_path
        # cp $GITHUB_WORKSPACE/data/etc/ipcalc.sh package/base-files/files/bin/ipcalc.sh
        # cp -r $GITHUB_WORKSPACE/data/dnsmasq ${dnsmasq_path}
        echo "Already dnsmasq v2.89"
    fi
fi

# make minidlna depends on libffmpeg-full instead of libffmpeg
# little bro ffmpeg mini custom be gone
sed -i "s/libffmpeg /libffmpeg-full /g" feeds/packages/multimedia/minidlna/Makefile
echo "Set minidlna depends on libffmpeg-full instead of libffmpeg"

# make cshark depends on libustream-openssl instead of libustream-mbedtls
# i fucking hate stupid mbedtls so much, be gone
sed -i "s/libustream-mbedtls/libustream-openssl/g" feeds/packages/net/cshark/Makefile
echo "Set cshark depends on libustream-openssl instead of libustream-mbedtls"

# remove ipv6-helper depends on odhcpd*
sed -i "s/+odhcpd-ipv6only//g" feeds/CustomPkgs/net/ipv6-helper/Makefile
echo "Remove ipv6-helper depends on odhcpd*"

# remove hnetd depends on odhcpd*
sed -i "s/+odhcpd//g" feeds/routing/hnetd/Makefile
echo "Remove hnetd depends on odhcpd*"

# make shairplay depends on mdnsd instead of libavahi-compat-libdnssd
sed -i "s/+libavahi-compat-libdnssd/+mdnsd/g" feeds/packages/sound/shairplay/Makefile
echo "Set shairplay depends on mdnsd instead of libavahi-compat-libdnssd"

fi
git clone https://github.com/yaof2/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
sed -i 's/, 1).d/, 11).d/g' ./package/luci-app-ikoolproxy/luasrc/controller/koolproxy.lua


# Add OpenClash

rm -rf  ./feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash package/openclash
sed -i 's/+libcap /+libcap +libcap-bin /' package/openclash/luci-app-openclash/Makefile

rm -rf ./feeds/luci/themes/luci-theme-design
 git clone -b js https://github.com/gngpp/luci-theme-design.git  package/luci-theme-design

rm -rf ./feeds/luci/themes/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git  package/luci-theme-argon
sed -i 's,media .. \"\/b,resource .. \"\/b,g' ./package/luci-theme-argon/luasrc/view/themes/argon/sysauth.htm
sed -i 's,media .. \"\/b,resource .. \"\/b,g' ./feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/sysauth.htm
# 使用默认取消自动
# sed -i "s/bootstrap/chuqitopd/g" feeds/luci/modules/luci-base/root/etc/config/luci
# sed -i 's/bootstrap/chuqitopd/g' feeds/luci/collections/luci/Makefile
echo "修改默认主题"
sed -i 's/+luci-theme-bootstrap/+luci-theme-kucat/g' feeds/luci/collections/luci/Makefile
# sed -i "s/luci-theme-bootstrap/luci-theme-$OP_THEME/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
# sed -i 's/+luci-theme-bootstrap/+luci-theme-opentopd/g' feeds/luci/collections/luci/Makefile
sed -i '/set luci.main.mediaurlbase=/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i '/set luci.main.mediaurlbase/d' ./package/luci-theme-argon/root/etc/uci-defaults/30_luci-theme-argon
sed -i '/set luci.main.mediaurlbase/d' feeds/luci/themes/luci-theme-argon/root/etc/uci-defaults/30_luci-theme-argon
sed -i '/set luci.main.mediaurlbase/d' package/luci-theme-argon/root/etc/uci-defaults/30_luci-theme-argon
sed -i '/set luci.main.mediaurlbase=/d' feeds/luci/themes/luci-theme-material/root/etc/uci-defaults/30_luci-theme-material
sed -i '/set luci.main.mediaurlbase=/d' feeds/luci/themes/luci-theme-design/root/etc/uci-defaults/30_luci-luci-theme-design
sed -i '/set luci.main.mediaurlbase=/d' package/luci-theme-design/root/etc/uci-defaults/30_luci-theme-design


# 取消主题默认设置
find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;
sed -i '/check_signature/d' ./package/system/opkg/Makefile   # 删除IPK安装签名
sed -i 's/START=95/START=99/' `find package/ -follow -type f -path */ddns-scripts/files/ddns.init`
#Add x550
git clone https://github.com/shenlijun/openwrt-x550-nbase-t package/openwrt-x550-nbase-t

# 修改makefile
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/lang\/golang\/golang\-package\.mk/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang\-package\.mk/g' {}

# 修复 hostapd 报错
#cp -f $GITHUB_WORKSPACE/scriptx/011-fix-mbo-modules-build.patch package/network/services/hostapd/patches/011-fix-mbo-modules-build.patch

# sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=5.4/g' ./target/linux/*/Makefile
# sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.4/g' ./target/linux/*/Makefile

# 预处理下载相关文件，保证打包固件不用单独下载
for sh_file in `ls ${GITHUB_WORKSPACE}/openwrt/common/*.sh`;do
    source $sh_file amd64
done

if [[ $DATE_S == 'default' ]]; then
   DATA=`TZ=UTC-8 date +%Y.%m.%d -d +"12"hour`
else 
   DATA=$DATE_S
fi

VER1="$(grep "KERNEL_PATCHVER:="  ./target/linux/x86/Makefile | cut -d = -f 2)"
ver54=`grep "LINUX_VERSION-5.4 ="  include/kernel-5.4 | cut -d . -f 3`
ver515=`grep "LINUX_VERSION-5.15 ="  include/kernel-5.15 | cut -d . -f 3`
ver61=`grep "LINUX_VERSION-6.1 ="  include/kernel-6.1 | cut -d . -f 3`
date1="${CONFIG_S}-${DATA}_by_Sirpdboy"
if [ "$VER1" = "5.4" ]; then
date2="EzOpWrt ${CONFIG_S}-${DATA}-${VER1}.${ver54}_by_Sirpdboy"
elif [ "$VER1" = "5.15" ]; then
date2="EzOpWrt ${CONFIG_S}-${DATA}-${VER1}.${ver515}_by_Sirpdboy"
elif [ "$VER1" = "6.1" ]; then
date2="EzOpWrt ${CONFIG_S}-${DATA}-${VER1}.${ver61}_by_Sirpdboy"
fi
echo "${date1}" > ./package/base-files/files/etc/ezopenwrt_version
echo "${date2}" >> ./package/base-files/files/etc/banner
echo '---------------------------------' >> ./package/base-files/files/etc/banner
[ ! -d files/root ] || mkdir -p files/root
[ -f ./files/root/.zshrc ] || cp  -Rf patch/z.zshrc files/root/.zshrc
[ -f ./files/root/.zshrc ] || cp  -Rf ./z.zshrc ./files/root/.zshrc

cat>buildmd5.sh<<-\EOF
#!/bin/bash
# rm -rf $(find ./bin/targets/ -iregex ".*\(json\|manifest\|buildinfo\|sha256sums\|packages\)$")rm -rf  bin/targets/x86/64/config.buildinfo
rm -rf  bin/targets/x86/64/config.buildinfo
rm -rf  bin/targets/x86/64/feeds.buildinfo
rm -rf  bin/targets/x86/64/*x86-64-generic-kernel.bin
rm -rf  bin/targets/x86/64/*rootfs.tar.gz
rm -rf  bin/targets/x86/64/*x86-64-generic-squashfs-rootfs.img.gz
rm -rf  bin/targets/x86/64/*x86-64-generic-rootfs.tar.gz
rm -rf  bin/targets/x86/64/*x86-64-generic.manifest
rm -rf  bin/targets/x86/64/*.vmdk
rm -rf  bin/targets/x86/64/sha256sums
rm -rf  bin/targets/x86/64/version.buildinfo
rm -rf bin/targets/x86/64/*x86-64-generic-ext4-rootfs.img.gz
rm -rf bin/targets/x86/64/*x86-64-generic-ext4-combined-efi.img.gz
rm -rf bin/targets/x86/64/*x86-64-generic-ext4-combined.img.gz
rm -rf bin/targets/x86/64/profiles.json
rm -rf bin/targets/x86/64/*kernel.bin
sleep 2
r_version=`cat ./package/base-files/files/etc/ezopenwrt_version`
VER1="$(grep "KERNEL_PATCHVER:="  ./target/linux/x86/Makefile | cut -d = -f 2)"
ver54=`grep "LINUX_VERSION-5.4 ="  include/kernel-5.4 | cut -d . -f 3`
ver515=`grep "LINUX_VERSION-5.15 ="  include/kernel-5.15 | cut -d . -f 3`
ver61=`grep "LINUX_VERSION-6.1 ="  include/kernel-6.1 | cut -d . -f 3`
sleep 2
if [ "$VER1" = "5.4" ]; then
mv  bin/targets/x86/64/*-x86-64-generic-squashfs-combined.img.gz       bin/targets/x86/64/EzOpenWrt-${r_version}_${VER1}.${ver54}-x86-64-combined.img.gz   
mv  bin/targets/x86/64/*-x86-64-generic-squashfs-combined-efi.img.gz   bin/targets/x86/64/EzOpenWrt-${r_version}_${VER1}.${ver54}-x86-64-combined-efi.img.gz
md5_EzOpWrt=EzOpenWrt-${r_version}_${VER1}.${ver54}-x86-64-combined.img.gz   
md5_EzOpWrt_uefi=EzOpenWrt-${r_version}_${VER1}.${ver54}-x86-64-combined-efi.img.gz
elif [ "$VER1" = "5.15" ]; then
mv  bin/targets/x86/64/*-x86-64-generic-squashfs-combined.img.gz       bin/targets/x86/64/EzOpenWrt-${r_version}_${VER1}.${ver515}-x86-64-combined.img.gz   
mv  bin/targets/x86/64/*-x86-64-generic-squashfs-combined-efi.img.gz   bin/targets/x86/64/EzOpenWrt-${r_version}_${VER1}.${ver515}-x86-64-combined-efi.img.gz
md5_EzOpWrt=EzOpenWrt-${r_version}_${VER1}.${ver515}-x86-64-combined.img.gz   
md5_EzOpWrt_uefi=EzOpenWrt-${r_version}_${VER1}.${ver515}-x86-64-combined-efi.img.gz
elif [ "$VER1" = "6.1" ]; then
mv  bin/targets/x86/64/*-x86-64-generic-squashfs-combined.img.gz       bin/targets/x86/64/EzOpenWrt-${r_version}_${VER1}.${ver61}-x86-64-combined.img.gz   
mv  bin/targets/x86/64/*-x86-64-generic-squashfs-combined-efi.img.gz   bin/targets/x86/64/EzOpenWrt-${r_version}_${VER1}.${ver61}-x86-64-combined-efi.img.gz
md5_EzOpWrt=EzOpenWrt-${r_version}_${VER1}.${ver61}-x86-64-combined.img.gz   
md5_EzOpWrt_uefi=EzOpenWrt-${r_version}_${VER1}.${ver61}-x86-64-combined-efi.img.gz
fi
#md5
cd bin/targets/x86/64
md5sum ${md5_EzOpWrt} > EzOpWrt_combined.md5  || true
md5sum ${md5_EzOpWrt_uefi} > EzOpWrt_combined-efi.md5 || true
exit 0
EOF

cat>bakkmod.sh<<-\EOF
#!/bin/bash
kmoddirdrv=./files/etc/kmod.d/drv
kmoddirdocker=./files/etc/kmod.d/docker
bakkmodfile=./patch/kmod.source
nowkmodfile=./files/etc/kmod.now
mkdir -p $kmoddirdrv 2>/dev/null
mkdir -p $kmoddirdocker 2>/dev/null
cp -rf ./patch/list.txt $bakkmodfile
while IFS= read -r file; do
    a=`find ./bin/ -name "$file" `
    echo $a
    if [ -z "$a" ]; then
        echo "no find: $file"
    else
        cp -f $a $kmoddirdrv
	echo $file >> $nowkmodfile
        if [ $? -eq 0 ]; then
            echo "cp ok: $file"
        else
            echo "no cp:$file"
        fi
    fi
done < $bakkmodfile
find ./bin/ -name "*dockerman*.ipk" | xargs -i cp -f {} $kmoddirdocker
EOF

cat>./package/base-files/files/etc/kmodreg<<-\EOF
#!/bin/bash
# EzOpenWrt By Sirpdboy
IPK=$1
nowkmoddir=/etc/kmod.d/$IPK
[ ! -d $nowkmoddir ]  || return

run_drv() {
opkg update
for file in `ls $nowkmoddir/*.ipk`;do
    opkg install "$file"  --force-depends
done

}
run_docker() {
opkg update
opkg install $nowkmoddir/luci-app-dockerman*.ipk --force-depends
opkg install $nowkmoddir/luci-i18n-dockerman*.ipk --force-depends
	uci -q get dockerd.globals 2>/dev/null && {
		uci -q set dockerd.globals.data_root='/opt/docker/'
		uci -q set dockerd.globals.auto_start='1'
  		uci commit dockerd
  		/etc/init.d/dockerd enabled
		rm -rf /tmp/luci*
		/etc/init.d/dockerd restart
		/etc/init.d/rpcd restart
		 /etc/init.d/avahi-daemon enabled
		 /etc/init.d/avahi-daemon start
	}
}
case "$IPK" in
	"drv")
		run_drv
	;;
	"docker")
		run_docker
	;;
esac
EOF

# 清理可能因patch存在的冲突文件
find ./ -name *.orig | xargs rm -rf
find ./ -name *.rej | xargs rm -rf

./scripts/feeds update -i
./scripts/feeds install -i
cat  ./x86_64/${CONFIG_S}  > .config
case "${CONFIG_S}" in
"Vip"*)
# cat  ./x86_64/comm  >> .config
;;
esac
