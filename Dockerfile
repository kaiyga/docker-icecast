FROM debian:stable-slim

LABEL maintainer="Kaiy Ragur <kaiyga@proton.me>"
LABEL source="https://github.com/kaiyga/docker-icecast"
LABEL org.opencontainers.image.source="https://github.com/kaiyga/docker-icecast"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq -y update && \
    apt-get -qq -y install --no-install-recommends \
        icecast2 \
        gettext-base \
        ca-certificates \
        curl \
        sudo && \
    curl -fsSL https://github.com/bluebrown/go-template-cli/releases/latest/download/tpl-linux-amd64 > /usr/bin/tpl && \
    chmod 755 /usr/bin/tpl && \
    apt-get -y autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./start.sh /start.sh
COPY ./etc /etc

RUN chmod +x /start.sh && \
    chown -R icecast2 /etc/icecast2 /var/log/icecast2

EXPOSE 8000
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]

CMD ["/start.sh"]
