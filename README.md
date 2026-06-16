# 🎓 EscolaConnect - Sistema de Gestão Escolar

Sistema completo de gestão escolar desenvolvido com FastAPI, React 19 e MongoDB.

## 📋 Características

### 🔐 Tipos de Usuários

* **Administrador**: Controle total do sistema
* **Professor**: Lançamento de notas e faltas
* **Aluno**: Visualização de desempenho acadêmico
* **Cantineiro**: Gerenciamento de cardápio

### 🏫 Sistema de Turmas

* Formato ABC (3 dígitos): Exemplo: 101, 201, 301

  * Primeiro dígito = Ano (1º, 2º ou 3º)
  * Últimos dois dígitos = Número da turma (01 a 10)
* Promoção automática anual:

  * 1º Ano (101-110) → 2º Ano (201-210)
  * 2º Ano (201-210) → 3º Ano (301-310)
  * 3º Ano (301-310) → Concluído (444) - Contas arquivadas

### 📊 Sistema de Pontuação

* Total anual fixo: **100 pontos**
* Pontos para aprovação: **60 pontos** (configurável)
* Modelos de ano letivo:

  * **Anual** (1 período) - Padrão
  * **Bimestral** (4 períodos)
  * **Trimestral** (3 períodos)

## 🚀 Tecnologias Utilizadas

### Backend

* **FastAPI** - Framework web assíncrono
* **MongoDB** - Banco de dados NoSQL
* **Motor** - Driver assíncrono para MongoDB
* **JWT** - Autenticação via tokens
* **Bcrypt** - Hash de senhas
* **Pydantic** - Validação de dados

### Frontend

* **React 19** - Biblioteca UI
* **React Router** - Roteamento
* **Axios** - Cliente HTTP
* **Tailwind CSS** - Framework CSS
* **Shadcn/ui** - Componentes UI

## 📦 Instalação e Execução

### Backend

```bash
cd /app/backend
pip install -r requirements.txt
```

### Frontend

```bash
cd /app/frontend
yarn install
```

### Iniciar Serviços

```bash
sudo supervisorctl restart all
```

## 🔑 Credenciais Padrão

**Administrador:**

* Email: `admin@escolaconnect.com`
* Senha: `admin123`

## 📝 Funcionalidades por Tipo de Usuário

### 👨‍💼 Administrador

* ✅ Criar contas de professor e cantineiro
* ✅ Aprovar contas de alunos
* ✅ Resetar senhas de usuários
* ✅ Configurar modelo do ano letivo (bimestral/trimestral/anual)
* ✅ Definir regra de aprovação (pontos mínimos)
* ✅ Visualizar estatísticas gerais do sistema
* ✅ Ver média da turma
* ✅ Enviar mensagens segmentadas (por tipo de usuário ou geral)
* ✅ Executar promoção automática de turmas
* ✅ Gerenciar usuários (listar, arquivar, excluir)

### 👨‍🏫 Professor

* ✅ Criar disciplinas
* ✅ Lançar notas para alunos
* ✅ Editar notas da própria disciplina
* ✅ Registrar faltas
* ✅ Visualizar total de pontos dos alunos
* ✅ Calcular média da turma
* ✅ Enviar avisos para alunos

### 🎓 Aluno

* ✅ Criar própria conta (necessita aprovação do admin)
* ✅ Escolher turma no formato ABC (101, 201, 301)
* ✅ Visualizar notas por período
* ✅ Visualizar total acumulado (progressão até 100 pontos)
* ✅ Visualizar faltas por disciplina
* ✅ Visualizar avisos de professores e administração
* ✅ Consultar cardápio da cantina
* ✅ Ver status de aprovação em tempo real

### 🍽️ Cantineiro

* ✅ Criar/atualizar cardápio diário
* ✅ Criar/atualizar cardápio semanal
* ✅ Informar itens indisponíveis
* ✅ Publicar avisos relacionados à alimentação
* ✅ Histórico de cardápios

## 🌐 Endpoints da API

### Autenticação

* `POST /api/auth/register` - Registro de usuários
* `POST /api/auth/login` - Login
* `GET /api/auth/me` - Dados do usuário logado

### Admin

* `GET /api/admin/usuarios-pendentes` - Lista alunos pendentes
* `POST /api/admin/aprovar-usuario/{user\\\_id}` - Aprovar aluno
* `POST /api/admin/criar-usuario` - Criar professor/cantineiro
* `GET /api/admin/usuarios` - Listar todos os usuários
* `POST /api/admin/resetar-senha/{user\\\_id}` - Resetar senha
* `GET /api/admin/configuracao` - Ver configurações
* `PUT /api/admin/configuracao` - Atualizar configurações
* `POST /api/admin/promover-turmas` - Promover todas as turmas
* `GET /api/admin/estatisticas` - Estatísticas gerais

### Disciplinas

* `POST /api/disciplinas` - Criar disciplina
* `GET /api/disciplinas` - Listar disciplinas
* `GET /api/disciplinas/professor/{professor\\\_id}` - Disciplinas do professor

