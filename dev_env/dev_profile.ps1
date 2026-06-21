# ----------------------------------------------------
# Unified Developer Command CLI (dev)
# 
# Usage 1: dev commit "message"         (Adds, commits, and pushes to main)
# Usage 2: dev local <venv_name>        (Creates/Activates venv only)
# Usage 3: dev <venv_name>              (Creates/Activates venv + Opens VS Code)
# Usage 4: dev down                     (Deactivates venv and closes terminal)
# ----------------------------------------------------
function dev {
    param(
        [string]$arg1,
        [string]$arg2
    )

    # 1. The Git Commit & Push flow
    if ($arg1 -eq "commit") {
        if ([string]::IsNullOrWhiteSpace($arg2)) {
            Write-Host "Please provide a commit message. Example: dev commit `"your message`"" -ForegroundColor Yellow
        }
        else {
            Write-Host "Staging, committing, and pushing to origin main..." -ForegroundColor Cyan
            git add .
            git commit -m "$arg2"
            git push origin main
        }
    }
    # 2. The Local Environment Bootstrapper (Venv Only)
    elseif ($arg1 -eq "local" -and $arg2) {
        $venvName = $arg2
        $venvPath = ".\$venvName\Scripts\activate.ps1"
        
        # Check if venv folder exists, create if it doesn't
        if (-not (Test-Path ".\$venvName")) {
            Write-Host "Virtual environment '$venvName' not found. Creating it now (this takes a few seconds)..." -ForegroundColor Cyan
            python -m venv $venvName
        }

        if (Test-Path $venvPath) {
            Write-Host "Activating venv: $venvName" -ForegroundColor Green
            . $venvPath  
        }
        else {
            Write-Host "Failed to create or find virtual environment at $venvPath" -ForegroundColor Red
        }
    } 
    # 4. The Local Environment deactivate + terminal exit
    elseif ($arg1 -eq "down") {
        Write-Host "Fetching dev environment..." -ForegroundColor Cyan
        # get current directory and vscode instance
        $currentFolder = Split-Path -Leaf (Get-Location)
        $vscodeProcess = Get-Process -Name "Code" -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -match [regex]::Escape($currentFolder) }
        
        if ($vscodeProcess) {
            Write-Host "Closing VS Code..." -ForegroundColor Yellow
            $vscodeProcess.CloseMainWindow() | Out-Null
        }
        
        # check if a virtual environment is currently active
        if (Get-Command deactivate -ErrorAction SilentlyContinue) {
            Write-Host "Shutting down the dev environment..." -ForegroundColor Yellow
            deactivate
        }
        # Close the terminal window
        # exit
    }
    # 3. The Local Environment Bootstrapper (Venv + VS Code)
    elseif ($arg1) {
        $venvName = $arg1
        $venvPath = ".\$venvName\Scripts\activate.ps1"
        
        # Check if venv folder exists, create if it doesn't
        if (-not (Test-Path ".\$venvName")) {
            Write-Host "Virtual environment '$venvName' not found. Creating it now (this takes a few seconds)..." -ForegroundColor Cyan
            python -m venv $venvName
        }
        
        if (Test-Path $venvPath) {
            Write-Host "Activating venv: $venvName and launching VS Code..." -ForegroundColor Green
            . $venvPath
            code .
        }
        else {
            Write-Host "Failed to create or find virtual environment at $venvPath" -ForegroundColor Red
        }
    }
    # 5. Fallback for empty or invalid commands
    else {
        Write-Host "Invalid syntax. Available commands:" -ForegroundColor Yellow
        Write-Host "  dev <venv_name>         - Creates/Activates venv and opens VS Code"
        Write-Host "  dev local <venv_name>   - Creates/Activates venv only"
        Write-Host "  dev commit `"message`"    - Adds, commits, and pushes to origin main"
    }
}
