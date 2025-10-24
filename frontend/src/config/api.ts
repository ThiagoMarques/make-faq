// Configuração da API
const isDevelopment = import.meta.env.DEV
const isProduction = import.meta.env.PROD

// URL da API baseada no ambiente
export const API_BASE_URL = isDevelopment 
  ? 'http://localhost:3000'  // Desenvolvimento local
  : 'https://faq-backend.vercel.app'  // Produção (substitua pela sua URL)

// Endpoint completo da API
export const FAQ_API_URL = `${API_BASE_URL}/api/faq`

// Configuração do Axios
export const API_CONFIG = {
  baseURL: API_BASE_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
}
