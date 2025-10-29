#!/bin/sh

# 使用环境变量
USERNAME="${PROXY_USER:-daqiang}"
PASSWORD="${PROXY_PASSWORD:-summer125}"

# 生成密码文件
echo "$USERNAME:$PASSWORD" > /etc/danted.passwd

# 动态获取容器 IP（Alpine busybox 兼容）
CONTAINER_IP=$(hostname -i)

# 替换配置中的 PLACEHOLDER 为实际 IP
sed -i "s/external: PLACEHOLDER/external: $CONTAINER_IP/" /etc/danted.conf

# 启动 sockd
exec sockd -f /etc/danted.conf -D
