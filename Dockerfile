FROM n8nio/n8n:latest

USER root

# Atualizar e instalar dependências básicas
RUN apk update && \
    apk add --no-cache curl iptables ip6tables bash

# Garantir que o repositório “community” esteja habilitado (Alpine)
RUN setup-apkrepos -c -1

# Instalar Tailscale via apk
RUN apk update && \
    apk add --no-cache tailscale

# Iniciar tailscaled + n8n juntos
CMD tailscaled --state=/data/tailscale.state & \
    sleep 3 && \
    tailscale up --authkey=${TS_AUTHKEY} --hostname="n8n-railway" --accept-routes --accept-dns=false && \
    n8n
