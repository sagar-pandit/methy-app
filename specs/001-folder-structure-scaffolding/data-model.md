# Data Model: Folder Structure Scaffolding

**Feature**: 001-folder-structure-scaffolding
**Date**: 2026-05-01
**Source**: Extracted from `spec.md` Key Entities section + FR requirements

This document describes the repository-level entities, their relationships, and the rules governing their structure. There is no database schema at this phase — entities map to file-system artifacts.

---

## Entities

### 1. Solution

The top-level .NET build artifact that references all backend projects.

| Field | Value |
|-------|-------|
| File | `backend/Methy.sln` |
| Format | MSBuild Solution (`.sln`) |
| Solution folders | `src` (8 projects), `tests` (8 projects) |
| Build command | `dotnet build Methy.sln` from `backend/` |
| Test command | `dotnet test` from `backend/` |

**Invariants**:
- Contains exactly 16 projects: 8 source + 8 test
- Solution folders named `src` and `tests` (not physical directories — logical groupings in IDE)
- `global.json` at repo root pins SDK version; applies to all `dotnet` commands in the repo

---

### 2. Microservice Project

An ASP.NET Core Web API project representing one bounded domain context.

| Field | Value |
|-------|-------|
| Framework | ASP.NET Core Web API, .NET 10 |
| Project type | `webapi` (`dotnet new webapi`) |
| Count | 7 (Gateway + 6 domain services) |
| Physical path | `backend/src/<ProjectName>/` |

**Per-service file inventory**:
```
<ProjectName>/
├── <ProjectName>.csproj    ← project file; references Methy.Shared
├── Program.cs              ← minimal API setup + health check (FR-007)
├── Dockerfile              ← multi-stage build (FR-009)
├── .dockerignore           ← FR-009
├── appsettings.json        ← ConnectionStrings, Logging, RabbitMQ placeholders (FR-008)
└── appsettings.Development.json  ← dev overrides with port assignments (FR-008, FR-032)
```

**Port assignments** (fixed, FR-032):

| Project | Port |
|---------|------|
| `Methy.Gateway` | 5000 |
| `Methy.Services.User` | 5001 |
| `Methy.Services.Restaurant` | 5002 |
| `Methy.Services.Order` | 5003 |
| `Methy.Services.Payment` | 5004 |
| `Methy.Services.Notification` | 5005 |
| `Methy.Services.Delivery` | 5006 |

**Invariants**:
- All 7 projects reference `Methy.Shared` via `<ProjectReference>`
- All 7 projects have a `GET /health` endpoint returning HTTP 200 `{"status": "Healthy"}`
- All 7 projects have a corresponding Dockerfile and `.dockerignore`
- `appsettings.json` and `appsettings.Development.json` must exist with placeholder sections for `ConnectionStrings`, `Logging`, and `RabbitMQ`

---

### 3. Shared Library

A .NET class library shared by all service projects.

| Field | Value |
|-------|-------|
| Project name | `Methy.Shared` |
| Framework | .NET 10 class library |
| Project type | `classlib` (`dotnet new classlib`) |
| Physical path | `backend/src/Methy.Shared/` |

**Contents** (scaffold-level):
- Empty placeholder files establishing namespace convention
- Will hold: shared models, extension methods, constants, DTOs in future phases

**Invariants**:
- Is a class library — NOT a Web API project
- Has NO Dockerfile (not deployable as a container)
- Has NO port assignment
- Is referenced by all 7 Microservice Projects

---

### 4. Test Project

An XUnit project co-located (logically) with its source project, discovering and running unit/integration tests.

| Field | Value |
|-------|-------|
| Framework | XUnit, .NET 10 |
| Project type | `xunit` (`dotnet new xunit`) |
| Count | 8 (one per source project, including Shared) |
| Physical path | `backend/tests/<SourceProjectName>.Tests/` |

**Naming convention**: `<SourceProjectName>.Tests`
- `Methy.Gateway` → `Methy.Gateway.Tests`
- `Methy.Services.User` → `Methy.Services.User.Tests`
- `Methy.Shared` → `Methy.Shared.Tests`

