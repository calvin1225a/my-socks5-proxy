#!/bin/sh

# 设置用户名和密码（请修改为你自己的！）
USERNAME="daqiang"
PASSWORD="your_strong_password_123"  # ←←← 修改这里！

# 生成加密密码文件
echo "$USERNAME:$(echo "$PASSWORD" | openssl passwd -stdin -apr1)" > /etc/danted.passwd

# 或者如果你不想用 openssl 加密（明文也行，但不安全）：
# echo "$USERNAME:$PASSWORD" > /etc/danted.passwd

# 启动 danted
exec danted -f /etc/danted.conf -D
