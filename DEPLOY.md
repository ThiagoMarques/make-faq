# 🚀 Deploy do Sistema FAQ

## 📋 Opções de Deploy

### 1. **Vercel (Recomendado para Next.js)**

#### **Backend (API)**
```bash
# Instalar Vercel CLI
npm install -g vercel

# Navegar para o backend
cd backend

# Fazer login no Vercel
vercel login

# Deploy
vercel --prod
```

#### **Frontend (React)**
```bash
# Navegar para o frontend
cd frontend

# Deploy
vercel --prod
```

### 2. **Netlify (Alternativa)**

#### **Backend**
- Use o Vercel para o backend (Next.js)
- Ou converta para Express.js para usar no Netlify

#### **Frontend**
```bash
# Build do frontend
cd frontend
npm run build

# Deploy no Netlify
# 1. Acesse: https://app.netlify.com
# 2. Arraste a pasta 'dist' para o Netlify
# 3. Configure as variáveis de ambiente
```

### 3. **Railway (Alternativa)**

```bash
# Instalar Railway CLI
npm install -g @railway/cli

# Login
railway login

# Deploy
railway up
```

## 🔧 **Configuração Pós-Deploy**

### **1. Atualizar URL da API**

Após fazer deploy do backend, atualize o arquivo:
`frontend/src/config/api.ts`

```typescript
export const API_BASE_URL = isDevelopment 
  ? 'http://localhost:3000'
  : 'https://SUA-URL-DO-BACKEND.vercel.app'  // Substitua pela sua URL
```

### **2. Variáveis de Ambiente**

Crie um arquivo `.env.local` no frontend:
```env
VITE_API_URL=https://sua-api.vercel.app
```

## 📦 **Scripts de Deploy**

### **Deploy Automático**
```bash
./deploy.sh
```

### **Deploy Manual**
```bash
# Backend
cd backend && vercel --prod

# Frontend  
cd frontend && vercel --prod
```

## ✅ **Verificação**

Após o deploy, teste:
- **API**: `https://sua-api.vercel.app/api/faq`
- **Frontend**: `https://seu-frontend.vercel.app`

## 🔗 **URLs de Exemplo**

- **Backend**: `https://faq-backend.vercel.app/api/faq`
- **Frontend**: `https://faq-frontend.vercel.app`

## 🛠️ **Troubleshooting**

### **CORS Error**
Se houver erro de CORS, adicione no `next.config.js`:
```javascript
async headers() {
  return [
    {
      source: '/api/:path*',
      headers: [
        { key: 'Access-Control-Allow-Origin', value: '*' },
        { key: 'Access-Control-Allow-Methods', value: 'GET, POST, PUT, DELETE, OPTIONS' },
        { key: 'Access-Control-Allow-Headers', value: 'Content-Type, Authorization' },
      ],
    },
  ]
}
```

### **Build Error**
Se houver erro de build:
```bash
# Limpar cache
rm -rf node_modules package-lock.json
npm install
npm run build
```
