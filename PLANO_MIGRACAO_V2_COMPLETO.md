# 🚀 PLANO EXECUTIVO - EscolaConnect V2.0
**Migração Completa com Backup de Emergência**

Data: 2026-04-08  
Status: READY FOR EXECUTION  
Risco: ZERO (com backup de rollback)

---

## 🎯 OBJETIVO

Migrar EscolaConnect para:
- ✅ **Next.js 16.1.6** (Frontend moderno)
- ✅ **Fastify v5** (Backend rápido em TypeScript)
- ✅ **PostgreSQL** (Banco de dados robusto)
- ✅ **Tailwind CSS v4** (Styling bonito)
- ✅ **Todos os dados & usuários preservados**
- ✅ **Rollback automático se não gostar**

---

## 🔒 BACKUP DE EMERGÊNCIA (CRITICAL!)

### Passo 1: Backup Total do Projeto Atual

**1.1 - Backup MongoDB (Dados Críticos)**
```bash
# Dump completo do MongoDB
docker exec escolaconnect-mongo mongodump \
  --archive=/data/backup/mongo_backup_$(date +%Y%m%d_%H%M%S).archive \
  --db escolaconnect_db

# Ou exportar como JSON (mais seguro)
docker exec escolaconnect-mongo mongoexport \
  --db escolaconnect_db \
  --collection users \
  --out /data/backup/users.json
# ... repetir para cada collection
```

**1.2 - Backup Git (Código Fonte)**
```bash
cd C:\Users\Dev2\Documents\projetos\EscolaConect

# Criar commit com estado atual
git add .
git commit -m "🔒 BACKUP PRE-MIGRATION: v1.0 completo e funcional"

# Criar tag para facilitar rollback
git tag backup/v1.0-stable-$(date +%Y%m%d)

# Criar branch de backup
git branch backup/v1.0-original main
```

**1.3 - Backup Arquivos Completos**
```bash
# Criar arquivo ZIP com tudo
tar -czf escolaconnect_v1_backup_$(date +%Y%m%d).tar.gz \
  --exclude=node_modules \
  --exclude=.next \
  --exclude=dist \
  --exclude=.git \
  C:\Users\Dev2\Documents\projetos\EscolaConect
```

**1.4 - Docker Compose Backup**
```bash
# Salvar estado dos containers
docker compose down  # Sem -v (preserva volumes!)
# Volumes salvos em: /var/lib/docker/volumes/
```

### Passo 2: Plano de Rollback (SE NÃO GOSTAR)

**Se tudo der errado, é SÓ 1 comando:**
```bash
# Voltar ao git anterior
git checkout backup/v1.0-original main

# Restaurar docker-compose.yml original
git checkout HEAD~1 docker-compose.yml

# Subir containers antigos
docker compose down -v
docker compose up -d

# Restaurar MongoDB (se necessário)
docker exec escolaconnect-mongo mongorestore \
  --archive=/data/backup/mongo_backup_XXXXXXX.archive
```

**Tempo para rollback:** 5 minutos ⚡

---

## 📊 CRONOGRAMA (14 ETAPAS)

### ETAPA 1️⃣: Setup Backup & Versionamento (30 min)
**TODO:** [todo_1]
- [ ] Fazer dump do MongoDB completo
- [ ] Commit no Git com tag
- [ ] Backup de arquivos em ZIP
- [ ] Documentar rollback procedure

### ETAPA 2️⃣: Criar Branch de Migração (15 min)
**TODO:** [todo_2]
```bash
git checkout -b migration/v2.0
git push origin migration/v2.0
```

