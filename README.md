# gh-proxy

### Docker部署

安装docker

```
curl -sSL https://get.docker.com/ | sh
```

docker部署

```
docker run -d --name="gh-proxy" \
  -p 0.0.0.0:80:80 \
  --restart=always \
  ghcr.io/spiritlhls/ghproxy:latest
```

第一个80是你要暴露出去的端口，如果使用80端口，绑定cf解析的域名到本机IP再启用cf代理即可使用域名

```
docker stop gh-proxy && docker rm gh-proxy && docker rmi ghcr.io/spiritlhls/ghproxy:latest
```

基于原作者的魔改版本，替换了原有的大镜像，缩小了镜像，替换上传地址为github的地址而非docekerhub官方地址
