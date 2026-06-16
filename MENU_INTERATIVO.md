# 🎮 MENU INTERATIVO - ESCOLHA O QUE LIGAR

## 🎯 O MENU QUE VOCÊ QUER

Quando o container terminar de buildar, você vai ver:

```
╔════════════════════════════════════════════════════╗
║   EscolaConnect V2.0 - Pronto para usar!          ║
╚════════════════════════════════════════════════════╝

✅ PostgreSQL conectado!

🔧 Migrando database...
✅ Database pronto!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ESCOLHA O QUE FAZER:

  1) Iniciar Backend (porta 8001)
  2) Iniciar Frontend (porta 3000)
  3) Ambos (Backend + Frontend)
  4) Shell bash

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Digite uma opção (1-4): _
```

---

## 🎮 O QUE CADA OPÇÃO FAZ

### **Opção 1️⃣ : Iniciar Backend SÓ**

```
Digite: 1
Pressione Enter

O que acontece:
  - Backend (Fastify) inicia na porta 8001
  - Frontend NÃO inicia
  - Banco de dados JÁ ESTÁ RODANDO (container postgres)
  
Para testar:
  - Postman: http://localhost:8001/api/auth/login
  - Health check: http://localhost:8001/health
```

---

### **Opção 2️⃣ : Iniciar Frontend SÓ**

```
Digite: 2
Pressione Enter

O que acontece:
  - Frontend (Next.js) inicia na porta 3000
  - Backend NÃO inicia (vai dar erro de conexão)
  - Banco de dados JÁ ESTÁ RODANDO (container postgres)

Para funcionar:
  - Precisa que backend esteja rodando em outro container
  - OU em outro terminal
```

---

### **Opção 3️⃣ : Ambos (RECOMENDADO) ⭐**

```
Digite: 3
Pressione Enter

O que acontece:
  ✅ Backend (Fastify) inicia na porta 8001
  ✅ Frontend (Next.js) inicia na porta 3000
  ✅ Banco de dados JÁ ESTÁ RODANDO (container postgres)

Tudo funciona junto!
  
Abre navegador:
  http://localhost:3000
  
Login:
  admin@escolaconnect.com / admin123
  
E PRONTO! Sistema completo funcionando!
```

---

### **Opção 4️⃣ : Shell Bash**

```
Digite: 4
Pressione Enter

O que acontece:
  - Abre um terminal bash
  - Você pode rodar comandos manualmente
  - Exemplo: npm run dev, npm run build, etc

Você fica em:
  /app # _

Comandos úteis:
  /app # cd backend-v2
  /app # npm run dev
  
  /app # cd frontend-v2
  /app # npm run dev
  
  /app # exit (sai e volta ao menu)
```

---

## 📊 VISÃO GERAL

```
┌─────────────────────────────────────────┐
│         CONTAINER ESCOLACONNECT         │
├─────────────────────────────────────────┤
│                                         │
│  SERVIÇOS RODANDO:                      │
│  ✅ PostgreSQL (porta 5432)             │
│  ✅ Adminer (porta 8080)                │
│                                         │
│  O QUE VOCÊ ESCOLHE:                    │
│  1) Backend só (porta 8001)             │
│  2) Frontend só (porta 3000)            │
│  3) Backend + Frontend (3000 + 8001)   │
│  4) Shell bash                          │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🎬 FLUXO COMPLETO

### **Quando você roda:**
```bash
docker compose -f docker-compose-simple.yml up --build
```

### **O que acontece:**
```
1. 🔨 Docker constrói a imagem (~15 min)
   └─ npm install backend
   └─ npm run build backend
   └─ npm install frontend

2. 🟢 Containers iniciam
   └─ PostgreSQL pronto
   └─ Adminer pronto
   └─ App container pronto

3. 🎮 Menu interativo aparece
   └─ Você escolhe o que ligar

4. ▶️  Serviço inicia (o que você escolheu)

5. 🌐 Você acessa no navegador

6. 🎉 Sistema funcionando!
```

---

## 💡 DICA: OPÇÃO 3 É A MELHOR!

```
Escolha a opção 3 (Ambos)

Porque:
✅ Backend + Frontend funcionam juntos
✅ Sistema completo operacional
✅ Você consegue fazer login
✅ Consegue explorar todos os dashboards
✅ Melhor para testes/demonstração
```

---

## 🎯 RESUMO

| Opção | O que faz | Quando usar |
|-------|----------|-----------|
| **1** | Backend só | Testar API |
| **2** | Frontend só | Desenvolver interface |
| **3** | Backend + Frontend | ⭐ MELHOR - Teste completo |
| **4** | Shell bash | Explorar/debugar |

---

## 🚀 ENTÃO, RESUMINDO:

1. **Run:**
   ```bash
   docker compose -f docker-compose-simple.yml up --build
   ```

2. **Aguarda ~15 min**

3. **Vê o menu**

4. **Digita 3** (ambos)

5. **Abre http://localhost:3000**

6. **Login: admin@escolaconnect.com / admin123**

7. **PRONTO!** 🎉

---

**Status:** 🔨 BUILD EM ANDAMENTO  
**Menu:** ⏳ APARECERÁ EM ~15 MINUTOS
