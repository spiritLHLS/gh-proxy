FROM guysoft/uwsgi-nginx:python3.8-alpine

LABEL maintainer="spiritlhl <admin@spiritlhl.net>"

# 安装 bash 和必须的 Python 包
RUN apk add --no-cache bash && \
    pip install --upgrade pip && \
    pip install flask requests

# 设置工作目录
WORKDIR /app
COPY ./app /app

# 设置环境变量，显式指定 PYTHONPATH 和 PATH
ENV PYTHONPATH=/usr/local/lib/python3.8/site-packages:/app \
    PATH=/usr/local/bin:$PATH

# 替换默认 entrypoint 脚本
RUN mv /entrypoint.sh /uwsgi-nginx-entrypoint.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 暴露端口
EXPOSE 80

# 启动容器时的 entrypoint 和默认命令
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["/start.sh"]
