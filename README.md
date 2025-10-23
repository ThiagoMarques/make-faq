# Sistema de FAQ

Um sistema completo de FAQ (Frequently Asked Questions) construído com Next.js para o backend e React com Tailwind CSS para o frontend.

## 📁 Estrutura do Projeto

```
faq-system/
│
├── backend/                # Next.js (API)
│   ├── pages/api/faq.ts   # Endpoint da API
│   ├── data/faq.json      # Dados do FAQ
│   ├── package.json       # Dependências do backend
│   └── next.config.js     # Configuração do Next.js
│
├── frontend/               # React + Tailwind
│   ├── src/
│   │   ├── components/
│   │   │   └── FaqList.tsx # Componente principal
│   │   ├── App.tsx         # Componente raiz
│   │   ├── main.tsx        # Ponto de entrada
│   │   └── index.css       # Estilos globais
│   ├── package.json        # Dependências do frontend
│   ├── vite.config.ts      # Configuração do Vite
│   ├── tailwind.config.js  # Configuração do Tailwind
│   └── tsconfig.json       # Configuração do TypeScript
│
└── README.md
```

## 🚀 Funcionalidades

### Backend (Next.js API)
- ✅ API REST para gerenciar FAQs
- ✅ Endpoint GET `/api/faq` para listar FAQs
- ✅ Endpoint POST `/api/faq` para adicionar novos FAQs
- ✅ CORS configurado para comunicação com frontend
- ✅ Dados armazenados em JSON

### Frontend (React + Tailwind)
- ✅ Interface responsiva e moderna
- ✅ Lista de FAQs com busca e filtros
- ✅ Filtro por categoria
- ✅ Busca por texto (pergunta e resposta)
- ✅ Accordion para expandir/recolher respostas
- ✅ Loading states e tratamento de erros
- ✅ Design responsivo

## 🛠️ Instalação e Execução

### Pré-requisitos
- Node.js (versão 16 ou superior)
- npm ou yarn

### 1. Instalar dependências do Backend

```bash
cd backend
npm install
```

### 2. Instalar dependências do Frontend

```bash
cd frontend
npm install
```

### 3. Executar o Backend

```bash
cd backend
npm run dev
```

O backend estará disponível em: `http://localhost:3000`

### 4. Executar o Frontend

```bash
cd frontend
npm run dev
```

O frontend estará disponível em: `http://localhost:3001`

## 📡 API Endpoints

### GET /api/faq
Retorna todos os FAQs disponíveis.

**Resposta:**
```json
[
  {
    "id": 1,
    "question": "Como posso criar uma conta no sistema?",
    "answer": "Para criar uma conta, clique no botão 'Registrar'...",
    "category": "Conta"
  }
]
```

### POST /api/faq
Adiciona um novo FAQ ao sistema.

**Body:**
```json
{
  "question": "Nova pergunta?",
  "answer": "Nova resposta...",
  "category": "Categoria"
}
```

**Resposta:**
```json
{
  "id": 6,
  "question": "Nova pergunta?",
  "answer": "Nova resposta...",
  "category": "Categoria"
}
```

## 🎨 Tecnologias Utilizadas

### Backend
- **Next.js 14** - Framework React para API
- **TypeScript** - Tipagem estática
- **Node.js** - Runtime JavaScript

### Frontend
- **React 18** - Biblioteca para interface
- **TypeScript** - Tipagem estática
- **Tailwind CSS** - Framework CSS utilitário
- **Vite** - Build tool e dev server
- **Axios** - Cliente HTTP

## 🔧 Configurações

### CORS
O backend está configurado para aceitar requisições do frontend através de CORS headers.

### Proxy
O frontend está configurado com proxy para redirecionar requisições `/api` para o backend.

## 📝 Estrutura dos Dados

Cada FAQ possui a seguinte estrutura:

```typescript
interface FAQItem {
  id: number          // ID único
  question: string    // Pergunta
  answer: string      // Resposta
  category: string    // Categoria
}
```

## 🚀 Deploy

### Backend (Vercel/Netlify)
```bash
cd backend
npm run build
```

### Frontend (Vercel/Netlify)
```bash
cd frontend
npm run build
```

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
