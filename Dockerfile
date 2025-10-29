# 使用一个超轻量的 Alpine Linux 镜像
FROM alpine:3.18

# 安装 dante-server (一个稳定且强大的 SOCKS 服务器)
RUN apk add --no-cache dante-server linux-pam-dev

# 复制我们的配置文件
COPY danted.conf /etc/danted.conf

# 复制我们的启动脚本
COPY entrypoint.sh /entrypoint.sh
# 给予启动脚本执行权限
RUN chmod +x /entrypoint.sh

# 暴露 1080 端口
EXPOSE 1080

# 容器启动时运行启动脚本
ENTRYPOINT ["/entrypoint.sh"]
