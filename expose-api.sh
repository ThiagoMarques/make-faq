#!/bin/bash

echo "🌐 Expondo API local com localtunnel..."
echo "======================================"

# Verificar se a API está rodando
if ! lsof -i :3000 >/dev/null 2>&1; then
    echo "❌ API não está rodando na porta 3000"
    echo "💡 Execute primeiro: cd api && npm run dev"
    exit 1
fi

echo "✅ API detectada na porta 3000"

# Matar processos localtunnel existentes
pkill -f localtunnel 2>/dev/null

# Iniciar localtunnel
echo "🚀 Iniciando localtunnel..."
npx localtunnel --port 3000 > ltunnel.log 2>&1 &
LTUNNEL_PID=$!

# Aguardar localtunnel inicializar
echo "⏳ Aguardando localtunnel inicializar..."
sleep 5

# Obter URL do localtunnel
echo "🔍 Obtendo URL pública..."
LTUNNEL_URL=$(grep -o 'https://[^[:space:]]*' ltunnel.log | head -1)

if [ -n "$LTUNNEL_URL" ]; then
    echo ""
    echo "🎉 API exposta publicamente!"
    echo "================================="
    echo "📡 URL da API: ${LTUNNEL_URL}/api/faq"
    echo ""
    echo "🧪 Testando API..."
    curl -s "${LTUNNEL_URL}/api/faq" | head -3
    echo ""
    echo "📋 Para usar no Make:"
    echo "   URL: ${LTUNNEL_URL}/api/faq"
    echo "   Method: GET"
    echo ""
    echo "⏹️  Para parar: kill $LTUNNEL_PID"
    echo "📝 Logs em: ltunnel.log"
else
    echo "❌ Erro ao obter URL do localtunnel"
    echo "📝 Verifique os logs: cat ltunnel.log"
    kill $LTUNNEL_PID 2>/dev/null
    exit 1
fi