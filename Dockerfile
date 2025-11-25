FROM n8nio/n8n:latest

USER root

# Atualizar e instalar dependências básicas
RUN apk update && \
    apk add --no-cache curl iptables ip6tables bash

# Adicionar manualmente repositório da Tailscale para Alpine
RUN echo "https://pkgs.tailscale.com/stable/alpine/v3.22/main" >> /etc/apk/repositories && \
    echo "https://pkgs.tailscale.com/stable/alpine/v3.22/community" >> /etc/apk/repositories && \
    apk update

# Instalar Tailscale
RUN apk add --no-cache tailscale

# Iniciar tailscaled + n8n juntos
CMD tailscaled --state=/data/tailscale.state & \
    sleep 3 && \
    tailscale up --authkey=${TS_AUTHKEY} --hostname="n8n-railway" --accept-routes --accept-dns=false && \
    n8n
