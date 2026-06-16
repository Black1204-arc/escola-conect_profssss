# 🏗️ EscolaConnect V2.0 - Arquitetura

## Diagrama de Componentes

```
┌─────────────────────────────────────────────────────────────────┐
│                        WEB BROWSER                               │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              FRONTEND - Next.js 16.2.2                    │  │
│  │                                                            │  │
│  │  ┌─────────────────────────────────────────────────┐    │  │
│  │  │  Pages (Login, Admin, Professor, Cantine, Student)  │  │  │
│  │  └─────────────────────────────────────────────────┘    │  │
│  │                         ↓                                 │  │
│  │  ┌─────────────────────────────────────────────────┐    │  │
│  │  │  Components (Header, ProtectedRoute, Layouts)   │    │  │
│  │  └─────────────────────────────────────────────────┘    │  │
│  │                         ↓                                 │  │
│  │  ┌─────────────────────────────────────────────────┐    │  │
│  │  │  Auth Context + useAuth Hook                    │    │  │
│  │  │  (JWT Token Management)                         │    │  │
│  │  └─────────────────────────────────────────────────┘    │  │
│  │                                                            │  │
│  └──────────────────────────────────────────────────────────┘  │
│                     http://localhost:3000                       │
└────────────────────────────────┬─────────────────────────────────┘
                                 │ HTTP + JWT Token
                                 ↓
┌─────────────────────────────────────────────────────────────────┐
│                     SERVER LAYER (Docker)                        │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │          BACKEND API - Fastify v4.25                     │  │
│  │                                                            │  │
│  │  ┌──────────────────────────────────────────────────┐   │  │
│  │  │  Routes                                          │   │  │
│  │  │  ├─ POST   /auth/login                           │   │  │
│  │  │  ├─ GET    /auth/me                              │   │  │
│  │  │  ├─ POST   /users                                │   │  │
│  │  │  ├─ GET    /users                                │   │  │
│  │  │  └─ GET    /users/:id                            │   │  │
│  │  └──────────────────────────────────────────────────┘   │  │
│  │                         ↓                                 │  │
│  │  ┌──────────────────────────────────────────────────┐   │  │
│  │  │  Controllers (Lógica de Requisição)              │   │  │
│  │  └──────────────────────────────────────────────────┘   │  │
│  │                         ↓                                 │  │
│  │  ┌──────────────────────────────────────────────────┐   │  │
│  │  │  Services (Lógica de Negócio)                    │   │  │
│  │  │  ├─ AuthService                                  │   │  │
│  │  │  └─ UserService                                  │   │  │
│  │  └──────────────────────────────────────────────────┘   │  │
│  │                         ↓                                 │  │
│  │  ┌──────────────────────────────────────────────────┐   │  │
│  │  │  Middlewares                                     │   │  │
│  │  │  ├─ JWT Authentication                           │   │  │
│  │  │  ├─ Role-based Authorization                     │   │  │
│  │  │  ├─ CORS                                         │   │  │
│  │  │  └─ Helmet (Security)                            │   │  │
│  │  └──────────────────────────────────────────────────┘   │  │
│  │                                                            │  │
│  └──────────────────────────────────────────────────────────┘  │
│                     http://localhost:8001                       │
│                                                                   │
│                            ↓ Prisma ORM                         │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │           DATABASE - PostgreSQL (Bitnami)                │  │
│  │                                                            │  │
│  │  ┌──────────────────────────────────────────────────┐   │  │
│  │  │  Tables                                          │   │  │
│  │  │  ├─ users          (4 test users)                │   │  │
│  │  │  ├─ professors     (1 test professor)            │   │  │
│  │  │  ├─ alunos         (1 test student)              │   │  │
│  │  │  ├─ turmas         (2 test classes)              │   │  │
│  │  │  ├─ notas          (empty, ready)                │   │  │
│  │  │  ├─ faltas         (empty, ready)                │   │  │
│  │  │  └─ configuracoes  (2 configs)                   │   │  │
│  │  └──────────────────────────────────────────────────┘   │  │
│  │                                                            │  │
│  │  Access: escolaconnect / escolaconnect123                 │  │
│  │  Port: 5432                                              │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │          ADMINER (Database Management)                   │  │
│  │                  http://localhost:8080                   │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Fluxo de Autenticação

```
┌────────────┐
│  Browser   │
│  (Cliente) │
└────────────┘
      │
      │ 1. POST /auth/login { email, senha }
      ↓
┌────────────────────────┐
│  Backend - Login Route │
└────────────────────────┘
      │
      │ 2. Hash senha com bcrypt
      │ 3. Comparar com banco
      ↓