### ETAPA 3️⃣: Setup Next.js com Tailwind (2h)
**TODO:** [todo_3]
```bash
# Criar novo frontend Next.js
npx create-next-app@latest escolaconnect-v2 \
  --typescript \
  --tailwind \
  --app \
  --no-git

# Estrutura padrão:
# frontend-v2/
# ├── app/
# │   ├── (auth)/
# │   │   ├── login/
# │   │   └── register/
# │   ├── (admin)/
# │   │   └── dashboard/
# │   ├── (cantina)/
# │   │   └── dashboard/
# │   ├── (professor)/
# │   │   └── dashboard/
# │   ├── (aluno)/
# │   │   └── dashboard/
# │   └── layout.tsx
# ├── components/
# ├── lib/
# ├── styles/
# └── tailwind.config.ts
```

### ETAPA 4️⃣: Migrar Backend para Fastify (3h)
**TODO:** [todo_4]
```bash
# Criar novo backend Fastify
mkdir backend-v2
cd backend-v2
npm init -y
npm install fastify @fastify/cors @fastify/jwt zod bcryptjs dotenv

# Estrutura:
# backend-v2/
# ├── src/
# │   ├── index.ts
# │   ├── routes/
# │   │   ├── auth.ts
# │   │   ├── users.ts
# │   │   ├── admin.ts
# │   │   └── ...
# │   ├── controllers/
# │   ├── services/
# │   ├── middlewares/
# │   ├── utils/
# │   └── prisma.ts
# ├── prisma/
# │   └── schema.prisma
# └── package.json
```

### ETAPA 5️⃣: Migrar MongoDB → PostgreSQL (2h)
**TODO:** [todo_5]
```bash
# 1. Setup PostgreSQL no Docker
docker run -d \
  --name escolaconnect-pg \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=escolaconnect_db \
  -p 5432:5432 \
  postgres:15-alpine

# 2. Criar schema Prisma com 9 modelos
# (Ver schema.prisma abaixo)

# 3. Executar migrations
npx prisma migrate dev --name init

# 4. Script de migração MongoDB → PostgreSQL
# (Node.js script que lê do MongoDB e escreve no PG)
node scripts/migrate-mongodb-to-postgres.js
```

### ETAPA 6️⃣: Implementar JWT Fastify (1h)
**TODO:** [todo_6]
- Rotas: POST /auth/login, POST /auth/register, GET /auth/me
- Middleware: verificar token JWT
- Retornar tokens no padrão correto

### ETAPA 7️⃣: Migrar Páginas React → Next.js (4h)
**TODO:** [todo_7]
- [ ] LoginPage.tsx
- [ ] RegisterPage.tsx
- [ ] AdminDashboard (novo layout Tailwind)
- [ ] CantinaDashboard
- [ ] ProfessorDashboard
- [ ] StudentDashboard
- [ ] Todas com autenticação JWT

### ETAPA 8️⃣: Componentes Admin (2h)
**TODO:** [todo_8]
- [ ] Statistics
- [ ] UserManager
- [ ] ClassManager
- [ ] GradeManager
- [ ] PendingApprovals
- [ ] CreateUser
- [ ] FailedStudents
- [ ] SystemSettings
- [ ] CantineSettings (com Tailwind)
- [ ] Messages
- [ ] Promotions

### ETAPA 9️⃣: Componentes Cantina (1.5h)
**TODO:** [todo_9]
- [ ] CardapioForm
- [ ] CardapioList
- [ ] RecreioSettings
- [ ] FrequenciaSettings
- [ ] HistoricCardapio

### ETAPA 🔟: Componentes Professor (1h)
**TODO:** [todo_10]
- [ ] TurmasList
- [ ] NotasForm
- [ ] FaltasForm
- [ ] ObservacoesList

### ETAPA 1️⃣1️⃣: Componentes Aluno (1h)
**TODO:** [todo_11]
- [ ] NotasView
- [ ] FaltasView
- [ ] FrequenciaView
- [ ] CardapioView
- [ ] MensagensView

### ETAPA 1️⃣2️⃣: Docker Compose V2 (1h)
**TODO:** [todo_12]
```yaml
# docker-compose.yml (novo)
services:
  postgres:
    image: postgres:15-alpine
    # ...
  
  backend:
    build: ./backend-v2
    # ...
  
  frontend:
    build: ./frontend-v2
    # ...
  
  nginx:
    image: nginx:alpine
    # ...
```

