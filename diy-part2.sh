#!/bin/bash
set -e

# 只对 an7581 生效（prepare 阶段会对每个 config 各跑一次这个脚本）
BOARD=$(sed -n 's/^CONFIG_TARGET_BOARD="\(.*\)"$/\1/p' .config)
SUBTARGET=$(sed -n 's/^CONFIG_TARGET_SUBTARGET="\(.*\)"$/\1/p' .config)
[ "$BOARD/$SUBTARGET" = "airoha/an7581" ] || exit 0

# ① 单一机型：清掉所有 CONFIG_TARGET_DEVICE_*，只保留 HG5382A
grep -v '^CONFIG_TARGET_DEVICE_' .config > .config.tmp
echo 'CONFIG_TARGET_DEVICE_airoha_an7581_DEVICE_fiberhome_hg5382a=y' >> .config.tmp
mv .config.tmp .config

# ② 去掉 upnp（这条来自 release.config 的合并结果）
sed -i 's/^CONFIG_PACKAGE_luci-app-upnp=y/# CONFIG_PACKAGE_luci-app-upnp is not set/' .config

# ③ 加自己想要的插件
cat >> .config <<'EOF'
CONFIG_PACKAGE_luci-app-airoha-npu=y
CONFIG_PACKAGE_openssh-sftp-server=y
EOF
