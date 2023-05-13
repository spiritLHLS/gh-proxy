#!/bin/bash
# from https://github.com/spiritLHLS/gh-proxy

cd /root >/dev/null 2>&1

# 询问域名
read -p "请输入要绑定的域名: " domain

# 检查域名是否解析成功
ip_address=$(dig +short $domain)
if [ -z "$ip_address" ]; then
  echo "域名解析失败，请确保域名已正确配置DNS解析。"
  exit 1
fi

# 检查 Caddy 文件夹是否存在，如果不存在则创建
caddy_folder="/root/Caddy"
if [ ! -d "$caddy_folder" ]; then
  mkdir -p "$caddy_folder"
fi

# 创建 Caddyfile
echo "$domain {
  reverse_proxy localhost:80
}" > "$caddy_folder/Caddyfile"

# 安装 Caddy 容器并映射数据目录和配置目录
docker run -d \
  --name caddy \
  -p 80:80 \
  -p 443:443 \
  -v "$caddy_folder/Caddyfile:/etc/caddy/Caddyfile" \
  -v "$caddy_folder/data:/data" \
  -v "$caddy_folder/config:/config" \
  caddy

echo "Caddy 安装并配置成功。现在你的域名 $domain 已被绑定到本机容器的 7823 端口。"
