FROM n8nio/n8n:latest

USER root
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://tailscale.com/install.sh | sh

CMD tailscaled --state=/data/tailscale.state & \
    sleep 3 && \
    tailscale up --authkey=${TS_AUTHKEY} --hostname=n8n-railway --accept-routes --accept-dns=false && \
    n8n
