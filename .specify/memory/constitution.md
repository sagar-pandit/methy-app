<!-- Sync Impact Report
  Version: 0.0.0 → 1.0.0
  Modified principles: N/A (initial creation)
  Added sections: Core Principles (7), Technology Stack, Development Workflow, Governance
  Removed sections: None
  Templates requiring updates:
    - .specify/templates/plan-template.md ✅ No changes needed (Constitution Check section already exists)
    - .specify/templates/spec-template.md ✅ No changes needed (generic template)
    - .specify/templates/tasks-template.md ✅ No changes needed (generic template)
  Follow-up TODOs: None
-->

# Methy Constitution

## Core Principles

### I. Learning First (NON-NEGOTIABLE)

Every implementation decision MUST prioritize understanding over optimization. Code MUST serve as both functional software and educational reference. Pattern adoption MUST be justified by learning value, not production necessity. Over-engineering for hypothetical scale is prohibited. Features exist to teach, not to ship.

**Rationale**: This is a learning project. If a decision does not advance skill development, it does not belong here.

### II. Simplicity & Clarity

All code MUST be readable without extensive comments. Choose clarity over cleverness in every case. YAGNI (You Aren't Gonna Need It) applies strictly—implement only what the current phase requires. Abstractions MUST be introduced only when concrete duplication exists (Rule of Three). Method/function length SHOULD stay under 20 lines; classes under 200 lines.

**Rationale**: Complex code obscures learning. Simple code teaches by being self-evident.

### III. Test-Driven Quality

Tests MUST accompany all new code. Minimum 70% code coverage across the codebase. Backend: XUnit for unit and integration tests. Frontend: Jasmine/Jest for unit tests, Playwright/Cypress for E2E. Tests MUST be independently runnable without external services (use mocks/test doubles). CI pipeline MUST fail on test failures—no exceptions.

**Rationale**: Tests provide immediate feedback, catch regressions, and document expected behavior. They are the safety net that enables confident refactoring.

### IV. API-First Design

All microservice interfaces MUST be defined as OpenAPI/Swagger contracts before implementation begins. Backend and frontend MUST communicate exclusively through documented REST APIs. API versioning strategy MUST be established and followed. Breaking changes MUST be communicated through version increments. All endpoints MUST include request/response validation.

**Rationale**: API contracts decouple frontend and backend development, enable parallel work, and enforce clear service boundaries.

### V. Security by Default

Secrets MUST NEVER be committed to version control—use dotnet user-secrets, .env files (gitignored), or GitHub Secrets. All inputs MUST be validated at system boundaries. JWT authentication MUST be implemented for all protected endpoints. HTTPS MUST be enforced. SQL injection, XSS, and CSRF protections are mandatory. Dependencies MUST be kept updated to patch known vulnerabilities.

**Rationale**: Security is not a feature to add later; it is a discipline from day one. Insecure patterns in learning code become insecure habits in production.

### VI. Observable Systems

All services MUST implement structured logging via .NET ILogger with Serilog. Distributed tracing MUST be enabled across microservice boundaries (Jaeger). Health check endpoints MUST exist for every service. Prometheus metrics MUST be exposed for key operations. Errors MUST be logged with sufficient context for debugging without reproducing.

**Rationale**: Observability skills are critical for production systems. Building them from the start ensures they are learned thoroughly, not bolted on.

### VII. Local-First Development (NON-NEGOTIABLE)

All development MUST run on local infrastructure with zero cloud costs. Azure services are DEFERRED until post-AZ-900 certification. Local equivalents MUST be used: Minikube (Kubernetes), RabbitMQ (messaging), SQL Server Developer (database), Docker Hub (registry), Grafana/Prometheus/Jaeger (monitoring). No feature or task may require Azure spending. Cloud integration is reserved for optional future Phase 9+.

**Rationale**: Azure budget ($50/month) is dedicated to AZ-900 certification. Local tools provide identical learning outcomes at zero cost with skills that transfer directly to any cloud platform.

## Technology Stack

**Frontend**: Angular 19 LTS + Angular Material (Material Design 3)
- State management: Angular Signals (primary); NgRx only if justified
- Testing: Jasmine/Jest (unit), Playwright/Cypress (E2E)
- Build: Angular CLI, TypeScript strict mode

**Backend**: .NET 10 LTS (ASP.NET Core Web API)
- ORM: Entity Framework Core
- Testing: XUnit
- Resilience: Polly (circuit breaker, retry)
- Logging: Serilog + ILogger

**Database**: SQL Server 2022 Developer Edition (local)

**Infrastructure** (all local):
- Docker Desktop + Docker Compose
- Minikube (Kubernetes)
- RabbitMQ (message broker)
- Nginx/Traefik (load balancer/ingress)

**CI/CD**: GitHub Actions (free tier: 2000 minutes/month)

**Observability**: Grafana + Prometheus + Jaeger (all containerized locally)

**IDE**: Visual Studio Code + GitHub Copilot (Speckit)

## Development Workflow

**Version Control**:
- Git + GitHub with feature branch workflow
- Branch naming: `feature/[description]`, `fix/[description]`, `docs/[description]`
- Commits MUST be atomic with descriptive messages (conventional commits preferred)
- No force-pushing to main branch

**Code Quality Gates**:
- All tests MUST pass before merge
- Linting MUST pass (ESLint for Angular, Roslyn analyzers for .NET)
- Swagger documentation MUST be current
- No TODO items in merged code without linked issue

**Phase Progression**:
- Each implementation phase MUST complete its deliverables before advancing
- Phase completion MUST include documentation update
- Architecture decisions MUST be recorded (ADRs)

**Docker & Containers**:
- Every microservice MUST have a Dockerfile
- docker-compose.yml MUST bring up the full local environment
- Container images MUST use multi-stage builds for minimal size
- Health checks MUST be defined in Docker configuration

## Governance

This constitution supersedes all ad-hoc decisions. Any development practice, tool choice, or architectural decision MUST align with these principles. Conflicts are resolved by referencing principles in priority order (I through VII).

**Amendment Process**:
1. Propose change with rationale and impact assessment
2. Evaluate against learning objectives and project constraints
3. Document amendment with version increment
4. Update affected templates and documentation

**Versioning Policy**:
- MAJOR: Principle removal, redefinition, or backward-incompatible governance change
- MINOR: New principle, materially expanded guidance, or new section
- PATCH: Clarifications, wording improvements, non-semantic refinements

**Compliance**:
- All code reviews MUST verify principle adherence
- Plan template Constitution Check MUST reference active principles
- Complexity MUST be justified against Principle II (Simplicity)
- Cloud resource usage MUST be justified against Principle VII (Local-First)

**Version**: 1.0.0 | **Ratified**: 2026-04-30 | **Last Amended**: 2026-04-30
