# Script PowerShell para parar o Sistema de FAQ
Write-Host "🛑 Parando Sistema de FAQ..." -ForegroundColor Red
Write-Host "=============================" -ForegroundColor Red

# Função para parar processos por porta
function Stop-ByPort {
    param(
        [int]$Port,
        [string]$ServiceName
    )
    
    try {
        $connections = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue
        
        if ($connections) {
            $pids = $connections | Select-Object -ExpandProperty OwningProcess | Sort-Object -Unique
            
            foreach ($pid in $pids) {
                $process = Get-Process -Id $pid -ErrorAction SilentlyContinue
                if ($process) {
                    Write-Host "🔍 Encontrado $ServiceName rodando na porta $Port (PID: $pid)" -ForegroundColor Yellow
                    Write-Host "⏹️  Parando $ServiceName..." -ForegroundColor Yellow
                    
                    try {
                        Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue
                        Write-Host "✅ $ServiceName parado com sucesso" -ForegroundColor Green
                    } catch {
                        Write-Host "⚠️  Erro ao parar $ServiceName" -ForegroundColor Red
                    }
                }
            }
        } else {
            Write-Host "ℹ️  $ServiceName não está rodando na porta $Port" -ForegroundColor Blue
        }
    } catch {
        Write-Host "ℹ️  $ServiceName não está rodando na porta $Port" -ForegroundColor Blue
    }
}

# Parar backend (porta 3000)
Stop-ByPort -Port 3000 -ServiceName "Backend (Next.js)"

# Parar frontend (porta 3001)
Stop-ByPort -Port 3001 -ServiceName "Frontend (React)"

# Parar processos Node.js relacionados ao projeto
Write-Host ""
Write-Host "🔍 Verificando processos Node.js relacionados..." -ForegroundColor Yellow

# Encontrar e parar processos npm/node relacionados
$nodeProcesses = Get-Process | Where-Object { 
    $_.ProcessName -eq "node" -or $_.ProcessName -eq "npm" 
} | Where-Object {
    $_.CommandLine -like "*dev*" -or $_.CommandLine -like "*next*" -or $_.CommandLine -like "*vite*"
}

if ($nodeProcesses) {
    Write-Host "🔍 Encontrados processos de desenvolvimento:" -ForegroundColor Yellow
    foreach ($process in $nodeProcesses) {
        Write-Host "   PID: $($process.Id) - $($process.ProcessName)" -ForegroundColor Yellow
        try {
            Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
            Write-Host "✅ Processo $($process.Id) parado" -ForegroundColor Green
        } catch {
            Write-Host "⚠️  Erro ao parar processo $($process.Id)" -ForegroundColor Red
        }
    }
} else {
    Write-Host "ℹ️  Nenhum processo de desenvolvimento encontrado" -ForegroundColor Blue
}

# Limpar arquivos de log se existirem
if (Test-Path "backend.log") {
    Write-Host "🗑️  Removendo backend.log" -ForegroundColor Yellow
    Remove-Item "backend.log" -Force
}

if (Test-Path "frontend.log") {
    Write-Host "🗑️  Removendo frontend.log" -ForegroundColor Yellow
    Remove-Item "frontend.log" -Force
}

Write-Host ""
Write-Host "✅ Sistema FAQ parado com sucesso!" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green
Write-Host "ℹ️  Para verificar se ainda há processos rodando:" -ForegroundColor Blue
Write-Host "   Get-NetTCPConnection -LocalPort 3000  # Backend" -ForegroundColor Gray
Write-Host "   Get-NetTCPConnection -LocalPort 3001  # Frontend" -ForegroundColor Gray
Write-Host ""
