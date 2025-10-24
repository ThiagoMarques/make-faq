import { NextApiRequest, NextApiResponse } from 'next'
import fs from 'fs'
import path from 'path'

interface FAQItem {
  id: number
  question: string
  answer: string
  category: string
}

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  // Configurar CORS para Make
  res.setHeader('Access-Control-Allow-Origin', '*')
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
  res.setHeader('Content-Type', 'application/json')

  // Responder a requisições OPTIONS (preflight)
  if (req.method === 'OPTIONS') {
    res.status(200).end()
    return
  }

  if (req.method === 'GET') {
    try {
      const filePath = path.join(process.cwd(), 'data', 'faq.json')
      const fileContents = fs.readFileSync(filePath, 'utf8')
      const faqData: FAQItem[] = JSON.parse(fileContents)
      
      // Resposta formatada para Make
      const response = {
        success: true,
        data: faqData,
        count: faqData.length,
        timestamp: new Date().toISOString()
      }
      
      res.status(200).json(response)
    } catch (error) {
      res.status(500).json({ 
        success: false,
        error: 'Erro ao carregar dados do FAQ',
        timestamp: new Date().toISOString()
      })
    }
  } else {
    res.setHeader('Allow', ['GET', 'OPTIONS'])
    res.status(405).json({ 
      success: false,
      error: `Método ${req.method} não permitido`,
      allowedMethods: ['GET', 'OPTIONS']
    })
  }
}
