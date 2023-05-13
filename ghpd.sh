#!/bin/bash

# 询问域名
read -p "请输入要绑定的域名: " domain

# 检查域名是否解析成功
ip_address=$(dig +short $domain)
if [ -z "$ip_address" ]; then
  echo "域名解析失败，请确保域名已正确配置DNS解析。"
  exit 1
fi

# 安装 Caddy 容器
docker run -d \
  --name caddy \
  -p 80:80 \
  -p 443:443 \
  -v /path/to/Caddyfile:/etc/caddy/Caddyfile \
  -v caddy_data:/data \
  -v caddy_config:/config \
  caddy

# 创建 Caddyfile
echo "$domain {
  reverse_proxy localhost:7823
}" > /path/to/Caddyfile

# 重启 Caddy 容器
docker restart caddy

echo "Caddy 安装并配置成功。现在你的域名 $domain 已被绑定到本机容器的 7823 端口。"
