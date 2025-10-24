# 🧪 Testando a API do Sistema FAQ

## 🔗 **URLs da API:**

### **Produção (Vercel)**
- **URL**: https://backend-6uhdwbhbi-thiago-marques-projects-be57c58d.vercel.app/api/faq
- **Status**: ⚠️ Protegida por autenticação

### **Local (Desenvolvimento)**
- **URL**: http://localhost:3000/api/faq
- **Status**: ✅ Funcionando

## 🧪 **Como Testar:**

### **1. Via Terminal (Local)**
```bash
# Testar API local
curl http://localhost:3000/api/faq

# Testar com jq (se instalado)
curl http://localhost:3000/api/faq | jq '.'
```

### **2. Via Postman**
1. **Abrir Postman**
2. **Criar nova requisição GET**
3. **URL**: `http://localhost:3000/api/faq`
4. **Headers**: `Content-Type: application/json`
5. **Clique em Send**

### **3. Via Navegador**
- Acesse: http://localhost:3000/api/faq

## 📋 **Endpoints Disponíveis:**

### **GET /api/faq**
- **Descrição**: Lista todos os FAQs
- **Resposta**: Array de objetos FAQ
- **Exemplo**:
```json
[
  {
    "id": 1,
    "question": "Como posso criar uma conta no sistema?",
    "answer": "Para criar uma conta, clique no botão 'Registrar'...",
    "category": "Conta"
  }
]
```

### **POST /api/faq**
- **Descrição**: Adiciona novo FAQ
- **Body**:
```json
{
  "question": "Nova pergunta?",
  "answer": "Nova resposta...",
  "category": "Categoria"
}
```

## 🚀 **Para Usar em Produção:**

### **Opção 1: Desabilitar Proteção Vercel**
1. Acesse: https://vercel.com/dashboard
2. Selecione o projeto `backend`
3. Vá em Settings > Security
4. Desabilite "Vercel Authentication"

### **Opção 2: Usar Outro Serviço**
- **Railway**: `railway up`
- **Heroku**: `git push heroku main`
- **Netlify Functions**: Para APIs serverless

### **Opção 3: Usar API Local**
- Mantenha o backend rodando localmente
- Use `http://localhost:3000/api/faq` como URL da API

## ✅ **Status Atual:**
- ✅ **Backend Local**: Funcionando
- ✅ **Frontend Local**: Funcionando
- ⚠️ **Backend Produção**: Protegido por autenticação
- 🔄 **Próximo Passo**: Configurar acesso público ou usar outro serviço
