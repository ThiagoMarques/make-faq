#!/bin/bash

echo "🚀 Iniciando Sistema de FAQ - Modo Desenvolvimento"
echo "=================================================="

# Verificar se estamos no diretório correto
if [ ! -d "api" ] || [ ! -d "frontend" ]; then
    echo "❌ Erro: Execute este script na pasta raiz do projeto (faq-system)"
    exit 1
fi

# Instalar dependências se necessário
echo "📦 Verificando dependências..."

if [ ! -d "api/node_modules" ]; then
    echo "📥 Instalando dependências da API..."
    cd api && npm install && cd ..
fi

if [ ! -d "frontend/node_modules" ]; then
    echo "📥 Instalando dependências do frontend..."
    cd frontend && npm install && cd ..
fi

echo "✅ Dependências verificadas"
echo ""

# Iniciar API em background
echo "🔧 Iniciando API (Next.js API Routes)..."
cd api
npm run dev &
API_PID=$!
cd ..

# Aguardar um pouco
sleep 2

# Iniciar frontend em background
echo "🎨 Iniciando Frontend (React)..."
cd frontend
npm run dev &
FRONTEND_PID=$!
cd ..

# Aguardar um pouco
sleep 2

echo ""
echo "🎉 Sistema FAQ iniciado!"
echo "=================================================="
echo "📡 API:      http://localhost:3000/api/faq"
echo "🎨 Frontend: http://localhost:3001"
echo ""
echo "⏹️  Para parar: kill $API_PID $FRONTEND_PID"
echo ""

# Manter o script rodando
wait
