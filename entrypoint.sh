#!/bin/sh

# 使用 Railway 环境变量
USERNAME="${PROXY_USER:-daqiang}"
PASSWORD="${PROXY_PASSWORD:-summer125}"

# 生成密码文件
echo "$USERNAME:$PASSWORD" > /etc/danted.passwd

# 启动 sockd
exec sockd -f /etc/danted.conf -D