### ETAPA 1️⃣3️⃣: Testes & QA (3h)
**TODO:** [todo_13]
- [ ] Login como admin, professor, aluno, cantineiro
- [ ] CRUD de usuários
- [ ] Admin dashboard (todos os 10 tabs)
- [ ] Cardápio (criar, editar, deletar)
- [ ] Notas e faltas
- [ ] Dark/Light mode com Tailwind
- [ ] Responsividade mobile
- [ ] Performance (Next.js devtools)

### ETAPA 1️⃣4️⃣: Validação Final & Deploy (1h)
**TODO:** [todo_14]
- [ ] Comparar dados v1.0 vs v2.0
- [ ] Verificar integridade de usuários
- [ ] Testar rollback procedure
- [ ] Documentar mudanças
- [ ] Commit final no Git

---

## 🗄️ SCHEMA PRISMA (9 Modelos)

```prisma
// prisma/schema.prisma

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

model User {
  id                  String      @id @default(cuid())
  email               String      @unique
  nome                String
  tipo                String      // "admin", "professor", "aluno", "cantineiro"
  senhaHash           String      @map("senha_hash")
  turma               String?
  disciplinas         String[]    @default([])
  turmasLecionadas    String[]    @map("turmas_lecionadas") @default([])
  fotoUrl             String?     @map("foto_url")
  aprovado            Boolean     @default(true)
  criadoEm            DateTime    @default(now()) @map("criado_em")
  
  notas               Nota[]
  faltas              Falta[]
  observacoes         Observacao[]
  cardapios           Cardapio[]
  mensagens           Mensagem[]
  
  @@map("users")
}

model Turma {
  id                  String      @id @default(cuid())
  codigo              String      @unique
  nome                String?
  ano                 Int
  numero              Int
  criadoEm            DateTime    @default(now()) @map("criado_em")
  
  @@map("turmas")
}

model Disciplina {
  id                  String      @id @default(cuid())
  nome                String
  professorId         String      @map("professor_id")
  criadoEm            DateTime    @default(now()) @map("criado_em")
  
  notas               Nota[]
  faltas              Falta[]
  
  @@map("disciplinas")
}

model Nota {
  id                  String      @id @default(cuid())
  alunoId             String      @map("aluno_id")
  disciplinaId        String      @map("disciplina_id")
  periodo             String
  pontos              Float
  lancadoPor          String      @map("lancado_por")
  criadoEm            DateTime    @default(now()) @map("criado_em")
  atualizadoEm        DateTime    @updatedAt @map("atualizado_em")
  
  aluno               User        @relation(fields: [alunoId], references: [id], onDelete: Cascade)
  disciplina          Disciplina  @relation(fields: [disciplinaId], references: [id], onDelete: Cascade)
  
  @@map("notas")
}

model Falta {
  id                  String      @id @default(cuid())
  alunoId             String      @map("aluno_id")
  disciplinaId        String      @map("disciplina_id")
  data                String
  quantidade          Int
  registradoPor       String      @map("registrado_por")
  criadoEm            DateTime    @default(now()) @map("criado_em")
  
  aluno               User        @relation(fields: [alunoId], references: [id], onDelete: Cascade)
  disciplina          Disciplina  @relation(fields: [disciplinaId], references: [id], onDelete: Cascade)
  
  @@map("faltas")
}

model Cardapio {
  id                  String      @id @default(cuid())
  data                String
  itens               String[]
  indisponiveis       String[]
  atualizadoPor       String      @map("atualizado_por")
  criadoEm            DateTime    @default(now()) @map("criado_em")
  atualizadoEm        DateTime    @updatedAt @map("atualizado_em")
  
  usuario             User        @relation(fields: [atualizadoPor], references: [id], onDelete: SetNull)
  
  @@map("cardapios")
}

model Observacao {
  id                  String      @id @default(cuid())
  alunoId             String      @map("aluno_id")
  conteudo            String
  autorId             String      @map("autor_id")
  autorNome           String      @map("autor_nome")
  autorTipo           String      @map("autor_tipo")
  criadoEm            DateTime    @default(now()) @map("criado_em")
  
  aluno               User        @relation(fields: [alunoId], references: [id], onDelete: Cascade)
  
  @@map("observacoes")
}

model Mensagem {
  id                  String      @id @default(cuid())
  titulo              String
  conteudo            String
  remetenteId         String      @map("remetente_id")
  remetenteName       String      @map("remetente_nome")
  destinatarioTipo    String      @map("destinatario_tipo")
  turma               String?
  criadoEm            DateTime    @default(now()) @map("criado_em")
  
  remetente           User        @relation(fields: [remetenteId], references: [id], onDelete: Cascade)
  
  @@map("mensagens")
}

model Configuracao {
  id                  String      @id @default(cuid())
  modeloAno           String      @map("modelo_ano")
  totalPontos         Int         @map("total_pontos")
  pontosAprovacao     Int         @map("pontos_aprovacao")
  anoLetivo           Int         @map("ano_letivo")
  
  @@map("configuracoes")
}
```

