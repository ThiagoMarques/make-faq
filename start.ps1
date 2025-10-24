# Script PowerShell para iniciar o Sistema de FAQ
Write-Host "🚀 Iniciando Sistema de FAQ..." -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green

# Verificar se estamos no diretório correto
if (-not (Test-Path "backend") -or -not (Test-Path "frontend")) {
    Write-Host "❌ Erro: Execute este script na pasta raiz do projeto (faq-system)" -ForegroundColor Red
    exit 1
}

# Verificar se as portas estão livres
Write-Host "🔍 Verificando portas..." -ForegroundColor Yellow

$backendPort = Get-NetTCPConnection -LocalPort 3000 -ErrorAction SilentlyContinue
$frontendPort = Get-NetTCPConnection -LocalPort 3001 -ErrorAction SilentlyContinue

if ($backendPort) {
    Write-Host "❌ Porta 3000 (backend) está em uso. Pare o processo e tente novamente." -ForegroundColor Red
    exit 1
}

if ($frontendPort) {
    Write-Host "❌ Porta 3001 (frontend) está em uso. Pare o processo e tente novamente." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Portas 3000 e 3001 estão livres" -ForegroundColor Green

# Verificar dependências
Write-Host "📦 Verificando dependências..." -ForegroundColor Yellow

if (-not (Test-Path "backend/node_modules")) {
    Write-Host "📥 Instalando dependências do backend..." -ForegroundColor Yellow
    Set-Location backend
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Erro ao instalar dependências do backend" -ForegroundColor Red
        exit 1
    }
    Set-Location ..
}

if (-not (Test-Path "frontend/node_modules")) {
    Write-Host "📥 Instalando dependências do frontend..." -ForegroundColor Yellow
    Set-Location frontend
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Erro ao instalar dependências do frontend" -ForegroundColor Red
        exit 1
    }
    Set-Location ..
}

Write-Host "✅ Dependências verificadas" -ForegroundColor Green

Write-Host ""
Write-Host "🚀 Iniciando servidores..." -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green

# Iniciar backend
Write-Host "🔧 Iniciando Backend (Next.js) na porta 3000..." -ForegroundColor Cyan
Set-Location backend
Start-Process -FilePath "npm" -ArgumentList "run", "dev" -WindowStyle Hidden
Set-Location ..

# Aguardar backend inicializar
Start-Sleep -Seconds 3

# Iniciar frontend
Write-Host "🎨 Iniciando Frontend (React) na porta 3001..." -ForegroundColor Cyan
Set-Location frontend
Start-Process -FilePath "npm" -ArgumentList "run", "dev" -WindowStyle Hidden
Set-Location ..

# Aguardar frontend inicializar
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "🎉 Sistema FAQ iniciado com sucesso!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host "📡 Backend API:  http://localhost:3000/api/faq" -ForegroundColor White
Write-Host "🎨 Frontend:     http://localhost:3001" -ForegroundColor White
Write-Host ""
Write-Host "⏹️  Para parar os servidores, feche as janelas do terminal" -ForegroundColor Yellow
Write-Host ""

# Manter o script rodando
Write-Host "Pressione qualquer tecla para parar..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
