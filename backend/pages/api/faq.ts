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
  if (req.method === 'GET') {
    try {
      const filePath = path.join(process.cwd(), 'data', 'faq.json')
      const fileContents = fs.readFileSync(filePath, 'utf8')
      const faqData: FAQItem[] = JSON.parse(fileContents)
      
      res.status(200).json(faqData)
    } catch (error) {
      res.status(500).json({ error: 'Erro ao carregar dados do FAQ' })
    }
  } else if (req.method === 'POST') {
    try {
      const { question, answer, category } = req.body
      
      if (!question || !answer || !category) {
        return res.status(400).json({ error: 'Campos obrigatórios: question, answer, category' })
      }
      
      const filePath = path.join(process.cwd(), 'data', 'faq.json')
      const fileContents = fs.readFileSync(filePath, 'utf8')
      const faqData: FAQItem[] = JSON.parse(fileContents)
      
      const newItem: FAQItem = {
        id: Math.max(...faqData.map(item => item.id)) + 1,
        question,
        answer,
        category
      }
      
      faqData.push(newItem)
      
      fs.writeFileSync(filePath, JSON.stringify(faqData, null, 2))
      
      res.status(201).json(newItem)
    } catch (error) {
      res.status(500).json({ error: 'Erro ao adicionar item ao FAQ' })
    }
  } else {
    res.setHeader('Allow', ['GET', 'POST'])
    res.status(405).end(`Método ${req.method} não permitido`)
  }
}
