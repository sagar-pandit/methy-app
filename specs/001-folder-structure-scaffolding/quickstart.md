# Quickstart: Methy Platform Local Development

**Feature**: 001-folder-structure-scaffolding
**Date**: 2026-05-01

This guide gets a developer from a fresh clone to a fully running local Methy stack.

---

## Prerequisites

Install all of the following before running any setup command:

| Tool | Version | Install Link |
|------|---------|-------------|
| Git | Latest | https://git-scm.com/downloads |
| .NET SDK | 10.0.x | https://dotnet.microsoft.com/download/dotnet/10.0 |
| Node.js | 20 LTS | https://nodejs.org/ (use `.nvmrc` with `nvm use`) |
| Angular CLI | 19.x | `npm install -g @angular/cli@19` |
| Docker Desktop | Latest | https://www.docker.com/products/docker-desktop |
| PowerShell | 7+ | https://github.com/PowerShell/PowerShell/releases |

**Docker Desktop RAM**: Allocate at least 8GB for core stack, 16GB for full observability stack.

**Verify prerequisites**:
```powershell
dotnet --version      # should print 10.0.x
node --version        # should print v20.x.x
ng version            # should show Angular CLI: 19.x
docker --version      # should print Docker version 24+
```

---

## One-Time Setup

Run the setup script from the repository root. This installs all dependencies and configures git hooks:

```powershell
.\scripts\setup.ps1
```

The script will:
1. Check all prerequisites are installed
2. Run `npm install` at the repository root (installs Husky, lint-staged, commitlint)
3. Run `dotnet restore` for the backend solution
4. Run `npm install` in `frontend/methy-app/`
5. Install Playwright browsers (`playwright install chromium`)
6. Initialize Husky git hooks

---

## Running the Core Stack

### Step 1: Start infrastructure and services

```powershell
cd infra/docker
docker compose up -d
```

Wait ~60 seconds for SQL Server and RabbitMQ to pass health checks:

```powershell
docker compose ps     # all services should show "healthy" or "running"
```

### Step 2: Verify services are healthy

```powershell
# Check each service health endpoint
curl http://localhost:5000/health   # Gateway
curl http://localhost:5001/health   # User
curl http://localhost:5002/health   # Restaurant
curl http://localhost:5003/health   # Order
curl http://localhost:5004/health   # Payment
curl http://localhost:5005/health   # Notification
curl http://localhost:5006/health   # Delivery
```

Each endpoint returns:
```json
{"status": "Healthy"}
```

### Step 3: Start the Angular frontend

```powershell
cd frontend/methy-app
ng serve
```

Open http://localhost:4200 in your browser.

---

## Running the Full Observability Stack

Requires 16GB Docker Desktop RAM:

```powershell
cd infra/docker
docker compose --profile observability up -d
```

| Tool | URL |
|------|-----|
| Grafana | http://localhost:3000 (admin/admin) |
| Prometheus | http://localhost:9090 |
| Jaeger | http://localhost:16686 |
| RabbitMQ Management | http://localhost:15672 (guest/guest) |

---

## Building the Backend

```powershell
cd backend
dotnet build Methy.sln
# Expected: Build succeeded. 0 Warning(s). 0 Error(s).

dotnet test
# Expected: All 8 test projects discovered and passing
```

---

## Building Docker Images

Each microservice image can be built individually (from the `backend/src/<ProjectName>/` directory):

```powershell
docker build -t methy-gateway:local backend/src/Methy.Gateway/
docker build -t methy-user:local backend/src/Methy.Services.User/
# ... repeat for each service
```

Or build all via Docker Compose (which uses the Dockerfiles):

```powershell
cd infra/docker
docker compose build
```

---

## Common Commands Reference

| Task | Command |
|------|---------|
| Build backend | `cd backend && dotnet build Methy.sln` |
| Run tests | `cd backend && dotnet test` |
| Start core stack | `cd infra/docker && docker compose up -d` |
| Start full stack | `cd infra/docker && docker compose --profile observability up -d` |
| Stop all containers | `cd infra/docker && docker compose down` |
| Start Angular dev server | `cd frontend/methy-app && ng serve` |
| Reset environment | `.\scripts\reset.ps1` |
| Seed local database | `.\scripts\seed-db.ps1` |
| Format .NET code | `cd backend && dotnet format Methy.sln` |

---

## Troubleshooting

### Docker Desktop is not running

**Symptom**: `docker compose up` fails with "Cannot connect to the Docker daemon"

**Fix**: Start Docker Desktop. Wait for the Docker icon in the system tray to show a running state, then retry.

---

### Port conflict (SQL Server 1433, RabbitMQ 5672, or service ports)

**Symptom**: `docker compose up` fails with "bind: address already in use"

**Fix**: Use the override file which maps alternate ports:
```powershell
cd infra/docker
docker compose -f docker-compose.yml -f docker-compose.override.yml up -d
```
Check `docker-compose.override.yml` for the alternate port mappings.

---

### .NET SDK version mismatch

**Symptom**: `dotnet build` fails with "The current .NET SDK does not support targeting .NET 10.0"

**Fix**: Install .NET 10 SDK from https://dotnet.microsoft.com/download/dotnet/10.0. The `global.json` at the repo root enforces the SDK version and will print a clear error.

---

### Angular CLI version mismatch

**Symptom**: `ng serve` warns "Your global Angular CLI version (X) is greater than your local version (Y)"

**Fix**: Use the local version pinned in `frontend/methy-app/package.json`:
```powershell
cd frontend/methy-app
npx ng serve
```

Or reinstall the matching global CLI version: `npm install -g @angular/cli@19`

---

### Node.js version mismatch

**Symptom**: `npm install` warns about unsupported engine version

**Fix**: Use nvm to switch to the pinned version:
```powershell
nvm use   # reads .nvmrc (Node 20)
```

---

## Port Reference

| Service | URL |
|---------|-----|
| Angular SPA | http://localhost:4200 |
| API Gateway | http://localhost:5000 |
| User Service | http://localhost:5001 |
| Restaurant Service | http://localhost:5002 |
| Order Service | http://localhost:5003 |
| Payment Service | http://localhost:5004 |
| Notification Service | http://localhost:5005 |
| Delivery Service | http://localhost:5006 |
| SQL Server | localhost:1433 |
| RabbitMQ AMQP | localhost:5672 |
| RabbitMQ Management | http://localhost:15672 |
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3000 |
| Jaeger | http://localhost:16686 |
