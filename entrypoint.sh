#!/bin/sh

# 使用环境变量
USERNAME="${PROXY_USER:-daqiang}"
PASSWORD="${PROXY_PASSWORD:-summer125}"

# 生成密码文件
echo "$USERNAME:$PASSWORD" > /etc/danted.passwd

# 动态获取容器 IP（Alpine 兼容！）
CONTAINER_IP=$(hostname -i)

# 替换 danted.conf 中的 external 为实际 IP（避免 wildcard）
sed -i "s/external: eth0/external: $CONTAINER_IP/" /etc/danted.conf

# 启动 sockd
exec sockd -f /etc/danted.conf -D
