# Implementation Plan: Folder Structure Scaffolding

**Branch**: `feature/001-folder-structure-scaffolding` | **Date**: 2026-05-01 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/001-folder-structure-scaffolding/spec.md`

## Summary

Scaffold the complete Methy food delivery platform monorepo: 16 .NET 10 projects (8 ASP.NET Core Web API + class library sources, 8 XUnit test projects), 1 Angular 19 workspace with Angular Material 3 theme, 7 multi-stage Dockerfiles, Docker Compose V2 stack (core + observability profiles), Kubernetes manifests, 3 GitHub Actions CI/CD workflows, and all supporting configuration files. No business logic — every service contains only a health check endpoint and placeholder configuration.

**Approach**: Use `dotnet new` CLI for .NET projects, Angular CLI for the frontend workspace, and hand-authored YAML/JSON for infra config. All 49 functional requirements are mapped to concrete files and commands in the tasks list.

## Technical Context

**Language/Version**: C# / .NET 10 LTS (backend); TypeScript / Angular 19 LTS (frontend)
**Primary Dependencies**: ASP.NET Core Web API, XUnit, Angular 19, Angular Material 3, Docker Compose V2, Kubernetes YAML, GitHub Actions, Husky, Commitlint, Playwright (.NET)
**Storage**: SQL Server 2022 Developer Edition (Docker container); ephemeral Docker volumes for local dev
**Testing**: XUnit (backend unit/integration), Playwright .NET (E2E, standalone project), Jasmine (Angular unit — default Angular CLI)
**Target Platform**: Windows 10/11 local development; ubuntu-latest GitHub Actions CI; Minikube (future K8s)
**Project Type**: Monorepo scaffolding — 1 Angular SPA + 7 ASP.NET Core Web API microservices + 1 .NET class library
**Performance Goals**: `dotnet build` < 30s; `docker compose up` (core) < 60s; full CI pipeline < 5 min; `docker compose --profile observability up` < 90s
**Constraints**: Zero secrets/credentials in VCS; multi-stage Docker images; 8GB Docker RAM for core stack, 16GB for full observability stack; all tooling local (no Azure)
**Scale/Scope**: 16 .NET projects, 7 Dockerfiles, 1 Angular workspace, 7 K8s deployments, 3 CI workflows, 7 OpenAPI stubs, 7 Postman collections

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-checked after Phase 1 design.*

| Principle | Status | Evidence |
|-----------|--------|----------|
| I. Learning First | ✅ PASS | Scaffold patterns are explicitly pedagogical: `Directory.Build.props`, health checks, Docker Compose profiles, observability setup teach real-world configuration skills |
| II. Simplicity & Clarity | ✅ PASS | `dotnet new` defaults used; Angular CLI defaults used; no custom abstractions; every folder name is explicit and maps 1:1 to its domain |
| III. Test-Driven Quality | ✅ PASS | 8 XUnit projects created alongside source (FR-003); CI builds and discovers all test projects on every push (FR-025); `dotnet test` succeeds from day one |
| IV. API-First Design | ✅ PASS | `api/` directory with OpenAPI 3.0 stubs per service created before any implementation (FR-033); `GET /health` defined in each stub |
| V. Security by Default | ✅ PASS | `.gitignore` excludes `.env.*`; `.env.example` documents all vars without real values (FR-029); Dependabot monitors all package ecosystems (FR-047); `.dockerignore` per service (FR-009) |
| VI. Observable Systems | ✅ PASS | `/health` endpoint on all 7 Web APIs (FR-007); Prometheus scrape config for all services (FR-022); Grafana + Jaeger in observability Docker Compose profile (FR-035) |
| VII. Local-First Development | ✅ PASS | 100% local infrastructure — Docker Desktop, SQL Server container, RabbitMQ container, Minikube; zero Azure dependencies (FR-010, FR-035) |

**Gate result**: All 7 principles pass. Proceeding to Phase 0.

## Project Structure

### Documentation (this feature)

```text
specs/001-folder-structure-scaffolding/
├── plan.md              ← This file (speckit.plan output)
├── research.md          ← Phase 0: confirmed technology decisions
├── data-model.md        ← Phase 1: repository entities and relationships
├── quickstart.md        ← Phase 1: developer setup guide
├── contracts/           ← Phase 1: OpenAPI 3.0 stubs (7 services)
│   ├── gateway.openapi.yml
│   ├── user-service.openapi.yml
│   ├── restaurant-service.openapi.yml
│   ├── order-service.openapi.yml
│   ├── payment-service.openapi.yml
│   ├── notification-service.openapi.yml
│   └── delivery-service.openapi.yml
└── tasks.md             ← Phase 2 (speckit.tasks — not created here)
```

### Source Code (repository root)

```text
Methy/                                   ← repository root
├── .editorconfig                        ← FR-034
├── .env.example                         ← FR-029
├── .gitignore                           ← FR-028
├── .husky/                              ← FR-042
│   ├── pre-commit
│   └── commit-msg
├── .lintstagedrc.json                   ← FR-042
├── .nvmrc                               ← FR-038
├── .prettierrc                          ← FR-044
├── .prettierignore                      ← FR-044
├── .vscode/                             ← FR-048
│   ├── extensions.json
│   ├── settings.json
│   └── launch.json
├── commitlint.config.js                 ← FR-042
├── CONTRIBUTING.md                      ← FR-039
├── global.json                          ← FR-030
├── LICENSE                              ← FR-049
├── package.json                         ← FR-042 (husky, lint-staged, commitlint)
├── README.md                            ← FR-031
│
├── .github/
│   ├── PULL_REQUEST_TEMPLATE.md         ← FR-046
│   ├── dependabot.yml                   ← FR-047
│   └── workflows/
│       ├── build.yml                    ← FR-025
│       ├── docker.yml                   ← FR-026
│       └── deploy.yml                   ← FR-027
│
├── api/                                 ← FR-033
│   ├── README.md
│   ├── gateway.openapi.yml
│   ├── user-service.openapi.yml
│   ├── restaurant-service.openapi.yml
│   ├── order-service.openapi.yml
│   ├── payment-service.openapi.yml
│   ├── notification-service.openapi.yml
│   └── delivery-service.openapi.yml
│
├── backend/
│   ├── Methy.sln                        ← FR-001
│   ├── Directory.Build.props            ← FR-005
│   ├── Directory.Packages.props         ← FR-006
│   ├── src/
│   │   ├── Methy.Gateway/               ← port 5000 (FR-002, FR-007, FR-008, FR-009)
│   │   ├── Methy.Services.User/         ← port 5001
│   │   ├── Methy.Services.Restaurant/   ← port 5002
│   │   ├── Methy.Services.Order/        ← port 5003
│   │   ├── Methy.Services.Payment/      ← port 5004
│   │   ├── Methy.Services.Notification/ ← port 5005
│   │   ├── Methy.Services.Delivery/     ← port 5006
│   │   └── Methy.Shared/                ← class library, no port (FR-004)
│   └── tests/
│       ├── Methy.Gateway.Tests/
│       ├── Methy.Services.User.Tests/
│       ├── Methy.Services.Restaurant.Tests/
│       ├── Methy.Services.Order.Tests/
│       ├── Methy.Services.Payment.Tests/
│       ├── Methy.Services.Notification.Tests/
│       ├── Methy.Services.Delivery.Tests/
│       └── Methy.Shared.Tests/
│
├── e2e/                                 ← FR-041 (standalone, NOT in Methy.sln)
│   ├── Methy.E2E.csproj
│   ├── playwright.config.ts
│   ├── Tests/
│   └── PageObjects/
│
├── frontend/
│   └── methy-app/                       ← FR-013 Angular 19 workspace
│       ├── angular.json
│       ├── package.json
│       ├── tsconfig.json
│       └── src/
│           ├── app/
│           │   ├── app.config.ts        ← FR-015
│           │   ├── app.routes.ts
│           │   ├── app.component.ts
│           │   ├── core/
│           │   │   ├── interceptors/    ← FR-015 (HttpInterceptorFn stub)
│           │   │   └── guards/          ← FR-015 (CanActivateFn/CanMatchFn stubs)
│           │   ├── shared/              ← standalone components
│           │   └── features/            ← FR-016
│           │       ├── restaurants/
│           │       ├── orders/
│           │       ├── delivery/
│           │       ├── admin/
│           │       └── profile/
│           ├── environments/            ← FR-017
│           └── styles/
│               └── _theme.scss          ← FR-014 (Orange + Deep Purple M3 theme)
│
├── infra/
│   ├── docker/
│   │   ├── docker-compose.yml           ← FR-010, FR-035, FR-040
│   │   ├── docker-compose.override.yml  ← FR-012
│   │   ├── rabbitmq/
│   │   │   └── definitions.json         ← FR-036
│   │   └── sql/
│   │       └── init.sql                 ← FR-037
│   ├── k8s/
│   │   ├── namespace.yml                ← FR-018
│   │   ├── deployments/                 ← FR-019
│   │   ├── services/                    ← FR-020
│   │   └── ingress/                     ← FR-021
│   └── observability/
│       ├── prometheus/
│       │   └── prometheus.yml           ← FR-022
│       ├── grafana/                     ← FR-023
│       └── jaeger/                      ← FR-024
│
├── postman/                             ← FR-043
│   ├── gateway.postman_collection.json
│   ├── [6 more service collections]
│   └── methy-local.postman_environment.json
│
├── scripts/                             ← FR-045
│   ├── setup.ps1
│   ├── seed-db.ps1
│   └── reset.ps1
│
└── docs/
    ├── architecture/                    ← FR-033
    ├── guides/                          ← FR-033
    └── product-vision.md
```

**Structure Decision**: Monorepo layout chosen to co-locate all platform components. Backend under `backend/`, frontend under `frontend/`, infrastructure under `infra/`, contracts under `api/`. This mirrors the constitution's technology stack and enables a single `git clone` → full environment workflow.

## Port Assignment Reference

| Service | Project | Port |
|---------|---------|------|
| API Gateway | `Methy.Gateway` | 5000 |
| User Service | `Methy.Services.User` | 5001 |
| Restaurant Service | `Methy.Services.Restaurant` | 5002 |
| Order Service | `Methy.Services.Order` | 5003 |
| Payment Service | `Methy.Services.Payment` | 5004 |
| Notification Service | `Methy.Services.Notification` | 5005 |
| Delivery Service | `Methy.Services.Delivery` | 5006 |
| Shared Library | `Methy.Shared` | N/A |
| Prometheus | — | 9090 |
| Grafana | — | 3000 |
| Jaeger | — | 16686 |
| SQL Server | — | 1433 |
| RabbitMQ AMQP | — | 5672 |
| RabbitMQ Management | — | 15672 |
| Angular Dev Server | — | 4200 |
