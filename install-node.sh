#!/bin/bash

echo "🚀 Instalando Node.js..."
echo "========================"

# Detectar arquitetura do sistema
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    NODE_ARCH="arm64"
    echo "🔍 Arquitetura detectada: ARM64 (Apple Silicon)"
else
    NODE_ARCH="x64"
    echo "🔍 Arquitetura detectada: x64 (Intel)"
fi

# Versão LTS do Node.js
NODE_VERSION="20.10.0"
NODE_URL="https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-darwin-${NODE_ARCH}.tar.gz"

echo "📥 Baixando Node.js v${NODE_VERSION}..."
curl -L "$NODE_URL" -o node.tar.gz

if [ $? -ne 0 ]; then
    echo "❌ Erro ao baixar Node.js"
    echo "💡 Alternativa: Acesse https://nodejs.org e baixe manualmente"
    exit 1
fi

echo "📦 Extraindo Node.js..."
tar -xzf node.tar.gz

echo "🔧 Instalando Node.js..."
sudo cp -r node-v${NODE_VERSION}-darwin-${NODE_ARCH}/* /usr/local/

echo "🧹 Limpando arquivos temporários..."
rm -rf node-v${NODE_VERSION}-darwin-${NODE_ARCH}
rm -f node.tar.gz

echo "✅ Node.js instalado com sucesso!"
echo "📋 Verificando instalação..."
node --version
npm --version

echo ""
echo "🎉 Instalação concluída!"
echo "💡 Reinicie o terminal ou execute: source ~/.bashrc"
