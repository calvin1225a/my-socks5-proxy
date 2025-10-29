# 使用轻量 Alpine 基础镜像
FROM alpine:latest

# 安装 dante-server
RUN apk add --no-cache dante-server

# 复制配置文件和启动脚本
COPY danted.conf /etc/danted.conf
COPY entrypoint.sh /entrypoint.sh

# 赋予执行权限
RUN chmod +x /entrypoint.sh

# 暴露 SOCKS5 端口
EXPOSE 1080

# 启动命令
ENTRYPOINT ["/entrypoint.sh"]
