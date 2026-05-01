# Methy — Food Delivery Platform

A microservices-based food delivery platform built with .NET 10, Angular 21, and Docker.

---

## Overview

Methy is a full-stack food delivery application consisting of:

- **7 ASP.NET Core microservices** — Gateway, User, Restaurant, Order, Payment, Notification, Delivery
- **Angular 21 SPA** — standalone components, Material 3 design system, SCSS, ESLint
- **SQL Server 2022** — per-service databases (logical separation, shared container in dev)
- **RabbitMQ** — async event bus for inter-service communication
- **Docker Compose V2** — single-command local environment

---

## Prerequisites

| Tool           | Minimum Version | Install                                                           |
| -------------- | --------------- | ----------------------------------------------------------------- |
| .NET SDK       | 10.0.100        | [dot.net](https://dotnet.microsoft.com/download)                  |
| Node.js        | 20.x LTS        | [nodejs.org](https://nodejs.org/)                                 |
| Angular CLI    | 21.x            | `npm install -g @angular/cli@21`                                  |
| Docker Desktop | 4.x             | [docker.com](https://www.docker.com/products/docker-desktop)      |
| PowerShell     | 7.x             | [github.com/PowerShell](https://github.com/PowerShell/PowerShell) |

---

## Quick Start

### 1. Clone and set up

```bash
git clone https://github.com/sagar-pandit/methy-app.git
cd methy-app
./scripts/setup.ps1
```

### 2. Configure environment variables

```bash
cp .env.example .env
# Edit .env and set SA_PASSWORD and RABBITMQ credentials
```

### 3. Start all services

```bash
cd infra/docker
docker compose up --build
```

### 4. Start the frontend

```bash
cd frontend/methy-app
ng serve
# Open http://localhost:4200
```

### 5. Run backend tests

```bash
dotnet test backend/Methy.slnx
```

---

## Service Ports

| Service              | Host Port | Path                     |
| -------------------- | --------- | ------------------------ |
| API Gateway          | 5000      | `http://localhost:5000`  |
| User Service         | 5001      | `http://localhost:5001`  |
| Restaurant Service   | 5002      | `http://localhost:5002`  |
| Order Service        | 5003      | `http://localhost:5003`  |
| Payment Service      | 5004      | `http://localhost:5004`  |
| Notification Service | 5005      | `http://localhost:5005`  |
| Delivery Service     | 5006      | `http://localhost:5006`  |
| Angular SPA          | 4200      | `http://localhost:4200`  |
| SQL Server           | 1433      | —                        |
| RabbitMQ AMQP        | 5672      | —                        |
| RabbitMQ Management  | 15672     | `http://localhost:15672` |

---

## Folder Structure

```text
methy/
├── backend/                  # .NET solution — 7 services + 1 shared lib + 8 test projects
│   ├── src/
│   │   ├── Methy.Gateway/
│   │   ├── Methy.Services.User/
│   │   ├── Methy.Services.Restaurant/
│   │   ├── Methy.Services.Order/
│   │   ├── Methy.Services.Payment/
│   │   ├── Methy.Services.Notification/
│   │   ├── Methy.Services.Delivery/
│   │   └── Methy.Shared/      # Shared class library (DTOs, constants, helpers)
│   └── tests/                 # XUnit test projects (1 per service)
├── frontend/
│   └── methy-app/             # Angular 21 SPA (standalone, Material 3)
│       └── src/app/
│           ├── core/           # Auth interceptor, guards, services
│           ├── shared/         # Standalone shared components, directives, pipes
│           └── features/       # Feature modules: restaurants, orders, delivery, admin, profile
├── e2e/                       # Playwright .NET end-to-end tests (standalone project)
├── infra/
│   ├── docker/                # Docker Compose V2 + override + RabbitMQ definitions + SQL init
│   ├── k8s/                   # Kubernetes manifests (namespace, deployments, services, ingress)
│   └── observability/         # Prometheus, Grafana, Jaeger configs
├── api/                       # OpenAPI 3.0 YAML stubs (one per service)
├── docs/                      # Architecture docs, ADRs
├── scripts/                   # setup.ps1, seed-db.ps1, reset.ps1
├── specs/                     # Speckit feature specs, plans, and tasks
├── .github/                   # GitHub Actions workflows, PR template, Dependabot
├── .husky/                    # Git hooks (pre-commit, commit-msg)
└── README.md
```

---

## Troubleshooting

### SQL Server won't start

Ensure Docker Desktop has at least 2 GB RAM allocated. The SA_PASSWORD must meet SQL Server complexity requirements (uppercase, lowercase, digit, special char, 8+ chars).

### `ng add @angular/material` fails

Run `npm install` in `frontend/methy-app/` first. Ensure you are on Node.js 20.x.

### `dotnet build` fails with version errors

Run `dotnet --version` and verify it shows `10.0.x`. Check `global.json` at the repo root.

### Port conflicts

Stop other services using the ports listed above, or edit the host-side ports in `infra/docker/docker-compose.yml`.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for branch naming, commit message conventions, and PR workflow.

---

## License

MIT — see [LICENSE](LICENSE).
