FROM app-base

RUN apt-get update \
 && apt-get install -yq --no-install-recommends nginx-core supervisor \
 && rm -rf /var/lib/apt/lists/*

COPY site.conf /etc/nginx/sites-enabled/default
COPY supervisor.conf /etc/supervisor/conf.d/
COPY entrypoint.sh /

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80
CMD ["/entrypoint.sh"]
