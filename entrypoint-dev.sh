#!/bin/bash
set -e

echo "╔════════════════════════════════════════════════════╗"
echo "║   EscolaConnect V2.0 - Ambiente Integrado         ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""

# Aguardar PostgreSQL
echo "⏳ Aguardando PostgreSQL iniciar..."
while ! nc -z postgres 5432; do
  sleep 1
done
echo "✅ PostgreSQL pronto!"
echo ""

# Backend setup
echo "📦 Setup Backend (Fastify)..."
cd /app/backend-v2

if [ ! -d "node_modules" ]; then
  echo "  Installing dependencies..."
  npm install --quiet
fi

echo "  Compilando TypeScript..."
npm run build

echo "  Migrando database..."
npx prisma migrate deploy

echo "  Seeding database..."
npx prisma db seed

echo "✅ Backend pronto!"
echo ""

# Frontend setup
echo "📦 Setup Frontend (Next.js)..."
cd /app/frontend-v2

if [ ! -d "node_modules" ]; then
  echo "  Installing dependencies..."
  npm install --quiet
fi

echo "✅ Frontend pronto!"
echo ""

# Menu interativo
echo "╔════════════════════════════════════════════════════╗"
echo "║        ESCOLHA O QUE QUER FAZER:                  ║"
echo "╠════════════════════════════════════════════════════╣"
echo "║                                                    ║"
echo "║  1) Iniciar Backend (Fastify na porta 8001)       ║"
echo "║  2) Iniciar Frontend (Next.js na porta 3000)      ║"
echo "║  3) Ambos (Backend + Frontend)                    ║"
echo "║  4) Shell interativo                              ║"
echo "║  5) Ver status dos serviços                       ║"
echo "║  6) Acessar PostgreSQL (psql)                     ║"
echo "║  0) Sair                                          ║"
echo "║                                                    ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""

read -p "Escolha uma opção (0-6): " choice

case $choice in
  1)
    echo ""
    echo "🚀 Iniciando Backend (Fastify)..."
    echo "   URL: http://localhost:8001"
    echo "   Health: http://localhost:8001/health"
    echo ""
    cd /app/backend-v2
    node dist/index.js
    ;;
  2)
    echo ""
    echo "🚀 Iniciando Frontend (Next.js)..."
    echo "   URL: http://localhost:3000"
    echo ""
    cd /app/frontend-v2
    npm run dev
    ;;
  3)
    echo ""
    echo "🚀 Iniciando Backend + Frontend..."
    echo ""
    cd /app/backend-v2
    node dist/index.js &
    BACKEND_PID=$!
    sleep 2
    cd /app/frontend-v2
    npm run dev &
    FRONTEND_PID=$!
    echo ""
    echo "✅ Ambos rodando!"
    echo "   Backend:  http://localhost:8001 (PID: $BACKEND_PID)"
    echo "   Frontend: http://localhost:3000 (PID: $FRONTEND_PID)"
    echo ""
    echo "Pressione Ctrl+C para parar..."
    wait
    ;;
  4)
    echo ""
    echo "📝 Abrindo Shell (bash)..."
    echo "   Digite 'exit' para sair"
    echo ""
    bash
    ;;
  5)
    echo ""
    echo "🏥 Status dos Serviços:"
    echo ""
    echo "PostgreSQL:"
    if nc -z postgres 5432 2>/dev/null; then
      echo "  ✅ Rodando na porta 5432"
    else
      echo "  ❌ Não está rodando"
    fi
    echo ""
    echo "Backend:"
    if [ -d "backend-v2/dist" ]; then
      echo "  ✅ Compilado (pronto para rodar)"
    else
      echo "  ⚠️  Não compilado"
    fi
    echo ""
    echo "Frontend:"
    if [ -f "frontend-v2/next.config.ts" ]; then
      echo "  ✅ Configurado (pronto para rodar)"
    else
      echo "  ⚠️  Não encontrado"
    fi
    echo ""
    read -p "Pressione Enter para continuar..."
    exec bash "$0"
    ;;
  6)
    echo ""
    echo "📊 Conectando ao PostgreSQL..."
    echo "   Usuário: escolaconnect"
    echo "   Senha: escolaconnect123"
    echo "   Database: escolaconnect"
    echo ""
    PGPASSWORD=escolaconnect123 psql -h postgres -U escolaconnect -d escolaconnect
    ;;
  0)
    echo ""
    echo "Saindo..."
    exit 0
    ;;
  *)
    echo ""
    echo "❌ Opção inválida!"
    sleep 1
    exec bash "$0"
    ;;
esac
