# 📋 IMPLEMENTATION PLAN - EscolaConnect 2.0
**Migração de React + FastAPI/Python → Next.js + Fastify + PostgreSQL**

---

## 🎯 VISÃO GERAL

Migração completa do EscolaConnect para uma arquitetura mais moderna e escalável:
- **Frontend:** React → **Next.js 16.1.6+** com **Tailwind CSS v4**
- **Backend:** FastAPI (Python) → **Fastify v5+** (TypeScript)
- **Banco de Dados:** MongoDB → **PostgreSQL (Bitnami)**
- **Infraestrutura:** Docker Compose com Nginx, SSL/Certbot, Backups

---

## 📦 STACK TECNOLÓGICO

### Frontend (Next.js)
- [x] **Next.js 16.1.6+** - Framework React com SSR/SSG
- [x] **React 19+** - Biblioteca UI
- [x] **Tailwind CSS v4** - Estilização utilitária
- [x] **Lucide React** - Ícones SVG modernos
- [x] **TipTap** - Editor de texto rico (WYSIWYG)
- [x] **Prisma Client** - ORM para TypeScript
- [x] **ESLint** - Code quality & style
- [x] **SheetJS (XLSX)** - Exportar/importar Excel
- [x] **JsBarcode/QRCode** - Geração de códigos
- [x] **PostCSS** - Processamento de CSS

### Backend (Fastify)
- [x] **Fastify v5+** - Framework HTTP ultra-rápido
- [x] **TypeScript ^5** - Type safety
- [x] **Prisma Client** - ORM com migrations
- [x] **Zod** - Schema validation (Request/Response)
- [x] **bcryptjs** - Hash de senhas
- [x] **Fastify Multipart** - Upload de arquivos
- [x] **Fastify CORS** - Cross-origin resource sharing
- [x] **PDFKit** - Geração de PDFs (Relatórios)
- [x] **Dotenv** - Variáveis de ambiente
- [x] **Vitest** - Testes unitários rápidos

### Banco de Dados
- [x] **PostgreSQL (Bitnami)** - SGBD robusto
- [x] **Prisma ORM** - Migrations + Schema
- [x] **Modelos Definidos:** 9 tabelas principais
- [x] **Atributos Mapeados:** 62+ campos

### Infraestrutura (Docker)
- [x] **docker-compose.yml** - Orquestração
- [x] **Dockerfile (Frontend)** - Build otimizado Next.js
- [x] **Dockerfile (Backend)** - Build otimizado Node.js
- [x] **PostgreSQL Bitnami Image** - BD confiável
- [x] **Nginx Reverse Proxy** - Load balancing/routing
- [x] **SSL/Certbot Local** - HTTPS local
- [x] **Backup Container** - Backup automático PostgreSQL

---

## 📊 BANCO DE DADOS - MODELOS PRISMA

### 9 Modelos Principais:

```
1. User (Usuários)
   - id, email, nome, tipo, senha_hash, turma, disciplinas, 
     turmas_lecionadas, foto_url, aprovado, criado_em

2. Turma (Classes/Turmas)
   - id, codigo, nome, ano, numero, criado_em

3. Disciplina (Disciplinas/Matérias)
   - id, nome, professor_id, criado_em

4. Nota (Grades/Notas)
   - id, aluno_id, disciplina_id, periodo, pontos, lancado_por, 
     criado_em, atualizado_em

5. Falta (Attendance/Faltas)
   - id, aluno_id, disciplina_id, data, quantidade, 
     registrado_por, criado_em

6. Cardapio (Menu/Cardápio)
   - id, data, itens[], indisponiveis[], atualizado_por, 
     criado_em, atualizado_em

7. Observacao (Observations/Observações)
   - id, aluno_id, conteudo, autor_id, autor_nome, autor_tipo, criado_em

8. Mensagem (Messages/Mensagens)
   - id, titulo, conteudo, remetente_id, remetente_nome, 
     destinatario_tipo, turma, criado_em

9. Configuracao (System Config/Configuração)
   - id, modelo_ano, total_pontos, pontos_aprovacao, ano_letivo
```

**Total de Atributos:** 62+

---

## 🏗️ ARQUITETURA

### Frontend (Next.js)
```
frontend/
├── app/
│   ├── page.tsx              # Home
│   ├── auth/
│   │   ├── login/page.tsx
│   │   ├── register/page.tsx
│   │   └── layout.tsx
│   ├── admin/
│   │   ├── dashboard/page.tsx
│   │   ├── usuarios/page.tsx
│   │   ├── configuracoes/page.tsx
│   │   └── layout.tsx
│   ├── cantina/
│   │   ├── dashboard/page.tsx
│   │   └── layout.tsx
│   ├── professor/
│   │   ├── dashboard/page.tsx
│   │   └── layout.tsx
│   ├── aluno/
│   │   ├── dashboard/page.tsx
│   │   └── layout.tsx
│   └── layout.tsx
├── components/
│   ├── ui/                   # Componentes Tailwind
│   ├── forms/                # Formulários com Zod
│   ├── tables/               # Tabelas com dados
│   ├── modals/               # Modais reutilizáveis
│   └── navbar/
├── lib/
│   ├── api.ts                # Fetch client
│   ├── auth.ts               # JWT & sessions
│   ├── prisma.ts             # Prisma client
│   └── validators.ts         # Zod schemas
├── styles/
│   ├── globals.css           # Tailwind imports
│   └── variables.css         # CSS variables
├── prisma/
│   └── schema.prisma         # ORM schema
├── next.config.js
├── tailwind.config.ts
├── tsconfig.json
├── package.json
└── Dockerfile
```

