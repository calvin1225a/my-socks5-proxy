#!/bin/sh

# 使用环境变量
USERNAME="${PROXY_USER:-daqiang}"
PASSWORD="${PROXY_PASSWORD:-summer125}"

# 生成密码文件
echo "$USERNAME:$PASSWORD" > /etc/danted.passwd

# 动态获取容器出口 IP（标准 Docker 方式，Alpine 兼容）
CONTAINER_IP=$(ip route get 1 | awk '{print $7;exit}')

# 替换 danted.conf 中的 external 为实际 IP
sed -i "s/external: eth0/external: $CONTAINER_IP/" /etc/danted.conf

# 启动 sockd
exec sockd -f /etc/danted.conf -D
