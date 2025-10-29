FROM alpine:latest

# 安装 dante-server 和 openssl（关键！）
RUN apk add --no-cache dante-server openssl

# 复制配置文件和脚本
COPY danted.conf /etc/danted.conf
COPY entrypoint.sh /entrypoint.sh

# 赋予执行权限
RUN chmod +x /entrypoint.sh

# 暴露端口
EXPOSE 1080

# 启动
ENTRYPOINT ["/entrypoint.sh"]