### Backend (Fastify)
```
backend/
├── src/
│   ├── index.ts              # Entry point
│   ├── server.ts             # Fastify setup
│   ├── types/
│   │   └── index.ts          # TypeScript interfaces
│   ├── routes/
│   │   ├── auth.ts           # Auth endpoints
│   │   ├── users.ts          # User CRUD
│   │   ├── admin.ts          # Admin endpoints
│   │   ├── cardapio.ts       # Menu endpoints
│   │   ├── notas.ts          # Grades endpoints
│   │   ├── faltas.ts         # Attendance endpoints
│   │   ├── turmas.ts         # Classes endpoints
│   │   └── mensagens.ts      # Messages endpoints
│   ├── controllers/
│   │   ├── auth.ts
│   │   ├── users.ts
│   │   ├── admin.ts
│   │   └── ...
│   ├── services/
│   │   ├── auth.ts           # JWT, crypto
│   │   ├── users.ts          # User logic
│   │   ├── admin.ts          # Admin logic
│   │   └── ...
│   ├── middlewares/
│   │   ├── auth.ts           # JWT verification
│   │   ├── validation.ts     # Zod validation
│   │   └── cors.ts
│   ├── utils/
│   │   ├── errors.ts         # Error handling
│   │   ├── validators.ts     # Zod schemas
│   │   └── helpers.ts
│   ├── prisma.ts             # Prisma client
│   └── constants.ts
├── prisma/
│   ├── schema.prisma         # Database schema
│   ├── migrations/           # Database migrations
│   └── seed.ts               # Seed data
├── tests/
│   ├── unit/
│   ├── integration/
│   └── vitest.config.ts
├── .env.example
├── .eslintrc.json
├── package.json
├── tsconfig.json
├── Dockerfile
└── docker-compose.yml
```

---

## 🚀 FASES DE MIGRAÇÃO

### Fase 1: Setup Base (Dia 1)
- [x] Criar estrutura Next.js
- [x] Configurar Tailwind CSS v4
- [x] Setup Fastify + TypeScript
- [x] Configurar Prisma + PostgreSQL
- [x] Docker Compose com todos os serviços

### Fase 2: Migração Backend (Dias 2-3)
- [x] Refatorar rotas FastAPI → Fastify
- [x] Migrar models Python → Prisma schema
- [x] Implementar autenticação JWT no Fastify
- [x] Setup Zod para validação
- [x] Testes com Vitest

### Fase 3: Migração Frontend (Dias 4-5)
- [x] Converter React → Next.js pages
- [x] Tailwind CSS para styling
- [x] Lucide React para ícones
- [x] Integrar TipTap (se aplicável)
- [x] Configurar Prisma Client no front

### Fase 4: Features Adicionais (Dias 6-7)
- [x] PDF generation (PDFKit)
- [x] Excel export/import (SheetJS)
- [x] QR Code/Barcode (JsBarcode)
- [x] Upload de arquivos (Fastify Multipart)

### Fase 5: DevOps & Deploy (Dia 8)
- [x] Nginx reverse proxy
- [x] SSL/Certbot local
- [x] Backup automático
- [x] CI/CD (GitHub Actions)

---

## 📝 CHECKLIST DE IMPLEMENTAÇÃO

### Setup Inicial
- [ ] Clonar repositório
- [ ] Criar branch `migration/v2.0`
- [ ] Instalar dependências Node (frontend + backend)
- [ ] Configurar Prisma
- [ ] Criar arquivo `.env` com variáveis

### Backend (Fastify)
- [ ] Criar estrutura de pastas `/src`
- [ ] Configurar Fastify server
- [ ] Implementar CORS, Multipart
- [ ] Setup Zod validators
- [ ] Rotas de autenticação
- [ ] Rotas CRUD de usuários
- [ ] Rotas de admin
- [ ] Rotas de cardápio
- [ ] Rotas de notas/faltas
- [ ] Testes com Vitest
- [ ] Documentação com Swagger (opcional)

### Frontend (Next.js)
- [ ] Criar estrutura `/app` (App Router)
- [ ] Configurar Tailwind CSS v4
- [ ] Componentes base (Button, Input, Modal, etc)
- [ ] Layout com Navbar
- [ ] Página de Login
- [ ] Página de Registro
- [ ] Admin Dashboard com tabs
- [ ] Cantina Dashboard
- [ ] Professor Dashboard
- [ ] Student Dashboard
- [ ] Integração API com fetch client
- [ ] Dark/Light mode com Tailwind
- [ ] Form validation com Zod
- [ ] Componentes TipTap (opcional)

