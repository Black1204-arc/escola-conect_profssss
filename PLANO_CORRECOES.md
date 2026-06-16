# 🔧 PLANO DE CORREÇÕES - ESCOLACONNECT

## VOU FAZER AS SEGUINTES CORREÇÕES:

### 1️⃣ BACKEND - CORRIGIR AUTORIZAÇÕES (CRÍTICO)
**Arquivos:** `server.py`

**Problema:** Endpoints de config exigem apenas `cantineiro`, mas Admin deve acessar também

**Linhas a corrigir:**
- Linha ~1180: GET `/api/cardapio/horarios/config`
- Linha ~1189: POST `/api/cardapio/horarios/config`
- Linha ~1260: GET `/api/recreio/horarios/config`
- Linha ~1269: POST `/api/recreio/horarios/config`
- Linha ~1310: GET `/api/frequencia/config`
- Linha ~1319: POST `/api/frequencia/config`

**Mudança:**
```python
# ANTES:
if current_user['tipo'] != 'cantineiro':
    raise HTTPException(status_code=403, detail="Acesso negado")

# DEPOIS:
if current_user['tipo'] not in ['cantineiro', 'admin']:
    raise HTTPException(status_code=403, detail="Acesso negado")
```

---

### 2️⃣ FRONTEND - SEPARAR VARIÁVEIS (IMPORTANTE)
**Arquivo:** `CantineSettings.js`

**Problema:** Variável `novoHorario` é compartilhada entre horários de refeição e recreio

**Mudanças:**
- Linha 7: Criar `const [novoHorarioRefeicao, setNovoHorarioRefeicao] = useState('');`
- Linha 8: Criar `const [novoHorarioRecreio, setNovoHorarioRecreio] = useState('');`
- Remover: `const [novoHorario, setNovoHorario] = useState('');`
- Atualizar todas as referências de `novoHorario` para `novoHorarioRefeicao` (aba refeição)
- Atualizar todas as referências de `novoHorario` para `novoHorarioRecreio` (aba recreio)

**Impacto:** Inputs ficarão independentes, sem confusão de dados

---

### 3️⃣ FRONTEND - ADICIONAR TRATAMENTO DE ERRO (IMPORTANTE)
**Arquivo:** `CantineSettings.js`

**Problema:** Se receber erro 403, não mostra mensagem clara ao usuário

**Mudanças:** Adicionar try-catch em cada fetch com mensagem amigável

**Exemplo:**
```javascript
try {
  const data = await response.json();
  setHorarios(data.horarios);
} catch (err) {
  console.error('Erro:', err);
  alert('❌ Erro ao carregar horários de refeição. Você tem permissão para acessar?');
}
```

---

### 4️⃣ TESTES (VALIDAÇÃO)
Após as correções, vou testar:
1. ✅ Backend inicia sem erros
2. ✅ Login como admin funciona
3. ✅ Admin consegue acessar aba "🍽️ Config. Cantina"
4. ✅ Admin consegue adicionar horário de refeição
5. ✅ Admin consegue adicionar horário de recreio
6. ✅ Admin consegue adicionar opção de frequência
7. ✅ Cantineiro ainda consegue acessar (não deve quebrar)
8. ✅ Aluno consegue ver frequência (não tem botões para editar)

---

## RESUMO DO QUE VAI MUDAR

| Item | Antes | Depois | Status |
|------|-------|--------|--------|
| Admin acessa Config. Cantina | ❌ 403 Forbidden | ✅ Funciona | CORRIGIDO |
| Input de horário de refeição | Compartilhado | Independente | MELHORADO |
| Input de horário de recreio | Compartilhado | Independente | MELHORADO |
| Erro 403 silencioso | Sim | Mensagem clara | MELHORADO |
| Cantineiro continua funcionando | ✅ Sim | ✅ Sim | MANTIDO |

---

## TEMPO ESTIMADO
- Backend: 5 minutos
- Frontend: 10 minutos  
- Testes: 5 minutos
- **Total: 20 minutos**

---

## ⚠️ COISAS QUE NÃO VOU MEXER (FUNCIONANDO BEM)
- Autenticação/Login
- Temas dark/light
- Componentes do admin (Statistics, UserManager, etc)
- Painel do cantineiro
- Painel do aluno
- Painel do professor
- Banco de dados
- Docker compose

---

## ❌ COISAS QUE ENCONTREI MAS NÃO SÃO CRÍTICAS

1. **useEffect warnings** - React dizendo que dependencies estão faltando (só avisos, não quebra)
2. **Backend em arquivo único** - Seria bom refatorar em módulos, mas funciona assim
3. **Sem README** - Deveria ter documentação
4. **Sem interceptor de token expirado** - Deveria verificar se token expirou ao fazer requisições

**Mas nenhum desses impede o funcionamento do sistema.**

---

## CONFIRMAÇÃO NECESSÁRIA

Posso prosseguir com TUDO que planejei acima? (S/N)
