CREATE TYPE "Role" AS ENUM ('admin', 'professor', 'cantineiro', 'aluno');

CREATE TABLE "users" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL UNIQUE,
    "nome" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "professores" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL UNIQUE,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "professores_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "turmas" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "ano" INTEGER NOT NULL,
    "professor_id" TEXT NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "turmas_professor_id_fkey" FOREIGN KEY ("professor_id") REFERENCES "professores" ("id") ON DELETE CASCADE
);

CREATE TABLE "alunos" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL UNIQUE,
    "turma_id" TEXT,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "alunos_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
    CONSTRAINT "alunos_turma_id_fkey" FOREIGN KEY ("turma_id") REFERENCES "turmas" ("id")
);

CREATE TABLE "notas" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "aluno_id" TEXT NOT NULL,
    "professor_id" TEXT NOT NULL,
    "turma_id" TEXT NOT NULL,
    "disciplina" TEXT NOT NULL,
    "bimestre" INTEGER NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "notas_aluno_id_fkey" FOREIGN KEY ("aluno_id") REFERENCES "alunos" ("id") ON DELETE CASCADE,
    CONSTRAINT "notas_professor_id_fkey" FOREIGN KEY ("professor_id") REFERENCES "professores" ("id") ON DELETE CASCADE,
    CONSTRAINT "notas_turma_id_fkey" FOREIGN KEY ("turma_id") REFERENCES "turmas" ("id") ON DELETE CASCADE,
    UNIQUE("aluno_id", "professor_id", "disciplina", "bimestre")
);

CREATE TABLE "faltas" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "aluno_id" TEXT NOT NULL,
    "professor_id" TEXT NOT NULL,
    "turma_id" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL,
    "justificada" BOOLEAN NOT NULL DEFAULT false,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "faltas_aluno_id_fkey" FOREIGN KEY ("aluno_id") REFERENCES "alunos" ("id") ON DELETE CASCADE,
    CONSTRAINT "faltas_professor_id_fkey" FOREIGN KEY ("professor_id") REFERENCES "professores" ("id") ON DELETE CASCADE,
    CONSTRAINT "faltas_turma_id_fkey" FOREIGN KEY ("turma_id") REFERENCES "turmas" ("id") ON DELETE CASCADE
);

CREATE TABLE "configuracoes" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "chave" TEXT NOT NULL UNIQUE,
    "valor" TEXT NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "turmas_professor_id_idx" ON "turmas"("professor_id");
CREATE INDEX "alunos_turma_id_idx" ON "alunos"("turma_id");
CREATE INDEX "notas_aluno_id_idx" ON "notas"("aluno_id");
CREATE INDEX "notas_professor_id_idx" ON "notas"("professor_id");
CREATE INDEX "notas_turma_id_idx" ON "notas"("turma_id");
CREATE INDEX "faltas_aluno_id_idx" ON "faltas"("aluno_id");
CREATE INDEX "faltas_professor_id_idx" ON "faltas"("professor_id");
CREATE INDEX "faltas_turma_id_idx" ON "faltas"("turma_id");

-- Insert test users
INSERT INTO "users" ("id", "email", "nome", "senha", "role", "ativo") VALUES
('admin-001', 'admin@escolaconnect.com', 'Administrador', '$2b$10$yMg0LW3gM.z5PJJF3q8YhOcLkZG0Z6zJz5x8K8L2P9Z5X8Y7W6V5', 'admin', true),
('prof-001', 'professor@escola.com', 'Prof. João Silva', '$2b$10$yMg0LW3gM.z5PJJF3q8YhOcLkZG0Z6zJz5x8K8L2P9Z5X8Y7W6V5', 'professor', true),
('canti-001', 'cantina@escola.com', 'Cantineira Maria', '$2b$10$yMg0LW3gM.z5PJJF3q8YhOcLkZG0Z6zJz5x8K8L2P9Z5X8Y7W6V5', 'cantineiro', true),
('aluno-001', 'aluno@escola.com', 'Aluno Pedro', '$2b$10$yMg0LW3gM.z5PJJF3q8YhOcLkZG0Z6zJz5x8K8L2P9Z5X8Y7W6V5', 'aluno', true);
