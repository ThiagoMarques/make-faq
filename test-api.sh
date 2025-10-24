#!/bin/bash

echo "🧪 Testando API do Sistema FAQ"
echo "=============================="

# URL da API
API_URL="https://backend-o0me7dtsj-thiago-marques-projects-be57c58d.vercel.app/api/faq"

echo "🔗 URL da API: $API_URL"
echo ""

# Teste 1: GET - Listar todos os FAQs
echo "📋 Teste 1: GET - Listar todos os FAQs"
echo "--------------------------------------"
curl -s -X GET "$API_URL" | jq '.' 2>/dev/null || curl -s -X GET "$API_URL"
echo ""
echo ""

# Teste 2: GET - Verificar status da API
echo "📊 Teste 2: Verificar status da API"
echo "-----------------------------------"
curl -s -I "$API_URL" | head -5
echo ""

# Teste 3: POST - Adicionar novo FAQ (se suportado)
echo "➕ Teste 3: POST - Adicionar novo FAQ"
echo "-------------------------------------"
curl -s -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "Como testar a API?",
    "answer": "Use este script ou o Postman para testar os endpoints.",
    "category": "Teste"
  }' | jq '.' 2>/dev/null || echo "Resposta: $(curl -s -X POST "$API_URL" -H "Content-Type: application/json" -d '{"question":"Como testar a API?","answer":"Use este script ou o Postman para testar os endpoints.","category":"Teste"}')"
echo ""

echo "✅ Testes concluídos!"
echo "💡 Para usar o Postman:"
echo "   1. Abra o Postman"
echo "   2. Crie uma nova requisição GET"
echo "   3. URL: $API_URL"
echo "   4. Clique em Send"
