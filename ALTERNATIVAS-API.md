# 🔄 Alternativas para API Pública

## ❌ **Problema Atual:**
A API no Vercel está protegida por autenticação e não pode ser acessada publicamente.

## ✅ **Soluções Disponíveis:**

### **1. Usar API Local (Recomendado)**
```bash
# Manter backend rodando
cd backend && npm run dev

# Testar API
curl http://localhost:3000/api/faq
```

### **2. Railway (Alternativa Gratuita)**
```bash
# Instalar Railway CLI
npm install -g @railway/cli

# Login
railway login

# Deploy
railway up
```

### **3. Render (Alternativa Gratuita)**
1. Acesse: https://render.com
2. Conecte seu repositório GitHub
3. Configure como "Web Service"
4. Build Command: `npm install && npm run build`
5. Start Command: `npm start`

### **4. Netlify Functions**
```bash
# Instalar Netlify CLI
npm install -g netlify-cli

# Deploy
netlify deploy --prod
```

### **5. Heroku (Alternativa)**
```bash
# Instalar Heroku CLI
# Deploy
git push heroku main
```

## 🧪 **Testando API Local:**

### **Via Terminal:**
```bash
curl http://localhost:3000/api/faq
```

### **Via Postman:**
1. Abrir Postman
2. Nova requisição GET
3. URL: `http://localhost:3000/api/faq`
4. Send

### **Via Navegador:**
- Acesse: http://localhost:3000/api/faq

## 📋 **URLs Atuais:**

### **Local (Funcionando):**
- **Backend**: http://localhost:3000/api/faq ✅
- **Frontend**: http://localhost:3001 ✅

### **Produção (Protegido):**
- **Vercel**: https://backend-8jpay34kh-thiago-marques-projects-be57c58d.vercel.app/api/faq ❌

## 🚀 **Recomendação:**

**Use a API local** para desenvolvimento e testes. Para produção, considere:

1. **Railway** - Mais simples
2. **Render** - Interface amigável
3. **Netlify Functions** - Para serverless
4. **Heroku** - Tradicional

## 🔧 **Próximos Passos:**

1. **Manter API local rodando**
2. **Testar com Postman**
3. **Escolher alternativa para produção**
4. **Fazer deploy na plataforma escolhida**
