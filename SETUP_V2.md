# EscolaConnect V2.0 - Setup Guide

## 🚀 Quick Start

### Option 1: Docker Compose (Recommended)

```bash
# Start all services
docker compose -f docker-compose.v2.yml up -d --build

# View logs
docker compose -f docker-compose.v2.yml logs -f

# Stop all services
docker compose -f docker-compose.v2.yml down
```

### Option 2: Manual Setup

#### Backend Setup

```bash
cd backend-v2

# Install dependencies
npm install

# Setup environment
cp .env.example .env.local

# Setup database
npm run db:init

# Start development server
npm run dev
```

#### Frontend Setup

```bash
cd frontend-v2

# Install dependencies
npm install

# Copy env file
cp .env.example .env.local

# Start development server
npm run dev
```

## 📍 Access Points

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8001
- **Adminer (DB Manager)**: http://localhost:8080
- **API Health Check**: http://localhost:8001/health

## 🔐 Test Credentials

```
Admin:      admin@escolaconnect.com / admin123
Professor:  professor@escola.com / prof123
Cantineiro: cantina@escola.com / cantina123
Student:    aluno@escola.com / aluno123
```

## 📦 Tech Stack

### Backend (V2.0)
- **Framework**: Fastify v4.25
- **Database**: PostgreSQL (Bitnami)
- **ORM**: Prisma
- **Language**: TypeScript
- **Validation**: Zod
- **Auth**: JWT + Bcrypt

### Frontend (V2.0)
- **Framework**: Next.js 16.2.2
- **UI**: Tailwind CSS v4
- **Icons**: Lucide React
- **Language**: TypeScript

## 🗄️ Database Schema

### Tables

1. **users**: Authentication and basic user info
   - id, email, nome, senha, role, ativo, timestamps

2. **professors**: Professor-specific data
   - id, user_id, timestamps

3. **alunos**: Student-specific data
   - id, user_id, turma_id, timestamps

4. **turmas**: Classes
   - id, nome, ano, professor_id, timestamps

5. **notas**: Grades
   - id, aluno_id, professor_id, turma_id, disciplina, bimestre, valor, timestamps

6. **faltas**: Absences
   - id, aluno_id, professor_id, turma_id, data, justificada, timestamps

7. **configuracoes**: System configurations
   - id, chave (unique), valor, timestamps

## 🔄 Database Management

### View Database with Adminer
1. Open http://localhost:8080
2. Server: postgres
3. Username: escolaconnect
4. Password: escolaconnect123
5. Database: escolaconnect

### Run Migrations
```bash
npm run prisma:migrate
```

### Seed Database with Test Data
```bash
npm run prisma:seed
```

### Run Both
```bash
npm run db:init
```

## 🔀 Migration from V1.0 (MongoDB → PostgreSQL)

### Before Migration
1. Have V1.0 (MongoDB) running and accessible
2. Have V2.0 (PostgreSQL) running and databases initialized

### Steps

1. **Backup V1.0 MongoDB** (already done in Phase 1)
   ```bash
   docker exec escolaconnect-mongo mongodump --archive=backup_v1_final.archive
   ```

2. **Run Migration Script**
   ```bash
   cd backend-v2
   
   # Set V1.0 MongoDB connection
   export MONGODB_V1_URL="mongodb://localhost:27017"
   
   # Run migration
   npm run migrate:from-v1
   ```

3. **Verify Data**
   - Check Adminer: http://localhost:8080
   - Test login with V1.0 credentials
   - Verify all users migrated correctly

## 🛠️ Available Commands

### Backend

```bash
npm run build          # Compile TypeScript
npm run dev           # Start dev server with hot reload
npm run start         # Start production server
npm run prisma:migrate  # Run database migrations
npm run prisma:seed   # Seed test data
npm run prisma:studio # Open Prisma Studio GUI
npm run db:init       # Migrate + Seed
```

### Frontend

```bash
npm run dev      # Start dev server
npm run build    # Build for production
npm run start    # Start production server
npm run lint     # Run ESLint
```

## 🐛 Troubleshooting

### Database Connection Issues

```bash
# Check if PostgreSQL is running
docker compose -f docker-compose.v2.yml ps

# View PostgreSQL logs
docker compose -f docker-compose.v2.yml logs postgres

# Reset database (careful!)
docker compose -f docker-compose.v2.yml down -v
docker compose -f docker-compose.v2.yml up -d
```

### Port Already in Use

```bash
# Change ports in docker-compose.v2.yml or:
# Linux/Mac:
lsof -i :3000  # Find process using port 3000
kill -9 <PID>

# Windows:
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### API Not Responding

```bash
# Check backend logs
docker compose -f docker-compose.v2.yml logs backend-v2

# Check if Prisma is initialized
docker compose -f docker-compose.v2.yml exec backend-v2 npm run prisma:migrate
```

## 📊 Admin Dashboard Features

The admin dashboard includes 6 tabs:

1. **Dashboard** - Overview with key statistics
2. **Users** - User management
3. **Classes** - Class/Turma management
4. **Grades** - Grade management
5. **Cantine** - Cantine configuration
6. **Settings** - System settings

## 🔐 Security Notes

- Change `JWT_SECRET` in production
- Use strong database passwords
- Enable HTTPS in production
- Set proper CORS origins
- Keep dependencies updated

## 📝 Environment Variables

### Backend (.env.local)

```env
DATABASE_URL=postgresql://escolaconnect:escolaconnect123@localhost:5432/escolaconnect
JWT_SECRET=dev_secret_key_change_in_production
NODE_ENV=development
PORT=8001
```

### Frontend (.env.local)

```env
NEXT_PUBLIC_API_URL=http://localhost:8001/api
NODE_ENV=development
```

## 🚀 Production Deployment

1. **Build Docker Images**
   ```bash
   docker compose -f docker-compose.v2.yml build
   ```

2. **Set Production Environment Variables**
   - Update `docker-compose.v2.yml` with prod values
   - Change JWT_SECRET
   - Set proper DATABASE_URL
   - Update CORS origins

3. **Deploy**
   ```bash
   docker compose -f docker-compose.v2.yml up -d
   ```

## 📚 API Documentation

### Auth Endpoints

```
POST /api/auth/login
  Body: { email, senha }
  Response: { success, data: { user, token } }

GET /api/auth/me
  Headers: Authorization: Bearer <token>
  Response: { success, data: user }
```

### User Endpoints

```
POST /api/users
  Headers: Authorization: Bearer <token>
  Body: { email, nome, senha, role }
  Response: { success, data: user }

GET /api/users
  Headers: Authorization: Bearer <token>
  Response: { success, data: [users] }

GET /api/users/:id
  Headers: Authorization: Bearer <token>
  Response: { success, data: user }
```

## 🆘 Support

For issues or questions:
1. Check logs: `docker compose -f docker-compose.v2.yml logs -f`
2. Check database: http://localhost:8080
3. Check API health: http://localhost:8001/health
4. Review this guide

## ✅ Checklist for Production

- [ ] Change JWT_SECRET
- [ ] Set DATABASE_URL to production
- [ ] Update CORS origins
- [ ] Enable HTTPS
- [ ] Setup backups
- [ ] Setup monitoring
- [ ] Test all user roles
- [ ] Test data migration from V1.0
- [ ] Load testing
- [ ] Security audit

---

**Version**: 2.0.0  
**Last Updated**: 2026-04-08
