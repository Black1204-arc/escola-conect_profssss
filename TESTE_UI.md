# 🎓 EscolaConnect - Guia de Teste da UI

## ✅ Pré-requisitos
- Docker rodando (docker-compose watch ou docker-compose up -d)
- Browser aberto (Chrome, Firefox, Safari, Edge)

---

## 🧪 Teste 1: Acessar a Aplicação

1. **Abra o browser**
2. **Acesse**: http://localhost:3000
3. **Você deve ver**:
   - Header com logo "🎓 EscolaConnect"
   - Abas: Dashboard, Usuários, Alunos
   - Se aparecer "Carregando..." → Aguarde 2-3 segundos

### Resultado Esperado:
```
✅ Dashboard com 4 cards:
   - 👥 Usuários: 0
   - 🎓 Alunos: 0
   - 📚 Turmas: 0
   - 📝 Notas: 0
```

---

## 🧪 Teste 2: Aba "Usuários"

1. **Clique na aba "Usuários"** (lado direito do header)
2. **Preencha o formulário**:
   - Nome: `João Silva`
   - Email: `joao@example.com`
   - Função: Selecione `Professor`
3. **Clique em "Adicionar Usuário"**

### Resultado Esperado:
```
✅ Aparece mensagem de sucesso (opcional)
✅ Tabela preenche com o usuário criado:
   - Nome: João Silva
   - Email: joao@example.com
   - Função: 👨‍🏫 Professor (com badge azul)
```

### Teste Adicional - Criar mais usuários:
1. **Crie outro usuário**:
   - Nome: `Maria Santos`
   - Email: `maria@example.com`
   - Função: `Admin`

2. **Crie um terceiro**:
   - Nome: `Pedro Alves`
   - Email: `pedro@example.com`
   - Função: `Aluno`

### Resultado Esperado:
```
✅ Tabela mostra 3 usuários com cores diferentes:
   - Admin: 👨‍💼 Admin (badge vermelho)
   - Professor: 👨‍🏫 Professor (badge azul)
   - Aluno: 🎓 Aluno (badge verde)
```

---

## 🧪 Teste 3: Aba "Alunos"

1. **Clique na aba "Alunos"** (lado direito do header)
2. **Preencha o formulário**:
   - Nome: `Ana Costa`
   - Matrícula: `2024001`
   - Turma: `9º A`
3. **Clique em "Adicionar Aluno"**

### Resultado Esperado:
```
✅ Tabela preenche com o aluno criado:
   - Nome: Ana Costa
   - Matrícula: 2024001
   - Turma: 9º A
```

### Teste Adicional - Criar mais alunos:
1. **Crie outro aluno**:
   - Nome: `Bruno Lima`
   - Matrícula: `2024002`
   - Turma: `9º B`

2. **Crie um terceiro**:
   - Nome: `Carla Dias`
   - Matrícula: `2024003`
   - Turma: `9º A`

### Resultado Esperado:
```
✅ Tabela mostra 3 alunos:
   Ana Costa   2024001  9º A
   Bruno Lima  2024002  9º B
   Carla Dias  2024003  9º A
```

---

## 🧪 Teste 4: Voltar ao Dashboard

1. **Clique na aba "Dashboard"**
2. **Verifique as estatísticas**

### Resultado Esperado:
```
✅ Os cards agora mostram números atualizados:
   - 👥 Usuários: 3
   - 🎓 Alunos: 3
   - 📚 Turmas: 0
   - 📝 Notas: 0
```

---

## 🧪 Teste 5: Responsividade (Mobile)

1. **Abra DevTools** (F12 ou Cmd+Option+I)
2. **Clique no ícone de Device** (ou Cmd+Shift+M)
3. **Selecione "iPhone 12"**
4. **Verifique**:
   - ✅ Header responsivo
   - ✅ Abas acessíveis
   - ✅ Formulário em coluna única
   - ✅ Tabela com scroll horizontal

### Resultado Esperado:
```
✅ UI adapta para mobile:
   - Cards em coluna única (320px+)
   - Tabela com scroll horizontal
   - Botões com espaçamento adequado
```

---

## 🧪 Teste 6: Hot-Reload (Desenvolvimento)

### Teste A: Editar Frontend
1. **Abra o arquivo**: `frontend/src/App.js`
2. **Procure por**: `EscolaConnect`
3. **Mude para**: `EscolaConnect v2.0` (ou qualquer texto)
4. **Salve o arquivo** (Ctrl+S)
5. **Volte ao browser**

### Resultado Esperado:
```
✅ Página recarrega automaticamente
✅ Novo texto aparece no header sem refresh manual
```

### Teste B: Editar Backend
1. **Abra o arquivo**: `backend/server.py`
2. **Procure por**: `"EscolaConnect API"`
3. **Mude para**: `"EscolaConnect API v2.0"`
4. **Salve o arquivo**
5. **Abra uma aba nova** (não feche a atual)
6. **Execute em Terminal**:
   ```bash
   curl http://localhost:8001/api/
   ```

### Resultado Esperado:
```
✅ Response mostra:
{
  "status": "ok",
  "message": "🎓 EscolaConnect API v2.0",
  "version": "1.0.0"
}
```

---

## 🧪 Teste 7: Validação de Campos

1. **Aba "Usuários"**
2. **Tente submeter o formulário vazio**
3. **Clique em "Adicionar Usuário"**

### Resultado Esperado:
```
✅ Campos com required=true mostram erro:
   - "Nome" - campo obrigatório
   - "Email" - campo obrigatório
   - (Não deixa submeter)
```

---

## 🧪 Teste 8: Persistência de Dados

1. **Crie 5 usuários**
2. **Vá para aba "Alunos"** e volte para "Usuários"

### Resultado Esperado:
```
✅ Os 5 usuários continuam lá
✅ Dados persistem no MongoDB
```

3. **Restart dos containers**:
   ```bash
   docker-compose down
   docker-compose up -d
   ```
4. **Abra http://localhost:3000 novamente**

### Resultado Esperado:
```
✅ Os dados persistem após restart
✅ MongoDB salvou os dados
```

---

## 🐛 Troubleshooting

### "Página em branco"
```bash
# Ver logs do frontend
docker-compose logs frontend --tail 50
```

### "Não consigo adicionar usuário"
```bash
# Checar se backend está respondendo
curl http://localhost:8001/api/

# Se der erro, ver logs
docker-compose logs backend --tail 50
```

### "Dados não aparecem na tabela"
1. Abra DevTools (F12)
2. Vá em "Network"
3. Submeta o formulário
4. Procure por requisição GET/POST para `/api/users`
5. Veja a resposta em "Response"

### "Hot-reload não funciona"
```bash
# Parar e reiniciar com watch
docker-compose down
docker-compose watch
```

---

## 📊 Checklist Final

- [ ] Consegui acessar http://localhost:3000
- [ ] Dashboard mostra estatísticas
- [ ] Consegui criar usuários
- [ ] Consegui criar alunos
- [ ] Badges de função mostram cores corretas
- [ ] Dados persistem após navegar
- [ ] Hot-reload funciona ao editar arquivos
- [ ] UI é responsiva em mobile
- [ ] Tabelas mostram dados corretamente

---

## ✅ Se tudo passou...

Parabéns! Sua aplicação está funcionando perfeitamente! 🎉

Próximas features a testar (quando forem adicionadas):
- [ ] Login/Autenticação
- [ ] Upload de PDF
- [ ] Relatórios
- [ ] Notificações
- [ ] Dashboard de professor
- [ ] Boletim do aluno
