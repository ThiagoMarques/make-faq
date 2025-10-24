#!/bin/bash

echo "🛑 Parando Sistema de FAQ..."
echo "============================="

# Função para parar processos por porta
stop_by_port() {
    local port=$1
    local service_name=$2
    
    # Encontrar PID do processo na porta
    local pid=$(lsof -ti:$port 2>/dev/null)
    
    if [ -n "$pid" ]; then
        echo "🔍 Encontrado $service_name rodando na porta $port (PID: $pid)"
        echo "⏹️  Parando $service_name..."
        kill $pid 2>/dev/null
        
        # Aguardar o processo parar
        local count=0
        while kill -0 $pid 2>/dev/null && [ $count -lt 10 ]; do
            sleep 1
            count=$((count + 1))
        done
        
        if kill -0 $pid 2>/dev/null; then
            echo "⚠️  Forçando parada do $service_name..."
            kill -9 $pid 2>/dev/null
        fi
        
        echo "✅ $service_name parado com sucesso"
    else
        echo "ℹ️  $service_name não está rodando na porta $port"
    fi
}

# Parar backend (porta 3000)
stop_by_port 3000 "Backend (Next.js)"

# Parar frontend (porta 3001)
stop_by_port 3001 "Frontend (React)"

# Parar processos Node.js relacionados ao projeto
echo ""
echo "🔍 Verificando processos Node.js relacionados..."

# Encontrar processos npm/node relacionados ao projeto
backend_pids=$(ps aux | grep -E "(npm.*dev|next.*dev)" | grep -v grep | awk '{print $2}')
frontend_pids=$(ps aux | grep -E "(npm.*dev|vite)" | grep -v grep | awk '{print $2}')

if [ -n "$backend_pids" ]; then
    echo "🔍 Encontrados processos de desenvolvimento do backend: $backend_pids"
    echo "$backend_pids" | xargs kill 2>/dev/null
    echo "✅ Processos do backend parados"
fi

if [ -n "$frontend_pids" ]; then
    echo "🔍 Encontrados processos de desenvolvimento do frontend: $frontend_pids"
    echo "$frontend_pids" | xargs kill 2>/dev/null
    echo "✅ Processos do frontend parados"
fi

# Limpar arquivos de log se existirem
if [ -f "backend.log" ]; then
    echo "🗑️  Removendo backend.log"
    rm -f backend.log
fi

if [ -f "frontend.log" ]; then
    echo "🗑️  Removendo frontend.log"
    rm -f frontend.log
fi

echo ""
echo "✅ Sistema FAQ parado com sucesso!"
echo "============================="
echo "ℹ️  Para verificar se ainda há processos rodando:"
echo "   lsof -i :3000  # Backend"
echo "   lsof -i :3001  # Frontend"
echo ""
