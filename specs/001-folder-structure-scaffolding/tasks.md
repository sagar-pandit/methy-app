# Tasks: Folder Structure Scaffolding

**Input**: Design documents from `specs/001-folder-structure-scaffolding/`
**Prerequisites**: plan.md ✅ · spec.md ✅ · research.md ✅ · data-model.md ✅ · contracts/ ✅ · quickstart.md ✅

**Note**: Tests are NOT included — not requested in the feature specification. This is a scaffolding feature; no business logic to test at this phase beyond "projects build and test command passes."

---

## Phase 1: Setup

**Purpose**: Root-level configuration files that gate all subsequent work. These are fast, independent, and block nothing.

- [x] T001 [P] Create `backend/Directory.Build.props` with TargetFramework=net10.0, Nullable=enable, ImplicitUsings=enable, TreatWarningsAsErrors=true (FR-005)
- [x] T002 [P] Create `backend/Directory.Packages.props` with ManagePackageVersionsCentrally=true (FR-006)
- [x] T003 [P] Create `global.json` at repo root pinning .NET SDK `10.0.x` with `rollForward: latestPatch` (FR-030)
- [x] T004 [P] Create `.gitignore` at repo root excluding bin/, obj/, node_modules/, .angular/, *.user, *.env, .env.* (except .env.example), IDE folders (FR-028)
- [x] T005 [P] Create `.editorconfig` at repo root: indent_style=space, indent_size=2 (JSON/YAML/HTML) / 4 (C#/TypeScript), end_of_line=lf, charset=utf-8, trim_trailing_whitespace=true (FR-034)
- [x] T006 [P] Create `.nvmrc` at repo root containing `20` (FR-038)
- [x] T007 [P] Create `.env.example` at repo root documenting SA_PASSWORD, RABBITMQ_DEFAULT_PASS, and per-service connection strings with placeholder values and comments — no real secrets (FR-029)
- [x] T008 [P] Create `package.json` at repo root with devDependencies: husky, lint-staged, @commitlint/cli, @commitlint/config-conventional; include `prepare: husky` script (FR-042)
- [x] T009 [P] Create `commitlint.config.js` at repo root extending `@commitlint/config-conventional` (FR-042)
- [x] T010 [P] Create `.lintstagedrc.json` at repo root: `*.cs` → `dotnet format --include <files> --verify-no-changes`; `*.{ts,html,scss}` → `eslint --fix` + `prettier --write` (FR-042)
- [x] T011 [P] Create `.husky/pre-commit` (runs `npx lint-staged`) and `.husky/commit-msg` (runs `npx commitlint --edit $1`) (FR-042)
- [x] T012 [P] Create `.prettierrc` (printWidth=100, singleQuote=true, trailingComma=all, tabWidth=2, endOfLine=lf) and `.prettierignore` (bin/, obj/, node_modules/, dist/, *.sln, *.csproj) at repo root (FR-044)
- [x] T013 [P] Create `LICENSE` at repo root with MIT license text, year 2026, copyright holder "Sagar Pandit" (FR-049)
- [x] T014 [P] Create `CONTRIBUTING.md` at repo root documenting: branch naming (feature/fix/docs), conventional commits format, PR workflow, code quality gates (tests pass, lint clean, no unlinked TODOs), and how to run the full local stack (FR-039)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: The .NET solution and all 16 projects must exist before US1 (`dotnet build`/`dotnet test`) and US3 (CI) can pass. Cannot be skipped or deferred.

**⚠️ CRITICAL**: No user story work can begin until T015–T037 are complete.

- [x] T015 Create `backend/Methy.sln` using `dotnet new sln --name Methy` from `backend/` (FR-001)
- [x] T016 [P] Create `backend/src/Methy.Gateway/` ASP.NET Core Web API project via `dotnet new webapi --name Methy.Gateway` (FR-002)
- [x] T017 [P] Create `backend/src/Methy.Services.User/` ASP.NET Core Web API project via `dotnet new webapi --name Methy.Services.User` (FR-002)
- [x] T018 [P] Create `backend/src/Methy.Services.Restaurant/` ASP.NET Core Web API project via `dotnet new webapi --name Methy.Services.Restaurant` (FR-002)
- [x] T019 [P] Create `backend/src/Methy.Services.Order/` ASP.NET Core Web API project via `dotnet new webapi --name Methy.Services.Order` (FR-002)
- [x] T020 [P] Create `backend/src/Methy.Services.Payment/` ASP.NET Core Web API project via `dotnet new webapi --name Methy.Services.Payment` (FR-002)
- [x] T021 [P] Create `backend/src/Methy.Services.Notification/` ASP.NET Core Web API project via `dotnet new webapi --name Methy.Services.Notification` (FR-002)
- [x] T022 [P] Create `backend/src/Methy.Services.Delivery/` ASP.NET Core Web API project via `dotnet new webapi --name Methy.Services.Delivery` (FR-002)
- [x] T023 Create `backend/src/Methy.Shared/` class library via `dotnet new classlib --name Methy.Shared` (FR-004)
- [x] T024 Add all 8 source projects to `backend/Methy.sln` with `dotnet sln add` under solution folder `src` (FR-001)
- [x] T025 [P] Create `backend/tests/Methy.Gateway.Tests/` XUnit project via `dotnet new xunit --name Methy.Gateway.Tests` (FR-003)
- [x] T026 [P] Create `backend/tests/Methy.Services.User.Tests/` XUnit project via `dotnet new xunit --name Methy.Services.User.Tests` (FR-003)
- [x] T027 [P] Create `backend/tests/Methy.Services.Restaurant.Tests/` XUnit project via `dotnet new xunit --name Methy.Services.Restaurant.Tests` (FR-003)
- [x] T028 [P] Create `backend/tests/Methy.Services.Order.Tests/` XUnit project via `dotnet new xunit --name Methy.Services.Order.Tests` (FR-003)
- [x] T029 [P] Create `backend/tests/Methy.Services.Payment.Tests/` XUnit project via `dotnet new xunit --name Methy.Services.Payment.Tests` (FR-003)
- [x] T030 [P] Create `backend/tests/Methy.Services.Notification.Tests/` XUnit project via `dotnet new xunit --name Methy.Services.Notification.Tests` (FR-003)
- [x] T031 [P] Create `backend/tests/Methy.Services.Delivery.Tests/` XUnit project via `dotnet new xunit --name Methy.Services.Delivery.Tests` (FR-003)
- [x] T032 Create `backend/tests/Methy.Shared.Tests/` XUnit project via `dotnet new xunit --name Methy.Shared.Tests` (FR-003)
- [x] T033 Add all 8 test projects to `backend/Methy.sln` with `dotnet sln add` under solution folder `tests` (FR-001)
- [x] T034 Add `<ProjectReference>` to `Methy.Shared` in each of the 7 Web API `.csproj` files; add `<ProjectReference>` to each source project in its corresponding test `.csproj` (FR-003, FR-004)
- [x] T035 Implement `GET /health` endpoint returning HTTP 200 `{"status":"Healthy"}` in `Program.cs` for all 7 Web API projects (use `builder.Services.AddHealthChecks()` + `app.MapHealthChecks("/health")` with inline JSON writer) (FR-007)
- [x] T036 [P] Create `appsettings.json` with placeholder `ConnectionStrings`, `Logging`, and `RabbitMQ` sections in each of 7 service source project directories (FR-008)
- [x] T037 [P] Create `appsettings.Development.json` with port-specific `Kestrel:Endpoints` URLs per FR-032 in each of 7 service source project directories (Gateway=5000, User=5001, Restaurant=5002, Order=5003, Payment=5004, Notification=5005, Delivery=5006) (FR-008, FR-032)

**Checkpoint**: `dotnet build Methy.sln` and `dotnet test` from `backend/` both succeed with 0 errors, 0 warnings.

---

## Phase 3: User Story 1 — Developer Clones Repo and Runs Locally (Priority: P1) 🎯 MVP

**Goal**: A developer with prerequisites installed can clone the repo and bring up the full local environment — `dotnet build`, `docker compose up`, and `ng serve` all succeed with zero configuration.

**Independent Test**: On a clean machine with prerequisites installed — `dotnet build Methy.sln` succeeds (0 errors), `docker compose up -d` from `infra/docker/` brings all containers to healthy state within 60 seconds, `ng serve` from `frontend/methy-app/` serves the app at http://localhost:4200, `dotnet test` discovers and runs all 8 test projects.

### Implementation for User Story 1

- [x] T038 [P] [US1] Create multi-stage `Dockerfile` (sdk:10.0 build stage → aspnet:10.0 runtime) and `.dockerignore` (excluding bin/, obj/, node_modules/, *.md, .git/, IDE folders) for `Methy.Gateway` in `backend/src/Methy.Gateway/` (FR-009)
- [x] T039 [P] [US1] Create multi-stage `Dockerfile` and `.dockerignore` for `Methy.Services.User` in `backend/src/Methy.Services.User/` — same pattern as T038 (FR-009)
- [x] T040 [P] [US1] Create multi-stage `Dockerfile` and `.dockerignore` for `Methy.Services.Restaurant` in `backend/src/Methy.Services.Restaurant/` (FR-009)
- [x] T041 [P] [US1] Create multi-stage `Dockerfile` and `.dockerignore` for `Methy.Services.Order` in `backend/src/Methy.Services.Order/` (FR-009)
- [x] T042 [P] [US1] Create multi-stage `Dockerfile` and `.dockerignore` for `Methy.Services.Payment` in `backend/src/Methy.Services.Payment/` (FR-009)
- [x] T043 [P] [US1] Create multi-stage `Dockerfile` and `.dockerignore` for `Methy.Services.Notification` in `backend/src/Methy.Services.Notification/` (FR-009)
- [x] T044 [P] [US1] Create multi-stage `Dockerfile` and `.dockerignore` for `Methy.Services.Delivery` in `backend/src/Methy.Services.Delivery/` (FR-009)
- [x] T045 [US1] Create `infra/docker/docker-compose.yml` (Compose V2, no `version:` key): core services without profile — SQL Server 2022 + RabbitMQ (with management plugin) with health checks (FR-011), 7 microservices; observability services under `observability` profile — Prometheus (9090), Grafana (3000), Jaeger (16686); all on `methy-network` bridge (FR-010, FR-011, FR-035, FR-040)
- [x] T046 [US1] Create `infra/docker/docker-compose.override.yml` with development port mappings, environment variable overrides (SA_PASSWORD, RABBITMQ credentials), and volume mounts for hot reload (FR-012)
- [x] T047 [P] [US1] Create `infra/docker/rabbitmq/definitions.json` defining `methy` virtual host, one topic exchange (`methy.events`), and one queue (`methy.orders`) with binding — valid RabbitMQ definitions JSON (FR-036)
- [x] T048 [P] [US1] Create `infra/docker/sql/init.sql` with `CREATE DATABASE methy;` + comment block listing future tables (FR-037)
- [x] T049 [US1] Scaffold Angular 19 workspace via `ng new methy-app --routing --style=scss` in `frontend/` (produces `frontend/methy-app/`) — `--standalone` omitted: Angular 19 default is standalone-first (FR-013)
- [x] T050 [US1] Add Angular Material 3 via `ng add @angular/material` in `frontend/methy-app/` — when prompted for theme, select **Custom**; enable typography and animations — T051 owns all theme definitions via `mat.define-theme()` (FR-013)
- [x] T051 [US1] Create `frontend/methy-app/src/styles/_theme.scss` using M3 theming API: `mat.define-theme()` with `mat.$orange-palette` (primary) and `mat.$deep-purple-palette` (tertiary); apply `mat.theme()` for light; add `@media (prefers-color-scheme: dark)` block for dark variant; reference from `styles.scss` (FR-014)
- [x] T052 [US1] Configure standalone-first architecture: **update** `frontend/methy-app/src/app/app.config.ts` (generated by `ng new`) to add `provideHttpClient(withInterceptors([authInterceptor]))` if not already present; **create** stub `auth.interceptor.ts` as `HttpInterceptorFn` in `frontend/methy-app/src/app/core/interceptors/`; **create** stub `auth.guard.ts` as `CanActivateFn`+`CanMatchFn` in `frontend/methy-app/src/app/core/guards/` (FR-015)
- [x] T053 [P] [US1] Create `frontend/methy-app/src/environments/environment.ts` (production, placeholder API URL) and `environment.development.ts` (apiGatewayUrl: 'http://localhost:5000') (FR-017)
- [x] T054 [P] [US1] Create placeholder `README.md` in each of `frontend/methy-app/src/app/features/restaurants/`, `orders/`, `delivery/`, `admin/`, `profile/` — each with feature title, one-sentence domain description, and "Implementation: Phase X" note (FR-016)
- [x] T055 [US1] Create standalone E2E project at `e2e/Methy.E2E.csproj` targeting net10.0 with `Microsoft.Playwright` NuGet reference + XUnit; create `e2e/playwright.config.ts` (Chromium, baseURL: http://localhost:4200); create `e2e/Tests/OrderFlowTests.cs` and `e2e/PageObjects/` placeholder directory — NOT added to `backend/Methy.sln` (FR-041)
- [x] T056 [P] [US1] Create `scripts/setup.ps1` with comment header; checks dotnet/node/docker/ng prerequisites, runs `npm install` at root, runs `dotnet restore backend/Methy.sln`, runs `npm install` in `frontend/methy-app/`, runs `playwright install chromium` from `e2e/` (FR-045)
- [x] T057 [P] [US1] Create `scripts/seed-db.ps1` (comment header + placeholder sqlcmd stub) and `scripts/reset.ps1` (stops containers, removes volumes, rebuilds images) — each with purpose/usage comment header (FR-045)
- [x] T058 [US1] Create `README.md` at repo root: project overview, prerequisites table with install links, quick-start commands (`docker compose up`, `dotnet run`, `ng serve`), folder structure diagram matching canonical spec tree, Troubleshooting section covering Docker not running / port conflicts / SDK mismatch / Angular CLI mismatch (FR-031)

**Checkpoint**: `dotnet build Methy.sln` ✅ · `docker compose up -d` (core) ✅ · `ng serve` ✅ · `dotnet test` ✅ — User Story 1 acceptance scenarios all pass.

---

## Phase 4: User Story 2 — Developer Understands Project Structure at a Glance (Priority: P2)

**Goal**: Every component (microservice source, test, Dockerfile, K8s manifest) is locatable purely from the folder structure in under 30 seconds without opening any file.

**Independent Test**: Given the scaffolded folder tree, locate Methy.Services.User source (`backend/src/Methy.Services.User/`), its tests (`backend/tests/Methy.Services.User.Tests/`), its Dockerfile (`backend/src/Methy.Services.User/Dockerfile`), and its K8s deployment (`infra/k8s/deployments/user-deployment.yml`) without reading any file.

### Implementation for User Story 2

- [x] T059 [P] [US2] Create `infra/k8s/namespace.yml` defining `apiVersion: v1, kind: Namespace, metadata.name: methy` (FR-018)
- [x] T060 [P] [US2] Create K8s Deployment manifests under `infra/k8s/deployments/`: `gateway-deployment.yml`, `user-deployment.yml`, `restaurant-deployment.yml`, `order-deployment.yml`, `payment-deployment.yml`, `notification-deployment.yml`, `delivery-deployment.yml` — each a valid Deployment YAML with `namespace: methy`, 1 replica, image referencing the service name with `:latest` tag, and containerPort matching FR-032 (FR-019)
- [x] T061 [P] [US2] Create K8s ClusterIP Service manifests under `infra/k8s/services/`: `gateway-service.yml`, `user-service.yml`, `restaurant-service.yml`, `order-service.yml`, `payment-service.yml`, `notification-service.yml`, `delivery-service.yml` — each a valid Service YAML with `namespace: methy`, `type: ClusterIP`, port matching FR-032 (FR-020)
- [x] T062 [P] [US2] Create `infra/k8s/ingress/methy-ingress.yml` — valid Nginx Ingress YAML in `methy` namespace routing `/*` to the `methy-gateway` ClusterIP service on port 5000 (FR-021)
- [x] T063 [P] [US2] Create `infra/observability/prometheus/prometheus.yml` with global scrape interval and scrape_configs targeting each of 7 services' `/metrics` endpoint at their FR-032 port (FR-022)
- [x] T064 [P] [US2] Create Grafana provisioning structure: `infra/observability/grafana/provisioning/datasources/prometheus.yml` (datasource pointing to Prometheus container) and `infra/observability/grafana/provisioning/dashboards/dashboards.yml` (folder provider config) (FR-023)
- [x] T065 [P] [US2] Create `infra/observability/jaeger/README.md` documenting the Jaeger all-in-one container configuration; the Jaeger service is defined directly in `infra/docker/docker-compose.yml` (T045) using `jaegertracing/all-in-one:latest` — no additional Jaeger-specific config file is required (FR-024)
- [x] T066 [P] [US2] Create OpenAPI 3.0 stubs at `api/`: `README.md` (describes contract-first approach) + 7 service YAML files (`gateway.openapi.yml`, `user-service.openapi.yml`, `restaurant-service.openapi.yml`, `order-service.openapi.yml`, `payment-service.openapi.yml`, `notification-service.openapi.yml`, `delivery-service.openapi.yml`) — each with `info`, `servers` (localhost port per FR-032), and `GET /health` path returning HealthResponse schema (FR-033); use contracts/ in this spec as source
- [x] T067 [P] [US2] Create `docs/architecture/README.md` ("Architecture Decision Records and system diagrams — Phase 2+") and `docs/guides/README.md` ("Setup and contribution guides — see root README.md and CONTRIBUTING.md") (FR-033)
- [x] T068 [P] [US2] Create Postman collections under `postman/`: `gateway.postman_collection.json`, `user-service.postman_collection.json`, `restaurant-service.postman_collection.json`, `order-service.postman_collection.json`, `payment-service.postman_collection.json`, `notification-service.postman_collection.json`, `delivery-service.postman_collection.json` — each with a `Health Check` folder containing `GET /health` request; plus `methy-local.postman_environment.json` with base URL variables per FR-032 port table (FR-043)
- [x] T069 [P] [US2] Create `.vscode/extensions.json` (recommended: C# Dev Kit, Angular Language Service, ESLint, Prettier, Docker, YAML, EditorConfig, REST Client, GitLens), `.vscode/settings.json` (editor.formatOnSave: true, defaultFormatter per language, rulers at 100, files.eol: \n), and `.vscode/launch.json` (debug configs for each .NET microservice + Angular Chrome attach) (FR-048)

**Checkpoint**: Any named component (source, test, Dockerfile, K8s manifest) is findable purely by navigating the folder tree — no file contents needed. User Story 2 acceptance scenarios all pass.

---

## Phase 5: User Story 3 — CI Pipeline Validates the Skeleton on Every Push (Priority: P3)

**Goal**: Every push to any branch triggers GitHub Actions workflows that build all .NET projects, run all tests, and build all 7 Docker images — providing immediate feedback.

**Independent Test**: Push a commit to the feature branch. The `build` and `docker` GitHub Actions workflows trigger, all jobs pass, and a green check appears on the commit.

### Implementation for User Story 3

- [x] T070 [US3] Create `.github/workflows/build.yml`: trigger on `push` to any branch (`branches: ['**']`), `ubuntu-latest` runner, steps: checkout → setup .NET 10 → `dotnet restore backend/Methy.sln` → `dotnet build backend/Methy.sln --no-restore -c Release` → `dotnet test backend/Methy.sln --no-build -c Release` (FR-025)
- [x] T071 [US3] Create `.github/workflows/docker.yml`: trigger on `push` to any branch, `ubuntu-latest` runner; use a matrix strategy `service: [Methy.Gateway, Methy.Services.User, Methy.Services.Restaurant, Methy.Services.Order, Methy.Services.Payment, Methy.Services.Notification, Methy.Services.Delivery]`; each matrix step runs `docker build backend/ -f backend/src/${{ matrix.service }}/Dockerfile -t methy-${{ matrix.service }}:local` — build context MUST be `backend/` (not the service subdirectory) to resolve `Methy.Shared` cross-project references during the multi-stage build; images built, not pushed (FR-026)
- [x] T072 [US3] Create `.github/workflows/deploy.yml`: valid YAML with `on: workflow_dispatch` trigger, one placeholder job with all steps commented out and marked `# TODO: Add deploy steps` — passes actionlint syntax check (FR-027)

**Checkpoint**: Green CI check on push to feature branch — `build.yml` and `docker.yml` jobs all pass. User Story 3 acceptance scenarios all pass.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: GitHub repository configuration and final validation — does not block any user story.

- [x] T073 [P] Create `.github/PULL_REQUEST_TEMPLATE.md` with checklist: description of changes, related FR/issue number, tests added/updated, `dotnet build` passes, lint clean, no unlinked TODOs, documentation updated (FR-046)
- [x] T074 [P] Create `.github/dependabot.yml` with weekly update checks for: `nuget` (directory: `/backend`), `npm` (directory: `/`), `npm` (directory: `/frontend/methy-app`), `github-actions` (directory: `/`) — each with `open-pull-requests-limit: 5` and `commit-message.prefix: chore(deps):` (FR-047)
- [x] T075 Validate full repository: confirm all folders/files from the canonical spec.md tree exist (`dotnet build Methy.sln` ✅, `docker compose build` from `infra/docker/` ✅, `ng build` from `frontend/methy-app/` ✅, `dotnet test` ✅); verify zero secrets in any committed file (SC-001 through SC-007). **Known gap (C1)**: Prometheus `/metrics` scrape targets will return 404 at scaffold — `prometheus-net.AspNetCore` endpoint wiring is deferred to Phase 2 when services gain business logic. **Post-CI check (SC-004)**: After first push to the feature branch, verify `.github/workflows/build.yml` completes in under 5 minutes.

---

## Dependencies & Execution Order

### Phase Dependencies

```
Phase 1: Setup          → No dependencies — start immediately
Phase 2: Foundational   → Requires Phase 1 complete — BLOCKS all user stories
Phase 3: US1 (P1)       → Requires Phase 2 complete
Phase 4: US2 (P2)       → Requires Phase 2 complete — can run in parallel with US1
Phase 5: US3 (P3)       → Requires Phase 3 complete (needs Dockerfiles for docker.yml)
Phase 6: Polish         → Requires Phases 3, 4, 5 complete
```

### User Story Dependencies

- **US1 (P1)**: Depends on Phase 2 only. Delivers the runnable environment.
- **US2 (P2)**: Depends on Phase 2 only. Can run fully in parallel with US1 (different files).
- **US3 (P3)**: Depends on Phase 3 (needs 7 Dockerfiles for the docker workflow). Logically also needs Phase 2.

### Parallel Opportunities Per Phase

**Phase 1**: T001–T014 all parallelizable (independent config files)
**Phase 2**: T016–T023 all parallelizable (8 independent `dotnet new` commands). T025–T032 all parallelizable (8 independent `dotnet new xunit` commands). T036–T037 parallelizable (same pattern × 7 services)
**Phase 3 (US1)**: T038–T044 all parallelizable (7 independent Dockerfiles). T047–T048, T053–T054, T056–T057 all parallelizable
**Phase 4 (US2)**: T059–T069 ALL parallelizable (11 independent file groups — different directories, no dependencies between them)
**Phase 5 (US3)**: T070–T072 all parallelizable (3 independent workflow files)
**Phase 6**: T073–T074 parallelizable

---

## Parallel Execution Examples

### Phase 2: Create all 7 Web API projects simultaneously

```
T016: dotnet new webapi --name Methy.Gateway         → backend/src/Methy.Gateway/
T017: dotnet new webapi --name Methy.Services.User   → backend/src/Methy.Services.User/
T018: dotnet new webapi --name Methy.Services.Restaurant
T019: dotnet new webapi --name Methy.Services.Order
T020: dotnet new webapi --name Methy.Services.Payment
T021: dotnet new webapi --name Methy.Services.Notification
T022: dotnet new webapi --name Methy.Services.Delivery
```

### Phase 3 (US1): Create all 7 Dockerfiles simultaneously

```
T038: Dockerfile for Methy.Gateway
T039: Dockerfile for Methy.Services.User
T040: Dockerfile for Methy.Services.Restaurant
T041: Dockerfile for Methy.Services.Order
T042: Dockerfile for Methy.Services.Payment
T043: Dockerfile for Methy.Services.Notification
T044: Dockerfile for Methy.Services.Delivery
```

### Phase 4 (US2): All 11 tasks parallelizable

```
T059: infra/k8s/namespace.yml
T060: infra/k8s/deployments/ (7 manifests)
T061: infra/k8s/services/ (7 manifests)
T062: infra/k8s/ingress/methy-ingress.yml
T063: infra/observability/prometheus/prometheus.yml
T064: infra/observability/grafana/ provisioning
T065: infra/observability/jaeger/ config
T066: api/ OpenAPI stubs (7 YAML files)
T067: docs/ README files
T068: postman/ collections (7 + env)
T069: .vscode/ config files
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete **Phase 1** (Setup) — ~14 config files, most parallelizable
2. Complete **Phase 2** (Foundational) — 16 .NET projects, health checks, appsettings
3. **Validate Phase 2**: `dotnet build Methy.sln && dotnet test` → must pass with 0 errors
4. Complete **Phase 3** (US1) — Dockerfiles, Docker Compose, Angular workspace, scripts, README
5. **Validate US1**: `docker compose up -d` + `ng serve` + all health checks return 200
6. **STOP and DEMO**: US1 acceptance scenarios SC-001 through SC-007 all verified

### Full Delivery (All Stories)

7. Complete **Phase 4** (US2) in parallel with Phase 5 — independent file groups
8. Complete **Phase 5** (US3) — requires Phase 3 Dockerfiles
9. Complete **Phase 6** (Polish + final validation)

---

## Task Summary

| Phase | Tasks | Parallelizable | Story |
|-------|-------|---------------|-------|
| Phase 1: Setup | T001–T014 (14 tasks) | T001–T014 (14 of 14) | — |
| Phase 2: Foundational | T015–T037 (23 tasks) | T016–T023, T025–T032, T036–T037 | — |
| Phase 3: US1 (P1) | T038–T058 (21 tasks) | T038–T044, T047–T048, T053–T054, T056–T057 | US1 |
| Phase 4: US2 (P2) | T059–T069 (11 tasks) | T059–T069 (all 11) | US2 |
| Phase 5: US3 (P3) | T070–T072 (3 tasks) | T070–T072 (all 3) | US3 |
| Phase 6: Polish | T073–T075 (3 tasks) | T073–T074 | — |
| **Total** | **75 tasks** | **52 parallelizable** | |

**Suggested MVP scope**: Phases 1 + 2 + 3 (T001–T058) — delivers a fully runnable local environment for User Story 1.
