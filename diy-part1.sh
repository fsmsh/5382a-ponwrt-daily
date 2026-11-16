#!/bin/bash
set -e

# luci-app-airoha-npu：rpcd 后端 + JS 视图 + menu/acl（不是 feed 里的包，必须自己拉）
git clone --depth 1 https://github.com/luanmuc/luci-app-airoha-npu.git \
  package/luci-app-airoha-npu
