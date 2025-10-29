#!/bin/sh

# 检查环境变量是否存在
if [ -z "$PROXY_USER" ] || [ -z "$PROXY_PASSWORD" ]; then
  echo "错误: 必须设置 PROXY_USER 和 PROXY_PASSWORD 环境变量。"
  exit 1
fi

# 创建一个新用户，并设置密码
# adduser 创建用户, chpasswd 设置密码
adduser -D -s /bin/false "$PROXY_USER"
echo "$PROXY_USER:$PROXY_PASSWORD" | chpasswd

echo "SOCKS5 代理用户 $PROXY_USER 已创建。"

# 在前台启动 dante 服务器 (Docker 容器需要这样)
echo "正在启动 SOCKS5 代理服务..."
exec /usr/sbin/danted -f /etc/danted.conf -D