**Per-project file inventory**:
```
<ProjectName>.Tests/
├── <ProjectName>.Tests.csproj  ← references source project + xunit packages
└── UnitTest1.cs                ← default placeholder test class
```

**Invariants**:
- Each test project references its corresponding source project via `<ProjectReference>`
- All 8 test projects are included in `Methy.sln` under the `tests` solution folder
- `dotnet test` from `backend/` discovers and runs all 8 test projects (even if empty)

---

### 5. E2E Test Project

A standalone .NET + Playwright project for browser-based end-to-end testing.

| Field | Value |
|-------|-------|
| Project name | `Methy.E2E` |
| Framework | XUnit + Microsoft.Playwright, .NET 10 |
| Physical path | `e2e/Methy.E2E.csproj` |
| Relationship to solution | **NOT in `Methy.sln`** — runs independently |

**Structure**:
```
e2e/
├── Methy.E2E.csproj
├── playwright.config.ts       ← browser configuration
├── Tests/
│   └── OrderFlowTests.cs      ← placeholder test per user journey
└── PageObjects/               ← page object model classes
```

**Invariants**:
- NOT referenced by `Methy.sln`
- Requires full running stack (`docker compose up`) before execution
- `playwright.config.ts` configures Chromium as the default browser

---

### 6. Angular Workspace

The Angular CLI workspace containing the Methy frontend application.

| Field | Value |
|-------|-------|
| Angular version | 19 LTS |
| Angular Material | 3 (MDC-based) |
| Architecture | Standalone-first (no NgModules) |
| Physical path | `frontend/methy-app/` |
| Dev server port | 4200 |

**Key files**:
```
frontend/methy-app/
├── angular.json              ← workspace config
├── package.json              ← Angular + Material + dev dependencies
├── tsconfig.json             ← TypeScript strict mode
└── src/
    ├── app/
    │   ├── app.config.ts     ← ApplicationConfig with provideRouter, provideHttpClient
    │   ├── app.routes.ts     ← Routes array
    │   ├── app.component.ts  ← root standalone component
    │   ├── core/
    │   │   ├── interceptors/
    │   │   │   └── auth.interceptor.ts   ← HttpInterceptorFn stub
    │   │   └── guards/
    │   │       └── auth.guard.ts         ← CanActivateFn/CanMatchFn stubs
    │   ├── shared/           ← standalone shared Material components
    │   └── features/
    │       ├── restaurants/README.md     ← "Handles restaurant browsing..."
    │       ├── orders/README.md          ← "Handles order placement..."
    │       ├── delivery/README.md        ← "Handles delivery tracking..."
    │       ├── admin/README.md           ← "Handles admin operations..."
    │       └── profile/README.md         ← "Handles user profiles..."
    ├── environments/
    │   ├── environment.ts                ← production (placeholder API URL)
    │   └── environment.development.ts   ← development (http://localhost:5000)
    └── styles/
        └── _theme.scss                  ← Orange + Deep Purple M3 theme
```

**Theme configuration** (FR-014):
- Primary palette: `mat.$orange-palette`
- Tertiary palette: `mat.$deep-purple-palette`
- Light theme: default
- Dark theme: `prefers-color-scheme: dark` media query

---

### 7. Docker Compose Stack

The complete set of locally-runnable containers representing the full system.

| Field | Value |
|-------|-------|
| Format | Docker Compose V2 (no `version:` key) |
| Network | `methy-network` (single bridge network) |
| Core services | SQL Server 2022, RabbitMQ, 7 microservices |
| Observability services | Prometheus, Grafana, Jaeger (profile: `observability`) |

**Service inventory**:

