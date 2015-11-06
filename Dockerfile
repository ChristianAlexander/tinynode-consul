FROM christianalexander/tinynode
MAINTAINER Christian Alexander <calexanderdev@gmail.com>

ENV CONSUL_VERSION=0.5.2

# Download and install Consul
# Configuration is to be put in /usr/local/share/consul/config
# Consul is available in /usr/local/bin
RUN export GOPATH=/go && \
    apk add --update go gcc musl-dev make bash ca-certificates && \
    update-ca-certificates && \
    go get github.com/hashicorp/consul && \
    cd $GOPATH/src/github.com/hashicorp/consul && \
    git checkout -q --detach "v$CONSUL_VERSION" && \
    make && \
    mv bin/consul /usr/local/bin && \
    rm -rf $GOPATH && \
    apk del go gcc musl-dev make bash && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /usr/local/share/consul/config

EXPOSE 8301 8301/udp
