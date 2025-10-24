#!/bin/bash

echo "🚀 Deploy do Sistema FAQ"
echo "========================"

# Verificar se o Vercel CLI está instalado
if ! command -v vercel &> /dev/null; then
    echo "📦 Instalando Vercel CLI localmente..."
    npm install vercel
fi

echo "🔧 Configurando deploy do backend..."

# Navegar para o backend
cd backend

# Fazer login no Vercel (se necessário)
echo "🔐 Verificando autenticação Vercel..."
if ! npx vercel whoami &> /dev/null; then
    echo "Por favor, faça login no Vercel:"
    npx vercel login
fi

# Deploy do backend
echo "📤 Fazendo deploy do backend..."
npx vercel --prod --yes

if [ $? -eq 0 ]; then
    echo "✅ Backend deployado com sucesso!"
    echo "🔗 URL da API será exibida acima"
    echo ""
    echo "📋 Próximos passos:"
    echo "1. Copie a URL da API (ex: https://seu-app.vercel.app/api/faq)"
    echo "2. Atualize o frontend para usar a URL de produção"
    echo "3. Faça deploy do frontend no Vercel ou Netlify"
else
    echo "❌ Erro no deploy do backend"
    exit 1
fi

cd ..
