FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache postgresql-client bash curl openssl

# Copia e instala as dependências do backend
COPY backend-node/package*.json backend-node/
WORKDIR /app/backend-node
RUN npm install

# Copia e instala as dependências do frontend
WORKDIR /app
COPY frontend-next/package*.json frontend-next/
WORKDIR /app/frontend-next
RUN npm install

# Copia o restante do código
WORKDIR /app
COPY backend-node backend-node/
COPY frontend-next frontend-next/

# Faz o build do frontend
WORKDIR /app/frontend-next
RUN npm run build

WORKDIR /app
# O comando CMD vai rodar o backend e o frontend (next start)
CMD ["sh", "-c", "cd /app/backend-node && npm run dev & cd /app/frontend-next && npm run start & wait"]