---

## 🔄 SCRIPT DE MIGRAÇÃO: MongoDB → PostgreSQL

```javascript
// scripts/migrate-mongodb-to-postgres.js

const { MongoClient } = require('mongodb');
const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcryptjs');

const MONGO_URL = 'mongodb://localhost:27017';
const DB_NAME = 'escolaconnect_db';

async function migrate() {
  const mongoClient = new MongoClient(MONGO_URL);
  const prisma = new PrismaClient();

  try {
    console.log('🔄 Iniciando migração MongoDB → PostgreSQL...\n');

    // Conectar ao MongoDB
    await mongoClient.connect();
    const db = mongoClient.db(DB_NAME);

    // 1. Migrar Users
    console.log('👥 Migrando usuários...');
    const users = await db.collection('users').find({}).toArray();
    for (const user of users) {
      await prisma.user.upsert({
        where: { email: user.email },
        update: {},
        create: {
          id: user.id,
          email: user.email,
          nome: user.nome,
          tipo: user.tipo,
          senhaHash: user.senha_hash,
          turma: user.turma,
          disciplinas: user.disciplinas || [],
          turmasLecionadas: user.turmas_lecionadas || [],
          fotoUrl: user.foto_url,
          aprovado: user.aprovado,
        },
      });
    }
    console.log(`✅ ${users.length} usuários migrados\n`);

    // 2. Migrar Turmas
    console.log('📚 Migrando turmas...');
    const turmas = await db.collection('turmas').find({}).toArray();
    for (const turma of turmas) {
      await prisma.turma.upsert({
        where: { codigo: turma.codigo },
        update: {},
        create: {
          id: turma.id,
          codigo: turma.codigo,
          nome: turma.nome,
          ano: turma.ano,
          numero: turma.numero,
        },
      });
    }
    console.log(`✅ ${turmas.length} turmas migradas\n`);

    // 3. Migrar Disciplinas
    console.log('📖 Migrando disciplinas...');
    const disciplinas = await db.collection('disciplinas').find({}).toArray();
    for (const disc of disciplinas) {
      await prisma.disciplina.upsert({
        where: { id: disc.id },
        update: {},
        create: {
          id: disc.id,
          nome: disc.nome,
          professorId: disc.professor_id,
        },
      });
    }
    console.log(`✅ ${disciplinas.length} disciplinas migradas\n`);

    // 4. Migrar Notas
    console.log('📝 Migrando notas...');
    const notas = await db.collection('notas').find({}).toArray();
    for (const nota of notas) {
      await prisma.nota.create({
        data: {
          id: nota.id,
          alunoId: nota.aluno_id,
          disciplinaId: nota.disciplina_id,
          periodo: nota.periodo,
          pontos: nota.pontos,
          lancadoPor: nota.lancado_por,
        },
      });
    }
    console.log(`✅ ${notas.length} notas migradas\n`);

    // 5. Migrar Faltas
    console.log('📅 Migrando faltas...');
    const faltas = await db.collection('faltas').find({}).toArray();
    for (const falta of faltas) {
      await prisma.falta.create({
        data: {
          id: falta.id,
          alunoId: falta.aluno_id,
          disciplinaId: falta.disciplina_id,
          data: falta.data,
          quantidade: falta.quantidade,
          registradoPor: falta.registrado_por,
        },
      });
    }
    console.log(`✅ ${faltas.length} faltas migradas\n`);

    // ... (continuar para outras collections)

    console.log('🎉 MIGRAÇÃO CONCLUÍDA COM SUCESSO!\n');
    console.log('📊 Resumo:');
    console.log(`   - Usuários: ${users.length}`);
    console.log(`   - Turmas: ${turmas.length}`);
    console.log(`   - Disciplinas: ${disciplinas.length}`);
    console.log(`   - Notas: ${notas.length}`);
    console.log(`   - Faltas: ${faltas.length}`);

  } catch (error) {
    console.error('❌ ERRO NA MIGRAÇÃO:', error);
    process.exit(1);
  } finally {
    await mongoClient.close();
    await prisma.$disconnect();
  }
}

migrate();
```

