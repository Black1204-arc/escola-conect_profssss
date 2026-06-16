# 🚀 ESCOLACONNECT V2.0 - QUICK START GUIDE

## System is LIVE and READY! ✅

---

## 📍 How to Access

Open your browser and go to:

### **Frontend (Main App)**
👉 **http://localhost:3000**

### **Database Manager (Adminer)**
👉 **http://localhost:8080**

### **API Health Check**
👉 **http://localhost:8001/health**

---

## 🔐 Login Credentials

Use these to test the system:

| Role | Email | Password |
|------|-------|----------|
| **Admin** | admin@escolaconnect.com | admin123 |
| **Professor** | professor@escola.com | prof123 |
| **Cantine** | cantina@escola.com | cantina123 |
| **Student** | aluno@escola.com | aluno123 |

---

## 🛑 Stop the System

When done, run:
```bash
docker compose down
```

---

## 📂 Restart the System

To start again after stopping:
```bash
cd C:\Users\Dev2\Documents\projetos\EscolaConect
docker compose up -d
```

---

## ❓ Something Not Working?

Check the logs:
```bash
docker compose logs app
```

For a full restart:
```bash
docker compose down -v
docker compose up --build -d
```

---

**Version:** 2.0.0  
**Status:** ✅ Operational  
**Backend:** Fastify + PostgreSQL  
**Frontend:** Next.js 16.2.2 + React  
**UI:** Tailwind CSS v4
