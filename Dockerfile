FROM guysoft/uwsgi-nginx:python3.8-alpine
LABEL maintainer="spiritlhl <admin@spiritlhl.net>"
RUN apk add --no-cache bash && \
    pip install --no-cache-dir flask requests
COPY ./app /app
WORKDIR /app
ENV PYTHONPATH=/app
RUN mv /entrypoint.sh /uwsgi-nginx-entrypoint.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 80
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["/start.sh"]
