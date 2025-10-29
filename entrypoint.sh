#!/bin/sh

# 使用环境变量
USERNAME="${PROXY_USER:-daqiang}"
PASSWORD="${PROXY_PASSWORD:-summer125}"

# 生成密码文件
echo "$USERNAME:$PASSWORD" > /etc/danted.passwd

# 等待网络初始化（解决 eth0 绑定延迟）
sleep 5

# 启动 sockd（无需动态 IP）
exec sockd -f /etc/danted.conf -D
