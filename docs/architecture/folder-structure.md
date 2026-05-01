# Methy Platform — Folder Structure

> Canonical reference for the scaffolded repository layout.
> Source of truth: [spec.md](../../specs/001-folder-structure-scaffolding/spec.md)

```
Methy/                                   ← repository root
├── .editorconfig
├── .env.example
├── .gitignore
├── .husky/
│   ├── pre-commit                       ← npx lint-staged
│   └── commit-msg                       ← npx commitlint --edit $1
├── .lintstagedrc.json                   ← lint-staged config
├── .nvmrc
├── .prettierrc                          ← formatting rules
├── .prettierignore
├── .vscode/
│   ├── extensions.json                  ← Recommended extensions
│   ├── settings.json                    ← formatOnSave, rulers, EOL
│   └── launch.json                      ← Debug configs (all services + Angular)
├── commitlint.config.js                 ← conventional commit rules
├── CONTRIBUTING.md
├── global.json
├── LICENSE                              ← MIT
├── package.json                         ← husky, lint-staged, commitlint (devDeps)
├── README.md
│
├── .github/
│   ├── PULL_REQUEST_TEMPLATE.md          ← PR checklist
│   ├── dependabot.yml                   ← Monthly dependency updates
│   └── workflows/
│       ├── build.yml                    ← .NET build + test
│       ├── docker.yml                   ← Docker image builds
│       └── deploy.yml                   ← Deployment (placeholder)
│
├── api/                                 ← Contract-first OpenAPI 3.0 stubs
│   ├── README.md
│   ├── gateway.openapi.yml
│   ├── user-service.openapi.yml
│   ├── restaurant-service.openapi.yml
│   ├── order-service.openapi.yml
│   ├── payment-service.openapi.yml
│   ├── notification-service.openapi.yml
│   └── delivery-service.openapi.yml
│
├── backend/                             ← .NET 10 solution
│   ├── Methy.slnx
│   ├── Directory.Build.props
│   ├── Directory.Packages.props
│   │
│   ├── src/
│   │   ├── Methy.Gateway/              ← API Gateway (port 5000)
│   │   │   ├── Methy.Gateway.csproj
│   │   │   ├── Program.cs
│   │   │   ├── Dockerfile
│   │   │   ├── .dockerignore
│   │   │   ├── appsettings.json
│   │   │   └── appsettings.Development.json
│   │   ├── Methy.Services.User/        ← User Service (port 5001)
│   │   │   └── (same structure as Gateway)
│   │   ├── Methy.Services.Restaurant/  ← Restaurant Service (port 5002)
│   │   │   └── (same structure as Gateway)
│   │   ├── Methy.Services.Order/       ← Order Service (port 5003)
│   │   │   └── (same structure as Gateway)
│   │   ├── Methy.Services.Payment/     ← Payment Service (port 5004)
│   │   │   └── (same structure as Gateway)
│   │   ├── Methy.Services.Notification/ ← Notification Service (port 5005)
│   │   │   └── (same structure as Gateway)
│   │   ├── Methy.Services.Delivery/    ← Delivery Service (port 5006)
│   │   │   └── (same structure as Gateway)
│   │   └── Methy.Shared/              ← Class library (no Dockerfile, no port)
│   │       ├── Methy.Shared.csproj
│   │       └── (shared models, extensions, constants)
│   │
│   └── tests/
│       ├── Methy.Gateway.Tests/
│       │   └── Methy.Gateway.Tests.csproj
│       ├── Methy.Services.User.Tests/
│       ├── Methy.Services.Restaurant.Tests/
│       ├── Methy.Services.Order.Tests/
│       ├── Methy.Services.Payment.Tests/
│       ├── Methy.Services.Notification.Tests/
│       ├── Methy.Services.Delivery.Tests/
│       └── Methy.Shared.Tests/
│
├── e2e/                                 ← Playwright E2E tests (.NET)
│   ├── Methy.E2E.csproj
│   ├── playwright.config.ts
│   ├── Tests/
│   │   ├── OrderFlowTests.cs
│   │   └── (test files per user journey)
│   └── PageObjects/
│       └── (page object models)
│
├── frontend/                            ← Angular 21 + Material Design 3
│   └── methy-app/
│       ├── angular.json
│       ├── package.json
│       ├── tsconfig.json
│       └── src/
│           ├── app/
│           │   ├── app.config.ts        ← Providers (standalone-first)
│           │   ├── app.routes.ts
│           │   ├── app.component.ts
│           │   ├── core/
│           │   │   ├── interceptors/    ← HttpInterceptorFn stubs
│           │   │   └── guards/          ← CanActivateFn stubs
│           │   ├── shared/              ← Standalone shared components
│           │   └── features/
│           │       ├── restaurants/
│           │       ├── orders/
│           │       ├── delivery/
│           │       ├── admin/
│           │       └── profile/
│           ├── environments/
│           │   ├── environment.ts
│           │   └── environment.development.ts
│           └── styles/
│               └── _theme.scss          ← M3 custom theme (Orange/Deep Purple)
│
├── infra/
│   ├── docker/
│   │   ├── docker-compose.yml           ← Core services (profileless = default)
│   │   ├── docker-compose.override.yml  ← Dev overrides (ports, volumes)
│   │   ├── rabbitmq/
│   │   │   └── definitions.json         ← vhost, exchange, queue stubs
│   │   └── sql/
│   │       └── init.sql                 ← CREATE DATABASE methy
│   │
│   ├── k8s/
│   │   ├── namespace.yaml               ← methy namespace
│   │   ├── deployments.yaml             ← Deployments for all services
│   │   ├── services.yaml                ← ClusterIP services for all services
│   │   └── ingress.yaml                 ← Nginx ingress → Gateway
│   │
│   └── observability/                   ← All under 'observability' compose profile
│       ├── prometheus/
│       │   └── prometheus.yml           ← Scrape configs for all services
│       ├── grafana/
│       │   └── provisioning/            ← Datasources, dashboard folders
│       └── jaeger/                      ← All-in-one config
│
├── postman/                             ← API testing collections
│   ├── methy-gateway.postman_collection.json
│   ├── methy-user.postman_collection.json
│   ├── methy-restaurant.postman_collection.json
│   ├── methy-order.postman_collection.json
│   ├── methy-payment.postman_collection.json
│   ├── methy-notification.postman_collection.json
│   ├── methy-delivery.postman_collection.json
│   └── methy-local.postman_environment.json
│
├── scripts/                             ← Dev automation (PowerShell)
│   ├── setup.ps1                        ← First-time environment setup
│   ├── seed-db.ps1                      ← Insert test/sample data
│   └── reset.ps1                        ← Nuke containers + rebuild
│
├── docs/
│   ├── architecture/                    ← ADRs, diagrams
│   │   └── README.md
│   ├── guides/                          ← Setup, contribution guides
│   │   └── README.md
│   ├── folder-structure.md              ← This file
│   └── product-vision.md
│
└── specs/                               ← Speckit feature specifications
    └── 001-folder-structure-scaffolding/
        ├── spec.md
        └── checklists/
            └── requirements.md
```

## Port Assignments

| Service               | Port  |
| --------------------- | ----- |
| Angular Dev Server    | 4200  |
| API Gateway           | 5000  |
| User Service          | 5001  |
| Restaurant Service    | 5002  |
| Order Service         | 5003  |
| Payment Service       | 5004  |
| Notification Service  | 5005  |
| Delivery Service      | 5006  |
| SQL Server            | 1433  |
| RabbitMQ (AMQP)       | 5672  |
| RabbitMQ (Management) | 15672 |
| Prometheus            | 9090  |
| Grafana               | 3000  |
| Jaeger UI             | 16686 |

## Quick Commands

```powershell
# Build all backend projects
cd backend && dotnet build Methy.slnx

# Run all tests
cd backend && dotnet test Methy.slnx

# Start core infrastructure (SQL Server, RabbitMQ, microservices)
cd infra/docker && docker compose up -d

# Start with observability stack
cd infra/docker && docker compose --profile observability up -d

# Start Angular dev server
cd frontend/methy-app && ng serve
```