| Container | Image | Port(s) | Profile | Health Check |
|-----------|-------|---------|---------|-------------|
| `sql-server` | `mcr.microsoft.com/mssql/server:2022-latest` | 1433 | (core) | ✅ `sqlcmd` query |
| `rabbitmq` | `rabbitmq:3-management` | 5672, 15672 | (core) | ✅ `rabbitmq-diagnostics` |
| `methy-gateway` | `methy-gateway:local` | 5000 | (core) | — |
| `methy-user` | `methy-user:local` | 5001 | (core) | — |
| `methy-restaurant` | `methy-restaurant:local` | 5002 | (core) | — |
| `methy-order` | `methy-order:local` | 5003 | (core) | — |
| `methy-payment` | `methy-payment:local` | 5004 | (core) | — |
| `methy-notification` | `methy-notification:local` | 5005 | (core) | — |
| `methy-delivery` | `methy-delivery:local` | 5006 | (core) | — |
| `prometheus` | `prom/prometheus:latest` | 9090 | observability | — |
| `grafana` | `grafana/grafana:latest` | 3000 | observability | — |
| `jaeger` | `jaegertracing/all-in-one:latest` | 16686 | observability | — |

**Invariants**:
- All containers on `methy-network`
- `docker-compose.override.yml` provides dev-only port mappings and volume mounts
- `definitions.json` defines `methy` vhost, `methy.events` exchange, `methy.orders` queue
- `init.sql` creates the `methy` database

---

### 8. Kubernetes Manifest Set

YAML files describing the desired state of the system in a Kubernetes cluster (Minikube).

| Field | Value |
|-------|-------|
| Root path | `infra/k8s/` |
| Namespace | `methy` |

**File inventory**:
```
infra/k8s/
├── namespace.yml                      ← apiVersion: v1, kind: Namespace
├── deployments/
│   ├── gateway-deployment.yml        ← 1 replica, image: methy-gateway:latest
│   ├── user-deployment.yml
│   ├── restaurant-deployment.yml
│   ├── order-deployment.yml
│   ├── payment-deployment.yml
│   ├── notification-deployment.yml
│   └── delivery-deployment.yml
├── services/
│   ├── gateway-service.yml           ← ClusterIP, targetPort matches FR-032
│   ├── user-service.yml
│   ├── restaurant-service.yml
│   ├── order-service.yml
│   ├── payment-service.yml
│   ├── notification-service.yml
│   └── delivery-service.yml
└── ingress/
    └── methy-ingress.yml             ← Nginx ingress, routes /* to gateway
```

**Invariants**:
- All manifests use `namespace: methy`
- All Deployment manifests reference the `methy` namespace
- Ports in K8s service manifests match the FR-032 port table
- All manifests are syntactically valid YAML (pods will CrashLoopBackOff until real code — acceptable at scaffold)

---

## Entity Relationships

```
Solution (Methy.sln)
  ├── contains → MicroserviceProject[7]
  │     └── references → SharedLibrary (Methy.Shared)
  ├── contains → TestProject[8]
  │     └── references → MicroserviceProject | SharedLibrary (1:1)
  └── does NOT contain → E2ETestProject

MicroserviceProject[7]
  ├── produces → DockerImage (via Dockerfile)
  └── exposes → /health endpoint

DockerImage[7] + InfraImages[5]
  └── orchestrated by → DockerComposeStack
        ├── core profile → always-on services
        └── observability profile → opt-in services

KubernetesManifestSet
  └── describes deployment of → MicroserviceProject[7]

AngularWorkspace
  └── calls → MicroserviceProject via API Gateway (future phases)
```

---

## State Transitions

### Repository Bootstrap Sequence

```
0. Empty repo
   ↓
1. Root config files (.gitignore, .editorconfig, global.json, etc.)
   ↓
2. Backend solution + 16 projects (dotnet new)
   ↓ [dotnet build passes]
3. Docker configuration (Dockerfiles, docker-compose.yml)
   ↓ [docker compose up passes]
4. Frontend workspace (ng new + ng add @angular/material)
   ↓ [ng serve passes]
5. Infra config (K8s manifests, observability)
6. CI/CD workflows (.github/workflows/)
7. Git hooks & code quality (husky, commitlint, prettier)
   ↓ [git commit enforces hooks]
8. Developer tooling (postman/, scripts/, .vscode/)
   ↓
DONE: All acceptance criteria met
```