### Notas

* `POST /api/notas` - Lançar nota
* `PUT /api/notas/{nota\\\_id}` - Editar nota
* `GET /api/notas/aluno/{aluno\\\_id}` - Notas do aluno
* `GET /api/notas/turma/{turma}` - Média da turma

### Faltas

* `POST /api/faltas` - Registrar falta
* `GET /api/faltas/aluno/{aluno\\\_id}` - Faltas do aluno

### Cardápio

* `POST /api/cardapio` - Criar/atualizar cardápio
* `GET /api/cardapio` - Listar cardápios
* `GET /api/cardapio/hoje` - Cardápio de hoje

### Mensagens

* `POST /api/mensagens` - Enviar mensagem
* `GET /api/mensagens` - Listar mensagens do usuário
* `GET /api/mensagens/turma/{turma}` - Mensagens da turma

### Turmas

* `GET /api/turmas` - Listar turmas disponíveis

## 🎨 Esquema de Cores

* **Azul Primário**: #1e40af, #3b82f6
* **Branco**: #ffffff
* **Preto**: #0f0f10, #1f1f1f
* **Cores de Status**:

  * Verde: Aprovado
  * Amarelo: Atenção
  * Vermelho: Reprovado/Crítico

## 🔒 Segurança

* Autenticação JWT com tokens de 7 dias
* Senhas criptografadas com bcrypt
* Proteção de rotas por tipo de usuário
* Validação de dados com Pydantic
* CORS configurado

## 🗄️ Estrutura do Banco de Dados

### Collections MongoDB:

* `users` - Usuários do sistema
* `configuracao` - Configurações do sistema
* `disciplinas` - Disciplinas cadastradas
* `notas` - Notas dos alunos
* `faltas` - Faltas dos alunos
* `cardapios` - Cardápios da cantina
* `mensagens` - Mensagens e avisos

## 📱 Responsividade

O sistema é totalmente responsivo e funciona em:

* 💻 Desktop
* 📱 Tablets
* 📱 Smartphones

## 🧪 Testando o Sistema

### 1\. Testar Login do Admin

```bash
curl -X POST "http://localhost:8001/api/auth/login" \\\\
  -H "Content-Type: application/json" \\\\
  -d '{"email":"admin@escolaconnect.com","senha":"admin123"}'
```

### 2\. Criar um Professor (como Admin)

```bash
curl -X POST "http://localhost:8001/api/admin/criar-usuario" \\\\
  -H "Authorization: Bearer <TOKEN>" \\\\
  -H "Content-Type: application/json" \\\\
  -d '{
    "email":"professor@escolaconnect.com",
    "nome":"Professor João",
    "senha":"senha123",
    "tipo":"professor"
  }'
```

### 3\. Registrar um Aluno

```bash
curl -X POST "http://localhost:8001/api/auth/register" \\\\
  -H "Content-Type: application/json" \\\\
  -d '{
    "email":"aluno@escolaconnect.com",
    "nome":"Maria Silva",
    "senha":"senha123",
    "tipo":"aluno",
    "turma":"101"
  }'
```

## 🎯 Fluxo de Uso

1. **Admin** faz login e configura o sistema
2. **Admin** cria contas de professores e cantineiros
3. **Alunos** se registram escolhendo suas turmas
4. **Admin** aprova os cadastros de alunos
5. **Professores** criam disciplinas
6. **Professores** lançam notas e registram faltas
7. **Alunos** acompanham seu desempenho em tempo real
8. **Cantineiro** atualiza o cardápio diariamente
9. **Admin** envia avisos gerais quando necessário
10. **Admin** promove as turmas ao final do ano letivo

## 📊 Sistema de Comunicação

* **Canal Geral**: Todos os usuários
* **Canal por Tipo**: Admin pode enviar para professores, alunos ou cantineiros específicos
* **Canal por Turma**: Professores podem enviar avisos para turmas específicas
* **Histórico Completo**: Todas as mensagens são armazenadas

## 🔄 Promoção Automática

O sistema possui um botão no painel do administrador para executar a promoção automática de todas as turmas:

* Alunos do 1º ano passam para o 2º ano
* Alunos do 2º ano passam para o 3º ano
* Alunos do 3º ano são marcados como concluídos (turma 444)
* Contas concluídas são automaticamente arquivadas

## 🛠️ Desenvolvimento

### Estrutura de Pastas

```
/app
├── backend/
│   ├── server.py          # API FastAPI
│   ├── requirements.txt   # Dependências Python
│   └── .env              # Variáveis de ambiente
├── frontend/
│   ├── src/
│   │   ├── components/   # Componentes React
│   │   ├── utils/        # Utilitários (API, Auth)
│   │   ├── App.js        # App principal
│   │   └── index.js      # Entry point
│   ├── package.json      # Dependências Node
│   └── .env             # Variáveis de ambiente
└── README.md            # Documentação
```

## 📧 Contato e Suporte

Sistema desenvolvido como solução completa para gestão escolar.

\---

**EscolaConnect** - Transformando a gestão escolar! 🎓✨

