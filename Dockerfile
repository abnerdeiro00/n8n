FROM n8nio/n8n:latest

USER root

RUN apk update && \
    apk add --no-cache curl iptables ip6tables bash

RUN curl -fsSL https://tailscale.com/install.sh | sh

CMD tailscaled --state=/data/tailscale.state & \
    sleep 3 && \
    tailscale up --authkey=${TS_AUTHKEY} --hostname="n8n-railway" --accept-routes --accept-dns=false && \
    n8n
