FROM n8nio/n8n:latest

USER root

# Instalar dependências
RUN apk update && \
    apk add --no-cache curl iptables ip6tables bash

# Adicionar repositório da Tailscale para Alpine
RUN echo "https://pkgs.tailscale.com/stable/alpine/v3.22" >> /etc/apk/repositories

# Instalar Tailscale
RUN apk update && apk add --no-cache tailscale

# Iniciar tailscaled + n8n juntos
CMD tailscaled --state=/data/tailscale.state & \
    sleep 3 && \
    tailscale up --authkey=${TS_AUTHKEY} --hostname="n8n-railway" --accept-routes --accept-dns=false && \
    n8n
