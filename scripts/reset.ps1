#!/usr/bin/env pwsh
# scripts/reset.ps1
# Purpose : Tears down and re-initialises the local development environment.
#           Stops containers, removes volumes, re-applies migrations, re-seeds data.
# Usage   : ./scripts/reset.ps1 [--skip-seed]
# WARNING : This destroys all local database data. Do not run against production.

param(
  [switch]$SkipSeed
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Step([string]$Message) {
  Write-Host "`n==> $Message" -ForegroundColor Cyan
}

# ─── Confirm intent ────────────────────────────────────────────────────────
Write-Host '[WARNING] This will delete all local database volumes and data.' -ForegroundColor Yellow
$confirm = Read-Host 'Type YES to continue'
if ($confirm -ne 'YES') {
  Write-Host 'Reset cancelled.' -ForegroundColor Gray
  exit 0
}

# ─── Stop containers and remove volumes ────────────────────────────────────
Write-Step 'Stopping Docker Compose services and removing volumes'
Set-Location infra/docker
docker compose down --volumes --remove-orphans
Set-Location ../..

# ─── Rebuild and restart ───────────────────────────────────────────────────
Write-Step 'Rebuilding and starting core services'
Set-Location infra/docker
docker compose up -d --build sql-server rabbitmq
Set-Location ../..

# ─── Wait for SQL Server to be ready ───────────────────────────────────────
Write-Step 'Waiting for SQL Server to be healthy...'
$retries = 30
while ($retries -gt 0) {
  $status = docker inspect --format='{{.State.Health.Status}}' (docker compose -f infra/docker/docker-compose.yml ps -q sql-server) 2>$null
  if ($status -eq 'healthy') { break }
  Start-Sleep -Seconds 2
  $retries--
}

# ─── Seed (optional) ───────────────────────────────────────────────────────
if (-not $SkipSeed) {
  Write-Step 'Seeding database'
  ./scripts/seed-db.ps1
}

Write-Host "`n[DONE] Environment reset complete." -ForegroundColor Green
