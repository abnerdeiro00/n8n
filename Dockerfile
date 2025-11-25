FROM n8nio/n8n:latest

# Railway define a variável PORT automaticamente; o n8n precisa usar N8N_PORT
ENV N8N_PORT=${PORT}
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=http

# Desabilita o editor externo
ENV N8N_EDITOR_BASE_URL=""

# Executa o N8N diretamente
CMD ["n8n"]
