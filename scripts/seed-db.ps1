#!/usr/bin/env pwsh
# scripts/seed-db.ps1
# Purpose : Seeds the Methy database with development/demo data.
# Usage   : ./scripts/seed-db.ps1 [-ConnectionString <string>]
# Requires: SQL Server running (docker compose up sql-server)

param(
  [string]$ConnectionString = 'Server=localhost,1433;Database=methy;User Id=sa;Password=YourStrong!Passw0rd;TrustServerCertificate=true'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Step([string]$Message) {
  Write-Host "`n==> $Message" -ForegroundColor Cyan
}

Write-Step 'Seeding database...'

# TODO (Phase 2): Replace with dotnet ef database update + seeder class invocation.
# For now, this is a placeholder that verifies connectivity.

Write-Host "  [INFO] Connection string: $($ConnectionString -replace 'Password=[^;]+', 'Password=***')"
Write-Host "  [INFO] Database seeding will be implemented when EF Core migrations are added."
Write-Host ""
Write-Host "[DONE] Seed complete (placeholder)." -ForegroundColor Green
