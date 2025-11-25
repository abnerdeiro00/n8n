FROM node:18-bookworm

USER root

# Instalar dependências essenciais
RUN apt-get update && apt-get install -y \
    curl \
    iptables \
    iproute2 \
    gnupg \
    sudo

# Instalar Tailscale (Bookworm)
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg \
    | gpg --dearmor -o /usr/share/keyrings/tailscale-archive-keyring.gpg && \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list \
    | tee /etc/apt/sources.list.d/tailscale.list && \
    apt-get update && apt-get install -y tailscale

# Instalar n8n globalmente
RUN npm install -g n8n

# Criar diretório de dados
RUN mkdir -p /data

# Rodar tailscale + n8n
CMD tailscaled --state=/data/tailscale.state & \
    sleep 3 && \
    tailscale up --authkey=${TS_AUTHKEY} --hostname="n8n-railway" --accept-routes --accept-dns=false && \
    n8n
