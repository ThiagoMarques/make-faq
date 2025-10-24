# 🔗 Integração com Make (Integromat)

## 📋 **Informações da API para Make:**

### **URL da API:**
```
http://localhost:3000/api/faq
```

### **Método HTTP:**
```
GET
```

### **Headers:**
```
Content-Type: application/json
```

### **Resposta da API:**
```json
[
  {
    "id": 1,
    "question": "Como posso criar uma conta no sistema?",
    "answer": "Para criar uma conta, clique no botão 'Registrar' na página inicial, preencha os dados solicitados e confirme seu email através do link enviado.",
    "category": "Conta"
  },
  {
    "id": 2,
    "question": "Esqueci minha senha, como recuperar?",
    "answer": "Na página de login, clique em 'Esqueci minha senha', informe seu email e siga as instruções enviadas para redefinir sua senha.",
    "category": "Conta"
  }
]
```

## 🚀 **Configuração no Make:**

### **1. Criar Novo Cenário**
1. Acesse: https://www.make.com
2. Clique em "Create a new scenario"
3. Nome: "FAQ System Integration"

### **2. Adicionar Módulo HTTP**
1. Clique em "Add a module"
2. Procure por "HTTP" ou "Webhook"
3. Selecione "Make an HTTP Request"

### **3. Configurar Requisição HTTP**
```
URL: http://localhost:3000/api/faq
Method: GET
Headers:
  Content-Type: application/json
```

### **4. Testar Conexão**
1. Clique em "Run once"
2. Verifique se retorna os dados JSON
3. Se funcionar, salve o cenário

## 🔧 **Para Produção:**

### **Opção 1: Usar ngrok (Túnel Local)**
```bash
# Instalar ngrok
npm install -g ngrok

# Criar túnel
ngrok http 3000

# Usar URL pública no Make
# Exemplo: https://abc123.ngrok.io/api/faq
```

### **Opção 2: Deploy em Produção**
- **Railway**: `npm install -g @railway/cli && railway up`
- **Render**: https://render.com
- **Heroku**: `git push heroku main`

## 📊 **Estrutura dos Dados:**

### **Cada FAQ contém:**
- `id`: Número único
- `question`: Pergunta
- `answer`: Resposta
- `category`: Categoria

### **Exemplo de uso no Make:**
```javascript
// Para acessar dados no Make
{{1.question}} // Primeira pergunta
{{1.answer}}   // Primeira resposta
{{1.category}} // Primeira categoria
```

## 🎯 **Casos de Uso:**

### **1. Enviar FAQs por Email**
- Trigger: Schedule (diário)
- Action: Email com lista de FAQs

### **2. Sincronizar com Base de Dados**
- Trigger: Webhook
- Action: Salvar em banco externo

### **3. Notificar Mudanças**
- Trigger: Webhook
- Action: Slack/Teams notification

## 🔍 **Troubleshooting:**

### **Erro de Conexão:**
1. Verificar se API está rodando: `curl http://localhost:3000/api/faq`
2. Verificar firewall/antivírus
3. Usar ngrok para túnel público

### **Erro de CORS:**
- Adicionar headers CORS na API
- Usar ngrok para evitar CORS

## 📝 **Scripts Úteis:**

### **Testar API:**
```bash
curl -X GET http://localhost:3000/api/faq \
  -H "Content-Type: application/json"
```

### **Iniciar ngrok:**
```bash
ngrok http 3000
```

### **Verificar status:**
```bash
curl -I http://localhost:3000/api/faq
```
