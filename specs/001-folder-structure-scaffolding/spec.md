# Feature Specification: Folder Structure Scaffolding

**Feature Branch**: `feature/001-folder-structure-scaffolding`
**Created**: 2026-04-30
**Status**: Clarified
**Input**: User description: "Scaffold the complete Methy food delivery platform folder structure including all microservice projects, Angular frontend, shared libraries, infrastructure configuration, CI/CD workflows, documentation structure, and observability setup — ready for Phase 1 development to begin."

---

## User Scenarios & Testing _(mandatory)_

### User Story 1 - Developer Clones Repo and Runs Locally (Priority: P1)

A new developer (Sagar) clones the Methy repository and wants to verify the project skeleton is intact and ready to work on. They should be able to build all .NET projects, start the Angular dev server, and bring up all local infrastructure in a single command — with zero configuration beyond what is documented in the README.

**Why this priority**: All subsequent development depends on a working, consistent local environment. Nothing else can proceed without this foundation.

**Independent Test**: Clone the repo on a clean machine with the prerequisites installed. Run `dotnet build` from `backend/`, `ng serve` from `frontend/methy-app/`, and `docker-compose up` from `infra/docker/`. All three commands succeed without errors.

**Acceptance Scenarios**:

1. **Given** a clean clone of the repository, **When** `dotnet build Methy.slnx` is run from `backend/`, **Then** all 16 projects (8 source + 8 test) compile with zero errors and zero warnings
2. **Given** the cloned repository, **When** `docker-compose up -d` is run from `infra/docker/`, **Then** SQL Server, RabbitMQ, and supporting containers start and pass health checks within 60 seconds
3. **Given** the cloned repository, **When** `ng serve` is run from `frontend/methy-app/`, **Then** the Angular development server starts and serves the application at `http://localhost:4200`
4. **Given** the cloned repository, **When** `dotnet test` is run from `backend/`, **Then** all 8 test projects are discovered and execute (passing, even if empty)

---

### User Story 2 - Developer Understands Project Structure at a Glance (Priority: P2)

A developer returning to the project after a break can navigate to any component (a specific microservice, its tests, its Dockerfile, its Kubernetes manifest) purely from the folder structure — without needing to read documentation first.

**Why this priority**: Self-documenting structure reduces onboarding friction and reinforces learning by making architecture tangible.

**Independent Test**: Given the folder tree, identify the location of the User Service source, its test project, its Dockerfile, and its Kubernetes deployment manifest in under 30 seconds — without opening any file.

**Acceptance Scenarios**:

1. **Given** the scaffolded structure, **When** a developer looks for any microservice, **Then** source, tests, Dockerfile, and k8s manifests are always found in consistent, predictable locations
2. **Given** the scaffolded structure, **When** a developer looks for infrastructure configuration, **Then** Docker Compose, Kubernetes manifests, RabbitMQ config, SQL scripts, and observability configs are all under `infra/`
3. **Given** the scaffolded structure, **When** a developer looks for CI/CD workflows, **Then** all GitHub Actions workflow files are found under `.github/workflows/`

---

### User Story 3 - CI Pipeline Validates the Skeleton on Every Push (Priority: P3)

Every commit pushed to any branch triggers the GitHub Actions build pipeline, which builds all .NET projects, runs all test projects, builds all Docker images, and validates workflow YAML syntax — providing immediate feedback that the structure is intact.

**Why this priority**: Continuous validation from day one builds the CI/CD habit and catches structural regressions immediately.

**Independent Test**: Push a commit to the feature branch. GitHub Actions workflow runs, all jobs pass, and a green check appears on the commit.

**Acceptance Scenarios**:

