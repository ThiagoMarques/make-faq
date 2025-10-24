#!/bin/bash

echo "⚡ Parando Sistema FAQ rapidamente..."

# Parar processos nas portas 3000 e 3001
lsof -ti:3000 | xargs kill -9 2>/dev/null
lsof -ti:3001 | xargs kill -9 2>/dev/null

# Parar processos npm/node relacionados
pkill -f "npm.*dev" 2>/dev/null
pkill -f "next.*dev" 2>/dev/null
pkill -f "vite" 2>/dev/null

echo "✅ Sistema parado!"
