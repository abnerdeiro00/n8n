FROM n8nio/n8n:latest

USER root

# Instalar dependências necessárias
RUN apk update && \
    apk add --no-cache \
        curl \
        iptables \
        ip6tables \
        bash

# Instalar Tailscale (versão Alpine)
RUN curl -fsSL https://pkgs.tailscale.com/stable/alpine/tailscale-stable.apk -o /tmp/tailscale.apk && \
    apk add --allow-untrusted /tmp/tailscale.apk && \
    rm /tmp/tailscale.apk

# Rodar tailscaled + n8n juntos
CMD tailscaled --state=/data/tailscale.state & \
    sleep 3 && \
    tailscale up --authkey=${TS_AUTHKEY} --hostname="n8n-railway" --accept-routes --accept-dns=false && \
    n8n
