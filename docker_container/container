# container local up -> docker compose --env-file .env.local up --build
# container prod up -> docker compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env.prod up -d
function ctnr {
    # ctnr -> container
    param (
        [string]$arg1,
        [string]$arg2,
        [string]$arg3
    )

    # check if docker-windows is running
    docker info >$null 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Docker is not running! Please start Docker Desktop first." -ForegroundColor Red
        return
    }

    # local environment
    if ($arg1 -eq "local") {
        if ([string]::IsNullOrWhiteSpace($arg2)) {
            Write-Host "Provide a command. Example: ctnr local up" -ForegroundColor Yellow
        }
        elseif ($arg2 -eq "up") {
            Write-Host "Starting Local Docker Environment..." -ForegroundColor Cyan
            if ($arg3 -eq "-d") {
                docker compose --env-file .env.local up --build -d
            }
            else {
                docker compose --env-file .env.local up --build
            }
        }
        elseif ($arg2 -eq "down") {
            Write-Host "Tearing down Local Docker Environment..." -ForegroundColor Yellow
            docker compose --env-file .env.local down
        }
        else {
            Write-Error "Invalid local command: $arg2"
        }
    }
    
    # production environment
    elseif ($arg1 -eq "prod") {
        if ([string]::IsNullOrWhiteSpace($arg2)) {
            Write-Host "Provide a command. Example: ctnr prod up" -ForegroundColor Yellow
        }
        elseif ($arg2 -eq "up") {
            Write-Host "Starting Production Docker Environment..." -ForegroundColor Cyan
            if ($arg3 -eq "-d") {
                docker compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env.prod up --build -d
            }
            else {
                docker compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env.prod up --build
            }
        }
        elseif ($arg2 -eq "down") {
            Write-Host "Tearing down Production Docker Environment..." -ForegroundColor Yellow
            docker compose --env-file .env.local down
        }
        else {
            Write-Error "Invalid local command: $arg2"
        }
    }
    else {
        Write-Host "Invalid syntax. Available commands:" -ForegroundColor Yellow
        Write-Host "  ctnr local up [-d]  - Starts the local environment"
        Write-Host "  ctnr local down     - Stops the local environment"
        Write-Host "  ctnr prod up [-d]   - Starts the production environment"
        Write-Host "  ctnr prod down      - Stops the production environment"
    }
}
