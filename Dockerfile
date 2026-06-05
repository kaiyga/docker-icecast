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

RUN mkdir -p /app /var/log/icecast2 /var/run/icecast2 /etc/icecast2 

COPY ./start.sh /start.sh
COPY ./etc/icecast2/web /usr/share/icecast2/web
COPY ./etc/icecast2/admin /usr/share/icecast2/admin
COPY ./tmpl /tmpl

RUN chmod +x /start.sh && \
    chown -R icecast2: /etc/icecast2 /var/run/icecast2 /var/log/icecast2 /usr/share/icecast2 /tmpl

EXPOSE 8000
VOLUME ["/var/log/icecast2"]

CMD ["/start.sh"]
