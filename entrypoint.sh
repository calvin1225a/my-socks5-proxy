#!/bin/sh

# 检查环境变量
if [ -z "$PROXY_USER" ] || [ -z "$PROXY_PASSWORD" ]; then
  echo "错误: 必须设置 PROXY_USER 和 PROXY_PASSWORD 环境变量。"
  exit 1
fi

# 创建用户并设置密码
adduser -D -s /bin/false "$PROXY_USER"
echo "$PROXY_USER:$PROXY_PASSWORD" | chpasswd
echo "SOCKS5 代理用户 $PROXY_USER 已创建。"

# --- 动态配置 danted.conf ---
echo "正在检测容器 IP..."
# 使用 ip route 命令找到默认的出口 IP (e.g., 172.17.0.2)
# BusyBox (Alpine 自带) 的 'ip route' 支持这个命令
CONTAINER_IP=$(ip route get 1.1.1.1 | awk -F'src ' 'NF>1{print $2}' | awk '{print $1}')

if [ -z "$CONTAINER_IP" ]; then
    echo "错误: 无法自动检测到容器 IP。"
    # 提供一个备用方案
    CONTAINER_IP=$(hostname -i | awk '{print $1}')
    if [ -z "$CONTAINER_IP" ]; then
        echo "备用方案 (hostname -i) 也失败了。"
        exit 1
    fi
fi

echo "检测到容器 IP: $CONTAINER_IP"

# 使用 sed 命令将 danted.conf 中的占位符替换为实际的 IP
sed -i "s/__EXTERNAL_IP__/$CONTAINER_IP/g" /etc/danted.conf
echo "danted.conf 配置已更新。"
# --- 动态配置结束 ---

# 在前台启动 dante 服务器
echo "正在启动 SOCKS5 代理服务..."
exec /usr/sbin/sockd -f /etc/danted.conf -D
