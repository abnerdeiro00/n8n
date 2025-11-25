FROM n8nio/n8n:latest-debian

USER root

# Instalar dependências
RUN apt-get update && apt-get install -y curl iptables iproute2 gnupg && \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | gpg --dearmor -o /usr/share/keyrings/tailscale-archive-keyring.gpg && \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list && \
    apt-get update && apt-get install -y tailscale

CMD tailscaled --state=/data/tailscale.state & \
    sleep 3 && \
    tailscale up --authkey=${TS_AUTHKEY} --hostname="n8n-railway" --accept-routes --accept-dns=false && \
    n8n
