#!/bin/bash

echo "🌐 Configurando túnel público para Make"
echo "======================================="

# Verificar se ngrok está instalado
if ! command -v ngrok &> /dev/null; then
    echo "📦 Instalando ngrok..."
    
    # Detectar sistema operacional
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        curl -o ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-darwin-amd64.zip
        unzip ngrok.zip
        sudo mv ngrok /usr/local/bin/
        rm ngrok.zip
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        curl -o ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip
        unzip ngrok.zip
        sudo mv ngrok /usr/local/bin/
        rm ngrok.zip
    else
        echo "❌ Sistema operacional não suportado"
        echo "💡 Instale manualmente: https://ngrok.com/download"
        exit 1
    fi
fi

echo "✅ ngrok instalado"

# Verificar se a API está rodando
echo "🔍 Verificando se a API está rodando..."
if ! curl -s http://localhost:3000/api/faq > /dev/null; then
    echo "❌ API não está rodando na porta 3000"
    echo "💡 Execute: cd backend && npm run dev"
    exit 1
fi

echo "✅ API está rodando"

# Iniciar ngrok
echo "🚀 Iniciando túnel público..."
echo "📋 URL pública será exibida abaixo"
echo "🔗 Use esta URL no Make:"
echo ""

ngrok http 3000