### Docker & Infraestrutura
- [ ] Dockerfile otimizado Next.js
- [ ] Dockerfile otimizado Node.js/Fastify
- [ ] docker-compose.yml com PostgreSQL, Nginx, Certbot
- [ ] Backup container setup
- [ ] Testar build local
- [ ] Testar com `docker compose up`

### QA & Testes
- [ ] Testes unitários backend (Vitest)
- [ ] Testes de integração
- [ ] Testes E2E (Cypress/Playwright - opcional)
- [ ] Testes de performance
- [ ] Verificar segurança (OWASP)

### Deploy
- [ ] Configurar GitHub Actions para CI/CD
- [ ] Deploy em staging
- [ ] Testes em produção
- [ ] Monitoramento

---

## 🔄 COMPARAÇÃO: ANTES vs DEPOIS

| Aspecto | Antes | Depois |
|---------|-------|--------|
| **Frontend** | React (Vite) | Next.js 16.1.6+ |
| **Backend** | FastAPI (Python) | Fastify v5+ (TypeScript) |
| **BD** | MongoDB | PostgreSQL (Bitnami) |
| **Validação** | Pydantic | Zod |
| **Styling** | Inline styles | Tailwind CSS v4 |
| **Ícones** | Emojis | Lucide React |
| **Type Safety** | Partial | Full TypeScript |
| **Testing** | pytest | Vitest |
| **ORM** | MongoDB driver | Prisma |
| **SSL** | Manual | Certbot automático |

---

## ⚙️ VARIÁVEIS DE AMBIENTE

### Frontend (.env.local)
```
NEXT_PUBLIC_API_URL=http://localhost:8001
NEXT_PUBLIC_APP_NAME=EscolaConnect
NODE_ENV=development
```

### Backend (.env)
```
# Database
DATABASE_URL=postgresql://postgres:postgres@db:5432/escolaconnect_db

# Auth
JWT_SECRET=sua-chave-secreta-aqui
JWT_EXPIRATION=7d

# App
NODE_ENV=development
PORT=8001

# CORS
CORS_ORIGINS=http://localhost:3000,http://localhost

# Prisma
PRISMA_DATABASE_URL=postgresql://postgres:postgres@db:5432/escolaconnect_db
```

---

## 🐳 DOCKER COMPOSE

Services que rodarão:
1. **PostgreSQL (Bitnami)** - Porta 5432
2. **Backend (Fastify)** - Porta 8001
3. **Frontend (Next.js)** - Porta 3000 → Nginx porta 80/443
4. **Nginx (Reverse Proxy)** - Portas 80/443
5. **Backup Service** - Backup automático PostgreSQL
6. **Certbot** - SSL/TLS local

---

## 📚 RECURSOS & DOCUMENTAÇÃO

- [Next.js 16 Docs](https://nextjs.org)
- [Fastify Docs](https://www.fastify.io)
- [Prisma Docs](https://www.prisma.io)
- [Tailwind CSS v4](https://tailwindcss.com)
- [Zod Validation](https://zod.dev)
- [Lucide Icons](https://lucide.dev)
- [TipTap Editor](https://tiptap.dev)

---

## ⚠️ NOTAS IMPORTANTES

1. **Migração de Dados:** PostgreSQL vs MongoDB
   - Usar script de migração para transferir dados
   - Validar integridade antes de excluir MongoDB

2. **Compatibilidade de API:**
   - Endpoints Fastify devem manter mesma interface
   - Testar clientes antigos para compatibilidade

3. **Performance:**
   - Next.js SSR pode ser mais rápido
   - Fastify é 2-3x mais rápido que FastAPI
   - PostgreSQL melhor para dados estruturados

4. **Segurança:**
   - Implementar rate limiting
   - HTTPS obrigatório em produção
   - Validar inputs com Zod

5. **Rollback Plan:**
   - Manter branch antigo com FastAPI + React
   - Se algo der errado: `git checkout main` + `docker compose up` com config antiga

---

## 🎯 ESTIMATIVA DE TEMPO

- **Setup Base:** 4-6 horas
- **Backend Fastify:** 8-10 horas
- **Frontend Next.js:** 8-10 horas
- **Features Adicionais:** 6-8 horas
- **Testes & QA:** 6-8 horas
- **Docker & Deploy:** 4-6 horas

**Total:** 36-48 horas (4-6 dias de trabalho)

---

## ✅ DECISÃO FINAL

**Prosseguir com migração?**
- [ ] SIM - Aplicar todas as mudanças
- [ ] NÃO - Manter estrutura atual (FastAPI + React + MongoDB)
- [ ] PARCIAL - Aplicar só algumas mudanças

---

*Documento criado: 2026-04-08*
*Última atualização: 2026-04-08*
