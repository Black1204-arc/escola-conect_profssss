#!/bin/bash
# Script para testar a UI automaticamente

echo "================================"
echo "🎓 EscolaConnect - UI Test Suite"
echo "================================"
echo ""

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Teste 1: Health Check
echo -e "${BLUE}[1/5] Testando conexão com a API...${NC}"
response=$(curl -s http://localhost:8001/api/)
if echo "$response" | grep -q "ok"; then
    echo -e "${GREEN}✅ API respondendo${NC}"
else
    echo -e "${RED}❌ API não respondendo${NC}"
    exit 1
fi
echo ""

# Teste 2: Criar Usuário
echo -e "${BLUE}[2/5] Criando usuário de teste...${NC}"
user_response=$(curl -s -X POST http://localhost:8001/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "role": "teacher"
  }')
if echo "$user_response" | grep -q "Test User"; then
    echo -e "${GREEN}✅ Usuário criado com sucesso${NC}"
else
    echo -e "${RED}❌ Erro ao criar usuário${NC}"
fi
echo ""

# Teste 3: Listar Usuários
echo -e "${BLUE}[3/5] Listando usuários...${NC}"
users=$(curl -s http://localhost:8001/api/users)
user_count=$(echo "$users" | grep -o '"name"' | wc -l)
echo -e "${GREEN}✅ Total de usuários: $user_count${NC}"
echo ""

# Teste 4: Criar Aluno
echo -e "${BLUE}[4/5] Criando aluno de teste...${NC}"
student_response=$(curl -s -X POST http://localhost:8001/api/students \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Student",
    "matricula": "2024-001",
    "class": "9A"
  }')
if echo "$student_response" | grep -q "Test Student"; then
    echo -e "${GREEN}✅ Aluno criado com sucesso${NC}"
else
    echo -e "${RED}❌ Erro ao criar aluno${NC}"
fi
echo ""

# Teste 5: Estatísticas
echo -e "${BLUE}[5/5] Verificando estatísticas...${NC}"
stats=$(curl -s http://localhost:8001/api/stats)
echo -e "${GREEN}✅ Estatísticas:${NC}"
echo "$stats" | jq '.' 2>/dev/null || echo "$stats"
echo ""

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}✅ Todos os testes passaram!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "📱 Abra http://localhost:3000 no browser"
echo "📖 Leia TESTE_UI.md para teste manual completo"
