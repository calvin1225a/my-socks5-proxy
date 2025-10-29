#!/bin/sh

# 设置用户名和密码（请修改！）
USERNAME="daqiang"
PASSWORD="daqiang123456"  # ← 修改成你的强密码！

# 直接写明文密码文件（dante 支持明文）
echo "$USERNAME:$PASSWORD" > /etc/danted.passwd

# 启动 danted
exec danted -f /etc/danted.conf -D
