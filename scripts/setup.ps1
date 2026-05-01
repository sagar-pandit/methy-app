#!/usr/bin/env pwsh
# scripts/setup.ps1
# Purpose : One-shot developer environment setup.
# Usage   : ./scripts/setup.ps1
#           Run from the repository root.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Step([string]$Message) {
  Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Assert-Command([string]$Name, [string]$MinVersion = '') {
  $cmd = Get-Command $Name -ErrorAction SilentlyContinue
  if (-not $cmd) {
    Write-Error "Required tool '$Name' is not installed or not on PATH."
    exit 1
  }
  Write-Host "  [OK] $Name found at $($cmd.Source)"
}

# ─── Prerequisite checks ───────────────────────────────────────────────────
Write-Step 'Checking prerequisites'

Assert-Command 'git'
Assert-Command 'dotnet'
Assert-Command 'node'
Assert-Command 'npm'
Assert-Command 'ng'
Assert-Command 'docker'

$dotnetVersion = (dotnet --version)
Write-Host "  [INFO] .NET SDK: $dotnetVersion"

$nodeVersion = (node --version)
Write-Host "  [INFO] Node.js: $nodeVersion"

# ─── npm install (root — Husky/Commitlint/lint-staged) ─────────────────────
Write-Step 'Installing root npm packages (Husky, Commitlint, lint-staged)'
npm install

# ─── Angular dependencies ──────────────────────────────────────────────────
Write-Step 'Installing Angular app dependencies'
Push-Location frontend/methy-app
npm install
Pop-Location

# ─── .NET restore ──────────────────────────────────────────────────────────
Write-Step 'Restoring .NET packages'
dotnet restore backend/Methy.slnx

# ─── Playwright browser install ────────────────────────────────────────────
Write-Step 'Installing Playwright Chromium browser'
dotnet tool update --global Microsoft.Playwright.CLI --ignore-failed-sources 2>$null
Set-Location e2e
dotnet build -c Release
pwsh bin/Release/net10.0/playwright.ps1 install chromium
Set-Location ..

Write-Host "`n[DONE] Development environment is ready." -ForegroundColor Green
Write-Host "       Run 'docker compose up --build' to start all services."
