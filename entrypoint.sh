#!/bin/sh

# 设置用户名和密码
USERNAME="daqiang"
PASSWORD="daqiang123456"  # ← 修改成你的密码！

# 直接写明文密码文件
echo "$USERNAME:$PASSWORD" > /etc/danted.passwd

# 启动 sockd（Alpine 正确命令！）
exec sockd -f /etc/danted.conf -D
