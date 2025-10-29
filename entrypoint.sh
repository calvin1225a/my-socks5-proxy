#!/bin/sh
USERNAME="${PROXY_USER:-daqiang}"
PASSWORD="${PROXY_PASSWORD:-summer1225}"
# dante username 格式：user:pass 明文文件
printf "%s:%s\n" "$USERNAME" "$PASSWORD" > /etc/danted.passwd
exec sockd -f /etc/danted.conf -D