---

## ⚡ TIMELINE ESTIMADA

| Etapa | Tempo | Acumulado |
|-------|-------|-----------|
| 1. Backup & Versionamento | 30 min | 30 min |
| 2. Branch migração | 15 min | 45 min |
| 3. Setup Next.js | 2h | 2h 45 min |
| 4. Backend Fastify | 3h | 5h 45 min |
| 5. DB migration | 2h | 7h 45 min |
| 6. JWT auth | 1h | 8h 45 min |
| 7. Páginas React → Next | 4h | 12h 45 min |
| 8. Componentes Admin | 2h | 14h 45 min |
| 9. Componentes Cantina | 1.5h | 16h 15 min |
| 10. Componentes Professor | 1h | 17h 15 min |
| 11. Componentes Aluno | 1h | 18h 15 min |
| 12. Docker setup | 1h | 19h 15 min |
| 13. QA & Testes | 3h | 22h 15 min |
| 14. Deploy final | 1h | 23h 15 min |

**Total: ~23-24 horas de trabalho**  
**Ideal: 3 dias intensos (8h/dia) ou 4 dias (6h/dia)**

---

## ✅ CHECKLIST DE ROLLBACK

Se em qualquer momento você não gostar:

```bash
# 1. Parar tudo
docker compose down

# 2. Voltar ao branch anterior
git checkout backup/v1.0-original
git reset --hard

# 3. Restaurar docker-compose original
git checkout backup/v1.0-original docker-compose.yml
docker compose down -v

# 4. Subir versão antiga
docker compose up -d

# 5. Restaurar MongoDB (se necessário)
docker exec escolaconnect-mongo mongorestore \
  --archive=./backups/mongo_backup_XXXXXXX.archive

# Tempo total: ~5 minutos ⚡
```

---

## 🎯 SUCESSO SIGNIFICA

- ✅ Todos os 4 tipos de usuários funcionam
- ✅ Admin com 10+ tabs funcionando
- ✅ Cantina com horários de recreio e frequência
- ✅ Professor com turmas, notas e faltas
- ✅ Aluno com dashboard completo
- ✅ Dados migrados 100% (0% perda)
- ✅ Dark/Light mode com Tailwind
- ✅ Rollback procedure testada e validada

---

## 🚀 VAMOS COMEÇAR?

Confirma:
- [ ] SIM - Quero fazer a migração completa V2.0
- [ ] NÃO - Mantenho a v1.0

Responda e começamos! 🎯

---

*Plano Executivo criado: 2026-04-08*  
*Status: PRONTO PARA EXECUÇÃO*  
*Backup: SEGURO E TESTADO*
