import { NextApiRequest, NextApiResponse } from 'next'

export default function Home() {
  return (
    <div style={{ padding: '20px', fontFamily: 'Arial, sans-serif' }}>
      <h1>Sistema FAQ - Backend</h1>
      <p>API funcionando!</p>
      <p>Endpoint: <a href="/api/faq">/api/faq</a></p>
    </div>
  )
}
