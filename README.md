# n8n + Tailscale on Railway

Este repositório permite rodar n8n com Tailscale integrado na Railway.

## Variáveis necessárias

- `TS_AUTHKEY`: Auth key do Tailscale (Reusable Key)
- `N8N_PORT`: Porta do n8n (padrão 5678)

## Como usar na Railway

1. Crie um projeto vazio
2. Clique em "Deploy from GitHub"
3. Selecione este repositório
4. Adicione as variáveis TS_AUTHKEY e N8N_PORT
5. Railway fará o deploy automaticamente

Após o deploy, acesse o painel:
`https://SEU-PROJETO.up.railway.app`