1. **Given** a commit is pushed to GitHub, **When** the build workflow triggers, **Then** `dotnet build` and `dotnet test` succeed for all projects in the solution
2. **Given** a commit is pushed to GitHub, **When** the Docker build workflow triggers, **Then** all 7 service Dockerfiles build successfully (images don't need to be pushed; `Methy.Shared` is a library and has no Dockerfile)
3. **Given** a malformed Dockerfile or workflow YAML is introduced, **When** CI runs, **Then** the pipeline fails and blocks the merge

---

### Edge Cases

- What happens when Docker Desktop is not running when `docker-compose up` is executed? README must document the prerequisite check and the error message guides the user.
- What happens when port 1433 (SQL Server) or 5672 (RabbitMQ) is already in use locally? `docker-compose.override.yml` provides alternate port mappings.
- What happens when the Angular CLI version differs from the workspace version? `package.json` pins the Angular CLI version; `ng version` mismatch is documented in the setup guide.
- What happens when `dotnet` SDK version mismatches? `global.json` pins the exact SDK version and produces a clear error.

---

## Requirements _(mandatory)_

### Functional Requirements

**Backend Solution Structure**

- **FR-001**: The scaffold MUST create a `.NET 10` solution file `Methy.slnx` under `backend/` containing all 16 projects (8 source, 8 test)
- **FR-002**: Each of the 7 runnable service source projects (API Gateway + 6 domain services) MUST be an ASP.NET Core Web API project targeting `.NET 10`; `Methy.Shared` is a class library (see FR-004)
- **FR-003**: Each source project (including `Methy.Shared`) MUST have a corresponding XUnit test project (e.g., `Methy.Services.User.Tests`, `Methy.Shared.Tests`) referencing it
- **FR-004**: `Methy.Shared` MUST be a class library (not a Web API) referenced by all service projects
- **FR-005**: `Directory.Build.props` MUST define shared build properties (target framework, nullable, implicit usings, treat-warnings-as-errors)
- **FR-006**: `Directory.Packages.props` MUST enable centralized NuGet package version management
- **FR-007**: Every Web API project (all source projects except `Methy.Shared`) MUST include a health check endpoint (`/health`) registered in `Program.cs` that returns HTTP 200 with a JSON body `{"status": "Healthy"}` — ensuring Docker and Kubernetes health checks pass on the scaffold
- **FR-008**: Every Web API project (all source projects except `Methy.Shared`) MUST have `appsettings.json` and `appsettings.Development.json` with placeholder configuration sections (ConnectionStrings, Logging, RabbitMQ)

**Container Configuration**

- **FR-009**: Every runnable service project (all source projects except `Methy.Shared` class library) MUST include a `Dockerfile` using multi-stage build (build stage + runtime stage); total of 7 Dockerfiles. Each service MUST also have a `.dockerignore` file excluding `bin/`, `obj/`, `node_modules/`, `*.md`, `.git/`, and IDE-specific folders to minimize build context and prevent secret leakage
- **FR-010**: `infra/docker/docker-compose.yml` MUST use Docker Compose V2 specification (no top-level `version:` key). It MUST define services for: SQL Server 2022, RabbitMQ (with management plugin), and each of the 7 runnable microservices (API Gateway + 6 domain services); all containers MUST share a single `methy-network` bridge network. _(See also FR-035 for observability services, FR-040 for profile assignment, FR-011 for health checks, FR-012 for dev overrides)_
- **FR-011**: `docker-compose.yml` MUST define health checks for SQL Server and RabbitMQ containers
- **FR-012**: `docker-compose.override.yml` MUST provide development overrides (port mappings, environment variables, volume mounts for hot reload)
- **FR-036**: `infra/docker/rabbitmq/` MUST contain a placeholder `definitions.json` defining a `methy` virtual host with stub exchange and queue definitions for message topology reference
- **FR-037**: `infra/docker/sql/` MUST contain a placeholder `init.sql` script that creates the `methy` database

**Frontend Structure**

- **FR-013**: The scaffold MUST create an Angular 21 workspace under `frontend/methy-app/` with Angular Material 3 installed and configured
- **FR-014**: A custom Angular Material 3 theme MUST be defined in `_theme.scss` using the M3 theming API (`mat.define-theme()` with `mat.theme()` mixin) with Orange as the primary palette, Deep Purple as the tertiary palette, and system-default error/neutral palettes; both light and dark color schemes MUST be configured via `prefers-color-scheme` media query or class-based toggle
- **FR-015**: The Angular app MUST use standalone-first architecture (Angular 21 default): no `AppModule`, `CoreModule`, or `SharedModule`; providers configured via `app.config.ts`; authentication interceptor stubbed as a functional `HttpInterceptorFn` and route guards stubbed as functional `CanActivateFn`/`CanMatchFn`; shared Material components declared as standalone components in a `shared/` folder
- **FR-016**: Feature area placeholder folders MUST exist under `frontend/methy-app/src/app/features/` for: `restaurants`, `orders`, `delivery`, `admin`, `profile`; each folder MUST contain a placeholder `README.md` naming the feature area's domain responsibility (no NgModules — standalone-first architecture)
- **FR-017**: Angular environments MUST be configured for `development` (local API gateway URL) and `production` (placeholder)

**Kubernetes Manifests**

- **FR-018**: `infra/k8s/` MUST contain a `namespace.yaml` defining the `methy` namespace
- **FR-019**: `infra/k8s/deployments.yaml` MUST contain placeholder deployment manifests for all microservices (multi-document YAML)
- **FR-020**: `infra/k8s/services.yaml` MUST contain placeholder ClusterIP service manifests for all microservices (multi-document YAML)
- **FR-021**: `infra/k8s/ingress.yaml` MUST contain a placeholder Nginx ingress manifest routing to the API Gateway

**Observability Configuration**

- **FR-022**: `infra/observability/prometheus/prometheus.yml` MUST define scrape configs targeting each microservice's `/metrics` endpoint
- **FR-023**: `infra/observability/grafana/` MUST contain provisioning configuration (datasources, dashboard folders)
- **FR-024**: `infra/observability/jaeger/` MUST contain a Jaeger all-in-one Docker configuration
- **FR-035**: `infra/docker/docker-compose.yml` MUST include service definitions for Prometheus (port 9090), Grafana (port 3000), and Jaeger all-in-one (port 16686) on the `methy-network`, referencing the configuration files defined in `infra/observability/`; these services MUST be assigned to the `observability` compose profile _(see FR-040 for profile semantics, FR-010 for core services)_

**CI/CD Workflows**

- **FR-025**: `.github/workflows/build.yml` MUST run `dotnet build` and `dotnet test` on push to any branch using `ubuntu-latest` runners (preserves free-tier 1:1 minute ratio). Note: push-to-any-branch trigger is intentional for Phase 1 to build CI habit; will be refined to PR-only in later phases
- **FR-026**: `.github/workflows/docker.yml` MUST build (not push) all 7 Docker images on push to any branch using `ubuntu-latest` runners. Note: same trigger rationale as FR-025 — catches broken Dockerfiles immediately
- **FR-027**: `.github/workflows/deploy.yml` MUST be a skeleton file with placeholder deploy jobs (commented out) for future use

**Root Configuration**

- **FR-028**: `.gitignore` MUST exclude: `bin/`, `obj/`, `node_modules/`, `.angular/`, `*.user`, `*.env`, `.env.*` (except `.env.example`), IDE-specific folders
- **FR-029**: `.env.example` MUST document all required environment variables with placeholder values and comments — no real secrets
- **FR-030**: `global.json` MUST pin the .NET SDK to version `10.0.x` with `rollForward: latestPatch`
- **FR-031**: `README.md` MUST include: project overview, prerequisites list with install links, quick start commands (`docker-compose up`, `dotnet run`, `ng serve`), folder structure diagram, and a "Troubleshooting" section documenting common setup errors (Docker Desktop not running, port conflicts, SDK version mismatch)
- **FR-032**: Each service MUST use a fixed, documented port assignment across `appsettings.Development.json`, `docker-compose.yml`, and Prometheus scrape config: API Gateway=5000, User Service=5001, Restaurant Service=5002, Order Service=5003, Payment Service=5004, Notification Service=5005, Delivery Service=5006; `Methy.Shared` is a library with no port
- **FR-033**: The repository MUST contain the following top-level structural directories: `docs/` with subdirectories `architecture/` (for ADRs and diagrams) and `guides/` (for setup and contribution guides); `api/` at the repository root (for hand-written, contract-first OpenAPI 3.0 YAML stubs per service — defined before implementation per Constitution Principle IV). Each subdirectory MUST contain a placeholder `README.md` describing its purpose
- **FR-034**: A `.editorconfig` file MUST exist at the repository root defining: indent style (spaces), indent size (2 for JSON/YAML/HTML, 4 for C#/TypeScript), end-of-line (LF), charset (utf-8), and trim trailing whitespace
- **FR-038**: A `.nvmrc` file MUST exist at the repository root pinning the Node.js version to `20` (LTS) for consistent frontend tooling across environments; Angular 21 officially supports Node 20 LTS
- **FR-039**: A `CONTRIBUTING.md` file MUST exist at the repository root documenting: branch naming conventions, commit message format (conventional commits), PR workflow, code quality gates (tests pass, lint clean, no TODOs without linked issues), and how to run the full local stack
- **FR-040**: `infra/docker/docker-compose.yml` MUST use Docker Compose profiles: core services (SQL Server, RabbitMQ, microservices) have **no profile assigned** and start with a plain `docker compose up`; observability services (Prometheus, Grafana, Jaeger) are assigned to the `observability` profile and only start when explicitly requested via `docker compose --profile observability up`. This enables developers with 8GB RAM to run the essential stack without observability overhead

**End-to-End Tests**

- **FR-041**: A top-level `e2e/` folder MUST contain a .NET XUnit project (`Methy.E2E.csproj`) with `Microsoft.Playwright` NuGet package configured for browser-based end-to-end testing. The project MUST include a `Tests/` folder for test classes (organized by user journey) and a `PageObjects/` folder for page object models. A `playwright.config.ts` MUST exist for Playwright browser configuration. This project is NOT included in `Methy.slnx` — it runs independently against the full running stack

**Git Hooks & Code Quality Automation**

- **FR-042**: A root-level `package.json` MUST exist (workspace-level, separate from `frontend/methy-app/package.json`) declaring `husky`, `lint-staged`, and `@commitlint/cli` + `@commitlint/config-conventional` as `devDependencies`. A `.husky/` folder MUST contain: a `pre-commit` hook running `npx lint-staged`, and a `commit-msg` hook running `npx commitlint --edit $1`. A `.lintstagedrc.json` MUST define: `*.cs` files → `dotnet format --include <files> --verify-no-changes`; `*.{ts,html,scss}` files → `eslint --fix` + `prettier --write`. A `commitlint.config.js` MUST extend `@commitlint/config-conventional` enforcing conventional commit format (`feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`)

**API Testing Collections**

- **FR-043**: A top-level `postman/` folder MUST exist containing Postman collection JSON files (one per microservice) and a shared environment file. Collections MUST be organized as: `methy-gateway.postman_collection.json`, `methy-user.postman_collection.json`, `methy-restaurant.postman_collection.json`, `methy-order.postman_collection.json`, `methy-payment.postman_collection.json`, `methy-notification.postman_collection.json`, `methy-delivery.postman_collection.json`, and `methy-local.postman_environment.json` (containing base URLs and placeholder variables). Each collection MUST include at minimum a `Health Check` request (`GET /health`) for the respective service

**Code Formatting**

- **FR-044**: A `.prettierrc` file MUST exist at the repository root defining: print width (100), single quotes (true), trailing commas (all), tab width (2 for default, override 4 for `*.cs`), and end-of-line (lf). A `.prettierignore` file MUST exclude `bin/`, `obj/`, `node_modules/`, `dist/`, `*.sln`, and `*.csproj` from formatting

**Developer Scripts**

- **FR-045**: A `scripts/` folder MUST exist at the repository root containing PowerShell scripts for common dev tasks: `setup.ps1` (first-time environment setup — checks prerequisites, runs `npm install` at root, runs `dotnet restore`, installs Playwright browsers), `seed-db.ps1` (inserts test/sample data into local SQL Server), and `reset.ps1` (stops all containers, removes volumes, rebuilds images from scratch). Each script MUST include a comment header describing its purpose and usage

**GitHub Repository Configuration**

- **FR-046**: `.github/PULL_REQUEST_TEMPLATE.md` MUST exist with a checklist including: description of changes, related issue/FR number, tests added/updated, `dotnet build` passes, lint clean, no TODOs without linked issue, and documentation updated if applicable
- **FR-047**: `.github/dependabot.yml` MUST exist configuring monthly dependency update checks for: `nuget` (directory: `/backend`), `npm` (directory: `/`), `npm` (directory: `/frontend/methy-app`), and `github-actions` (directory: `/`). Each ecosystem MUST have a limit of 5 open PRs and use conventional commit prefixes (`chore(deps):`)

**IDE Configuration**

- **FR-048**: A `.vscode/` folder MUST exist at the repository root containing: `extensions.json` (recommended extensions: C# Dev Kit, Angular Language Service, ESLint, Prettier, Docker, YAML, EditorConfig, REST Client, GitLens), `settings.json` (editor.formatOnSave: true, editor.defaultFormatter per language, rulers at 100, files.eol: \n), and `launch.json` (debug configurations for each .NET microservice and the Angular app with Chrome attach)

**License**

- **FR-049**: A `LICENSE` file MUST exist at the repository root containing the MIT license text with the current year and "Sagar Pandit" as the copyright holder

### Placeholder Definitions

The word "placeholder" in the requirements above has specific meaning per artifact type:

| Artifact Type                              | "Placeholder" means                                                                                                                                                                                                   | Example                                                                                                      |
| ------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| **README.md** (FR-016, FR-033)             | A Markdown file with a title, one-sentence purpose description, and a "Coming in Phase X" note                                                                                                                        | `# Restaurants Feature\nHandles restaurant browsing, search, and menu display.\n\n> Implementation: Phase 3` |
| **K8s manifests** (FR-019, FR-020, FR-021) | A syntactically valid YAML file with correct apiVersion, kind, metadata, and spec structure using the service's image name and port — deployable to Minikube but the pod will CrashLoopBackOff until real code exists | Valid `Deployment` YAML referencing `methy-gateway:latest` on port 5000                                      |
| **OpenAPI stubs** (FR-033)                 | A valid OpenAPI 3.0 YAML file with `info`, `servers`, and a single `GET /health` path returning 200 — one file per service                                                                                            | Parseable by any OpenAPI validator                                                                           |
| **RabbitMQ definitions.json** (FR-036)     | A valid JSON file defining the `methy` vhost, one topic exchange (`methy.events`), and one queue (`methy.orders`) with a binding — loadable by RabbitMQ's definition import                                           | JSON matching RabbitMQ definitions schema                                                                    |
| **SQL init.sql** (FR-037)                  | A single `CREATE DATABASE` statement plus a comment block listing future tables                                                                                                                                       | `CREATE DATABASE methy;\nGO\n-- Tables will be created by EF Core migrations`                                |
| **Deploy workflow** (FR-027)               | A valid YAML workflow file with trigger and jobs keys, all job steps commented out with TODO markers                                                                                                                  | Passes `actionlint` syntax check                                                                             |

### Key Entities

- **Solution**: Top-level .NET solution containing all backend projects and their relationships
- **Microservice Project**: An ASP.NET Core Web API project representing one bounded domain context
- **Test Project**: An XUnit project co-located with its source project, validating the source project in isolation
- **Docker Compose Stack**: The complete set of locally-runnable containers representing the full system
- **Kubernetes Manifest Set**: YAML files describing the desired state of the system in a Kubernetes cluster
- **Angular Workspace**: The Angular CLI workspace containing the frontend application with Material theming

---

## Folder Structure _(canonical reference)_

All functional requirements reference paths from this tree. This is the single source of truth for the scaffolded output.

```
Methy/                                   ← repository root
├── .editorconfig                        ← FR-034
├── .env.example                         ← FR-029
├── .gitignore                           ← FR-028
├── .husky/                              ← FR-042
│   ├── pre-commit                       ← npx lint-staged
│   └── commit-msg                       ← npx commitlint --edit $1
├── .lintstagedrc.json                   ← FR-042
├── .nvmrc                               ← FR-038
├── .prettierrc                          ← FR-044
├── .prettierignore                      ← FR-044
├── .vscode/                             ← FR-048
│   ├── extensions.json                  ← Recommended extensions
│   ├── settings.json                    ← Workspace settings
│   └── launch.json                      ← Debug configurations
├── commitlint.config.js                 ← FR-042
├── CONTRIBUTING.md                      ← FR-039
├── global.json                          ← FR-030
├── LICENSE                              ← FR-049 (MIT)
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
├── api/                                 ← FR-033 (contract-first OpenAPI stubs)
│   ├── README.md
│   ├── gateway.openapi.yml
│   ├── user-service.openapi.yml
│   ├── restaurant-service.openapi.yml
│   ├── order-service.openapi.yml
│   ├── payment-service.openapi.yml
│   ├── notification-service.openapi.yml
│   └── delivery-service.openapi.yml
│
├── backend/                             ← FR-001
│   ├── Methy.slnx
│   ├── Directory.Build.props            ← FR-005
│   ├── Directory.Packages.props         ← FR-006
│   │
│   ├── src/
│   │   ├── Methy.Gateway/              ← API Gateway (port 5000)
│   │   │   ├── Methy.Gateway.csproj
│   │   │   ├── Program.cs
│   │   │   ├── Dockerfile              ← FR-009
│   │   │   ├── .dockerignore           ← FR-009
│   │   │   ├── appsettings.json        ← FR-008
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
├── e2e/                                 ← FR-041 (Playwright E2E tests)
│   ├── Methy.E2E.csproj
│   ├── playwright.config.ts
│   ├── Tests/
│   │   ├── OrderFlowTests.cs
│   │   └── (test files per user journey)
│   └── PageObjects/
│       └── (page object models)
│
├── frontend/                            ← FR-013
│   └── methy-app/                      ← Angular 21 workspace
│       ├── angular.json
│       ├── package.json
│       ├── tsconfig.json
│       └── src/
│           ├── app/
│           │   ├── app.config.ts       ← FR-015 (providers)
│           │   ├── app.routes.ts
│           │   ├── app.component.ts
│           │   ├── core/
│           │   │   ├── interceptors/   ← FR-015 (HttpInterceptorFn)
│           │   │   └── guards/         ← FR-015 (CanActivateFn)
│           │   ├── shared/             ← FR-015 (standalone shared components)
│           │   └── features/           ← FR-016
│           │       ├── restaurants/
│           │       ├── orders/
│           │       ├── delivery/
│           │       ├── admin/
│           │       └── profile/
│           ├── environments/           ← FR-017
│           │   ├── environment.ts
│           │   └── environment.development.ts
│           └── styles/
│               └── _theme.scss         ← FR-014
│
├── infra/
│   ├── docker/                         ← FR-010, FR-035, FR-040
│   │   ├── docker-compose.yml
│   │   ├── docker-compose.override.yml ← FR-012
│   │   ├── rabbitmq/
│   │   │   └── definitions.json       ← FR-036
│   │   └── sql/
│   │       └── init.sql               ← FR-037
│   │
│   ├── k8s/                            ← FR-018
│   │   ├── namespace.yaml
│   │   ├── deployments.yaml           ← FR-019
│   │   ├── services.yaml              ← FR-020
│   │   └── ingress.yaml               ← FR-021
│   │
│   └── observability/
│       ├── prometheus/
│       │   └── prometheus.yml         ← FR-022
│       ├── grafana/                   ← FR-023
│       │   └── provisioning/
│       └── jaeger/                    ← FR-024
│
├── postman/                             ← FR-043 (API testing collections)
│   ├── methy-gateway.postman_collection.json
│   ├── methy-user.postman_collection.json
│   ├── methy-restaurant.postman_collection.json
│   ├── methy-order.postman_collection.json
│   ├── methy-payment.postman_collection.json
│   ├── methy-notification.postman_collection.json
│   ├── methy-delivery.postman_collection.json
│   └── methy-local.postman_environment.json
│
├── scripts/                             ← FR-045 (dev automation)
│   ├── setup.ps1                        ← First-time environment setup
│   ├── seed-db.ps1                      ← Insert test/sample data
│   └── reset.ps1                        ← Nuke containers + rebuild
│
├── docs/
│   ├── architecture/                  ← FR-033 (ADRs, diagrams)
│   │   └── README.md
│   ├── guides/                        ← FR-033 (setup, contribution)
│   │   └── README.md
│   ├── folder-structure.md            ← Canonical folder structure reference
│   └── product-vision.md
│
└── specs/                              ← Speckit feature specifications
    └── 001-folder-structure-scaffolding/
        ├── spec.md
        └── checklists/
            └── requirements.md
```

### Backend Project Naming Convention

All backend project names follow this convention:

- **Gateway**: `Methy.Gateway`
- **Domain services**: `Methy.Services.<Domain>` (e.g., `Methy.Services.User`, `Methy.Services.Restaurant`)
- **Shared library**: `Methy.Shared`
- **Test projects**: `<SourceProjectName>.Tests` (e.g., `Methy.Services.User.Tests`)

Physical layout under `backend/`:

- Source projects live under `backend/src/<ProjectName>/`
- Test projects live under `backend/tests/<ProjectName>.Tests/`
- `Methy.slnx` at `backend/` root references all 16 projects with solution folders `src` and `tests`

---

## Success Criteria _(mandatory)_

### Measurable Outcomes

- **SC-001**: A developer with prerequisites installed can go from zero to a running local environment in under 15 minutes following the README (excluding initial Docker image pulls which depend on network speed)
- **SC-002**: `dotnet build` completes in under 30 seconds with zero errors and zero warnings across all 16 projects
- **SC-003**: `docker compose up` brings SQL Server, RabbitMQ, and microservice containers to a healthy state in under 60 seconds (images pre-pulled); `docker compose --profile observability up` brings the full stack (including Prometheus, Grafana, Jaeger) to healthy state in under 90 seconds
- **SC-004**: GitHub Actions build workflow completes in under 5 minutes on a standard push
- **SC-005**: 100% of the defined folder structure exists and matches the specification — verifiable by running a directory listing
- **SC-006**: Zero secrets or credentials appear in any committed file (verified by `git grep` or secret scanning)
- **SC-007**: All 7 Dockerfiles (one per runnable microservice; `Methy.Shared` is a library) build successfully to a runnable image (services may return 503 but must start)

---

## Assumptions

- Developer has all prerequisites installed as listed in the product vision document (Docker Desktop, .NET 10 SDK, Node.js 20 LTS, Angular CLI 19, Git)
- Docker Desktop has at least 8GB RAM allocated (16GB recommended for full stack including observability). Running `docker compose up` (no profile flag) starts core services comfortably on 8GB; adding `--profile observability` requires 16GB
- Ports 4200 (Angular), 1433 (SQL Server), 5672/15672 (RabbitMQ), 5000 (Gateway), 5001 (User), 5002 (Restaurant), 5003 (Order), 5004 (Payment), 5005 (Notification), 5006 (Delivery), 9090 (Prometheus), 3000 (Grafana), 16686 (Jaeger) are available on the local machine
- The project is being developed on Windows 10/11 with PowerShell as the primary shell
- No real payment gateway credentials are needed — payment service uses mock mode from day one
- Azure is completely out of scope for this feature; all infrastructure is local
- The Angular application does not need to communicate with real backend services in this phase — placeholder API URLs in environment files are sufficient
- Docker Hub credentials are not required for this scaffold — images are only built locally, not pushed

---

## Clarifications

### Session 2026-04-30

- Q: Should the Angular 21 scaffold use NgModule-based architecture (CoreModule/SharedModule) or standalone-first architecture? → A: Standalone-first (Angular 21 default) — no AppModule/CoreModule/SharedModule; providers via app.config.ts; standalone components throughout
- Q: Should Docker Compose use a single shared network or segmented networks (backend/monitoring)? → A: Single network — all containers on one `methy-network` bridge network (simplicity for Phase 1)
- Q: Which OS runner should GitHub Actions workflows use? → A: `ubuntu-latest` — 1:1 free-tier minute consumption, faster Docker builds, .NET 10 and Angular build cross-platform
- Q: What color palette should the Angular Material theme use? → A: Orange primary, Deep Purple accent — food delivery brand association, accessible contrast, both native Material Design 3 palettes; light and dark mode variants
- Q: Should microservice port assignments be fixed in the spec or deferred to planning? → A: Fixed — Gateway=5000, User=5001, Restaurant=5002, Order=5003, Payment=5004, Notification=5005, Delivery=5006
- Q: Why does docker.yml trigger on every push rather than only on PRs? → A: Triggers alongside build.yml on every push to catch broken Dockerfiles immediately, not only at PR time