┌────────────────────────┐
│  AuthService.login()   │
└────────────────────────┘
      │
      │ 4. Buscar User em PostgreSQL
      │ 5. Validar credenciais
      ↓
┌────────────────────────┐
│  Prisma ORM            │
└────────────────────────┘
      │
      │ 6. Consultar users table
      ↓
┌────────────────────────┐
│  PostgreSQL Database   │
└────────────────────────┘
      │
      │ 7. Retornar User encontrado
      ↓
┌────────────────────────┐
│  Comparar senha        │
│  (bcrypt.compare)      │
└────────────────────────┘
      │
      │ 8. Se válido, gerar JWT
      ↓
┌────────────────────────┐
│  Fastify JWT Sign      │
│  Expiração: 7 dias     │
└────────────────────────┘
      │
      │ 9. Retornar { user, token }
      ↓
┌────────────────────────┐
│  Browser recebe token  │
│  Salva em localStorage │
└────────────────────────┘
      │
      │ 10. Token enviado em headers
      │     para requisições futuras
      ↓
┌────────────────────────┐
│  JWT Middleware        │
│  (Verifica token)      │
└────────────────────────┘
```

---

## Estrutura de Pasta do Projeto

```
EscolaConect/
│
├── 📦 frontend-v2/                    (Next.js V2.0)
│   ├── app/
│   │   ├── layout.tsx                 (Root layout + AuthProvider)
│   │   ├── page.tsx                   (Redirect logic)
│   │   ├── auth/
│   │   │   ├── layout.tsx
│   │   │   └── login/page.tsx
│   │   ├── admin/page.tsx             (6 tabs dashboard)
│   │   ├── professor/page.tsx
│   │   ├── cantina/page.tsx
│   │   └── aluno/page.tsx
│   ├── components/
│   │   ├── common/
│   │   │   ├── Header.tsx
│   │   │   ├── ProtectedRoute.tsx
│   │   │   └── ...
│   │   ├── admin/
│   │   ├── modals/
│   │   └── ui/
│   ├── lib/
│   │   ├── auth-context.tsx           (Auth state + hooks)
│   │   ├── api.ts                     (API helpers)
│   │   └── constants.ts
│   ├── types/index.ts                 (TypeScript types)
│   ├── package.json
│   ├── Dockerfile
│   └── tsconfig.json
│
├── 📦 backend-v2/                     (Fastify V2.0)
│   ├── src/
│   │   ├── index.ts                   (Server entry)
│   │   ├── routes/
│   │   │   └── auth.ts
│   │   ├── controllers/
│   │   │   └── auth.ts
│   │   ├── services/
│   │   │   └── auth.ts
│   │   ├── middlewares/
│   │   │   └── auth.ts
│   │   ├── schemas/
│   │   │   └── index.ts               (Zod validation)
│   │   ├── utils/
│   │   │   └── password.ts            (Bcrypt)
│   │   ├── lib/
│   │   │   └── prisma.ts
│   │   └── types/
│   │       └── index.ts
│   ├── prisma/
│   │   ├── schema.prisma              (Database schema)
│   │   ├── seed.ts                    (Test data)
│   │   └── migrations/
│   ├── dist/                          (Compiled TypeScript)
│   ├── package.json
│   ├── tsconfig.json
│   ├── Dockerfile
│   └── entrypoint.sh
│
├── 📦 backend/ (V1.0 FastAPI)         ⚠️ Backup
│   ├── server.py
│   ├── requirements.txt
│   └── ...
│
├── 📦 frontend/ (V1.0 React)          ⚠️ Backup
│   ├── src/
│   ├── package.json
│   └── ...
│
├── 🐳 docker-compose.v2.yml           (Orquestração)
│   ├── postgres (PostgreSQL 16)
│   ├── backend-v2 (Fastify)
│   ├── frontend-v2 (Next.js)
│   └── adminer (DB Manager)
│
├── 📄 SETUP_V2.md                     (Setup detalhado)
├── 📄 STATUS_V2.0.md                  (Status & features)
├── 📄 RESUMO_V2.0.txt                 (Quick start)
├── 📄 STATUS_FINAL.txt                (V1.0 status)
├── 📄 PLANO_MIGRACAO_V2_COMPLETO.md   (Migration plan)
│
├── 🔐 backup_emergency.archive        (MongoDB dump)
├── 🌳 backup/v1.0-original            (Git branch)
└── 🌳 migration/v2.0                  (Git branch)
```

---

## Stack Tecnológico

```
┌─────────────────────────────────────────┐
│         FRONTEND (Next.js 16.2)         │
├─────────────────────────────────────────┤
│ • React 19                              │
│ • TypeScript (strict mode)              │
│ • Tailwind CSS v4                       │
│ • Lucide React (icons)                  │
│ • Next.js App Router                    │
│ • JWT (localStorage)                    │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│        BACKEND (Fastify v4.25)          │
├─────────────────────────────────────────┤
│ • Node.js runtime                       │
│ • TypeScript (strict mode)              │
│ • Fastify framework                     │
│ • Prisma ORM                            │
│ • Zod validation                        │
│ • Bcrypt (password hashing)             │
│ • JWT authentication                    │
│ • Helmet (security headers)             │
│ • CORS middleware                       │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│       DATABASE (PostgreSQL 16)          │
├─────────────────────────────────────────┤
│ • Bitnami PostgreSQL image              │
│ • 7 tables (users, profs, alunos, etc)  │
│ • Prisma migrations                     │
│ • Automated seeding                     │
│ • Persistent volumes                    │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│          INFRASTRUCTURE                 │
├─────────────────────────────────────────┤
│ • Docker (containerization)             │
│ • Docker Compose (orchestration)        │
│ • Multi-stage builds                    │
│ • Health checks                         │
│ • Named volumes                         │
│ • Bridge network                        │
│ • Adminer (DB management)               │
└─────────────────────────────────────────┘
```

---

## Fluxo de Dados (Exemplo: Login)

```
┌──────────────────────────────────────────────────────────────┐
│ 1. Usuario digita email/senha no browser                     │
│    admin@escolaconnect.com / admin123                        │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ 2. Frontend (Next.js) faz POST /auth/login                   │
│    Headers: Content-Type: application/json                  │
│    Body: { email, senha }                                    │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ 3. Backend (Fastify) recebe request                          │
│    Route handler: auth.ts → login controller                │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ 4. Validação com Zod                                         │
│    LoginSchema.parse(body)                                   │
│    ✓ email é válido                                          │
│    ✓ senha tem 6+ chars                                      │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ 5. AuthService.login() executa lógica                        │
│    ✓ busca User por email em PostgreSQL                      │
│    ✓ compara senha com bcrypt                                │
│    ✓ senha correta ✓                                         │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ 6. Gerar JWT token                                           │
│    Payload: { sub: user.id, email, role }                    │
│    Expiração: 7 dias                                         │
│    Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...           │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ 7. Backend retorna resposta                                  │
│    Status: 200 OK                                            │
│    Body: {                                                   │
│      success: true,                                          │
│      data: {                                                 │
│        user: { id, email, nome, role },                      │
│        token: "eyJhbGciOi..."                                │
│      }                                                       │
│    }                                                         │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ 8. Frontend recebe token                                     │
│    ✓ salva em localStorage                                   │
│    ✓ atualiza Auth context                                   │
│    ✓ redireciona para /admin (baseado no role)               │
└──────────────────────────────────────────────────────────────┘
                          ↓
