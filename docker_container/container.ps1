# Usage:
#   ctnr local up [--build] [-d]
#   ctnr local down
#   ctnr local logs [--tail=N]
#   ctnr local restart
#   ctnr prod up [--build] [-d]
#   ctnr prod down
#   ctnr prod logs [--tail=N]
#   ctnr prod restart

# container local up -> docker compose --env-file .env.local up --build
# container prod up -> docker compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env.prod up -d
function ctnr {
    # ctnr -> container
    param (
        [string]$arg1,
        [string]$arg2,
        [Parameter(ValueFromRemainingArguments)]
        [string[]]$flags
    )

    # check if docker-windows is running
    docker info >$null 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Docker is not running! Please start Docker Desktop first." -ForegroundColor Red
        return
    }
    # build compose base command per environment
    $composeBase = switch ($arg1) {
        "local" { "docker compose --env-file .env.local" }
        "prod" { "docker compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env.prod" }
        default { $null }
    }

    if (-not $composeBase) {
        Write-Host "Invalid syntax. Available commands:" -ForegroundColor Yellow
        Write-Host "  ctnr <local|prod> up [--build] [-d]"
        Write-Host "  ctnr <local|prod> down"
        Write-Host "  ctnr <local|prod> logs [--tail=N]"
        Write-Host "  ctnr <local|prod> restart"
        return
    }

    # parse optional flags
    $detached = $flags -contains "-d"
    $build = $flags -contains "--build"
    $tailFlag = $flags | Where-Object { $_ -match "^--tail=\d+$" } | Select-Object -First 1

    switch ($arg2) {
        "up" {
            Write-Host "Starting $arg1 Docker environment..." -ForegroundColor Cyan
            $cmd = "$composeBase up"
            if ($build) { $cmd += " --build" }
            if ($detached) { $cmd += " -d" }
            Invoke-Expression $cmd
        }
        "down" {
            Write-Host "Tearing down $arg1 Docker environment..." -ForegroundColor Yellow
            Invoke-Expression "$composeBase down"
        }
        "logs" {
            Write-Host "Tailing $arg1 logs (Ctrl+C to stop)..." -ForegroundColor Cyan
            $cmd = "$composeBase logs -f"
            if ($tailFlag) { $cmd += " $tailFlag" }
            Invoke-Expression $cmd
        }
        "restart" {
            Write-Host "Restarting $arg1 Docker environment..." -ForegroundColor Cyan
            Invoke-Expression "$composeBase restart"
        }
        default {
            if ([string]::IsNullOrWhiteSpace($arg2)) {
                Write-Host "Provide a command. Example: ctnr $arg1 up" -ForegroundColor Yellow
            }
            else {
                Write-Error "Invalid $arg1 command: $arg2"
            }
        }
    }
}
