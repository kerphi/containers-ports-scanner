FROM nginx:1.20.2

ENV CPS_SERVERS_TO_SCAN="/"



# install the docker and docker-compose client inside this image
# because the docker client commande line is used to scan the ports
ENV DOCKER_VERSION 20.10.9
RUN set -x \
  && curl -fL -o docker.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" \
  && tar -xzvf docker.tgz \
  && mv docker/* /usr/local/bin/ \
  && rmdir docker \
  && rm docker.tgz \
  && docker -v

COPY ./do-scan-containers-ports.sh /
COPY ./docker-entrypoint.sh /

#/usr/share/nginx/html/
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
