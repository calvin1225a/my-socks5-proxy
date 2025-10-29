FROM alpine:latest

# 安装 dante-server 和 iproute2（用于动态 IP 获取）
RUN apk add --no-cache dante-server iproute2

COPY danted.conf /etc/danted.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 1080

ENTRYPOINT ["/entrypoint.sh"]
