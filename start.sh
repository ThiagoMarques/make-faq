#!/bin/bash

echo "🚀 Iniciando Sistema de FAQ..."
echo "=================================="

# Verificar se estamos no diretório correto
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo "❌ Erro: Execute este script na pasta raiz do projeto (faq-system)"
    exit 1
fi

# Função para verificar se uma porta está em uso
check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null ; then
        echo "⚠️  Porta $1 já está em uso"
        return 1
    else
        return 0
    fi
}

# Verificar se as portas estão livres
echo "🔍 Verificando portas..."
if ! check_port 3000; then
    echo "❌ Porta 3000 (API) está em uso. Pare o processo e tente novamente."
    exit 1
fi

if ! check_port 3001; then
    echo "❌ Porta 3001 (frontend) está em uso. Pare o processo e tente novamente."
    exit 1
fi

echo "✅ Portas 3000 e 3001 estão livres"

# Verificar se as dependências estão instaladas
echo "📦 Verificando dependências..."

if [ ! -d "backend/node_modules" ]; then
    echo "📥 Instalando dependências da API..."
    cd backend
    npm install
    if [ $? -ne 0 ]; then
        echo "❌ Erro ao instalar dependências da API"
        exit 1
    fi
    cd ..
fi

if [ ! -d "frontend/node_modules" ]; then
    echo "📥 Instalando dependências do frontend..."
    cd frontend
    npm install
    if [ $? -ne 0 ]; then
        echo "❌ Erro ao instalar dependências do frontend"
        exit 1
    fi
    cd ..
fi

echo "✅ Dependências verificadas"

# Função para limpar processos ao sair
cleanup() {
    echo ""
    echo "🛑 Parando servidores..."
    kill $API_PID $FRONTEND_PID 2>/dev/null
    echo "✅ Servidores parados"
    exit 0
}

# Configurar trap para limpar processos
trap cleanup SIGINT SIGTERM

echo ""
echo "🚀 Iniciando servidores..."
echo "=================================="

# Iniciar API
echo "🔧 Iniciando API (Next.js API Routes) na porta 3000..."
cd backend
npm run dev > ../api.log 2>&1 &
API_PID=$!
cd ..

# Aguardar API inicializar
sleep 3

# Verificar se API está rodando
if ! kill -0 $API_PID 2>/dev/null; then
    echo "❌ Erro ao iniciar API. Verifique api.log"
    exit 1
fi

# Iniciar frontend
echo "🎨 Iniciando Frontend (React) na porta 3001..."
cd frontend
npm run dev > ../frontend.log 2>&1 &
FRONTEND_PID=$!
cd ..

# Aguardar frontend inicializar
sleep 3

# Verificar se frontend está rodando
if ! kill -0 $FRONTEND_PID 2>/dev/null; then
    echo "❌ Erro ao iniciar frontend. Verifique frontend.log"
    kill $API_PID 2>/dev/null
    exit 1
fi

echo ""
echo "🎉 Sistema FAQ iniciado com sucesso!"
echo "=================================="
echo "📡 API:      http://localhost:3000/api/faq"
echo "🎨 Frontend: http://localhost:3001"
echo ""
echo "📋 Logs disponíveis em:"
echo "   - api.log      (API Routes)"
echo "   - frontend.log (Frontend)"
echo ""
echo "⏹️  Pressione Ctrl+C para parar os servidores"
echo ""

# Aguardar indefinidamente
wait