┌──────────────────────────────────────────────────────────────┐
│ 9. Usuario acessa Admin Dashboard                            │
│    ProtectedRoute verifica token                             │
│    JWT middleware valida token                               │
│    ✓ Token válido → acesso concedido                         │
└──────────────────────────────────────────────────────────────┘
```

---

## Segurança

```
┌──────────────────────────────────────────────────┐
│          CAMADAS DE SEGURANÇA                    │
├──────────────────────────────────────────────────┤
│                                                  │
│ 1. Frontend                                      │
│    └─ JWT token em localStorage (SameSite)      │
│    └─ Protected Routes (componente)             │
│                                                  │
│ 2. Transport                                     │
│    └─ HTTPS (em produção)                       │
│    └─ CORS configurado                          │
│                                                  │
│ 3. Backend                                       │
│    └─ Helmet (security headers)                 │
│    └─ Request validation (Zod)                  │
│    └─ JWT verification                          │
│    └─ Role-based authorization                  │
│                                                  │
│ 4. Password                                      │
│    └─ Bcrypt (10 rounds)                        │
│    └─ Salt automático                           │
│    └─ Hash irreversível                         │
│                                                  │
│ 5. Database                                      │
│    └─ Credenciais seguras                       │
│    └─ Prepared statements (Prisma)              │
│    └─ SQL injection protection                  │
│    └─ Type-safe queries                         │
│                                                  │
└──────────────────────────────────────────────────┘
```

---

**Data**: 2026-04-08  
**Versão**: 2.0.0  
**Status**: ✅ Completo
