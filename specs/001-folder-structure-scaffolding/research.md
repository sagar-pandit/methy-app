# Phase 0 Research: Folder Structure Scaffolding

**Feature**: 001-folder-structure-scaffolding
**Date**: 2026-05-01
**Status**: Complete — no NEEDS CLARIFICATION items found in spec

The spec is fully clarified (Session 2026-04-30). This document records confirmed technology decisions and best practices for reference during implementation.

---

## Decision 1: .NET 10 Solution Layout

**Decision**: Use `Directory.Build.props` + `Directory.Packages.props` at `backend/` root with `src/` and `tests/` subdirectories.

**Rationale**: `Directory.Build.props` propagates shared MSBuild properties (TargetFramework, Nullable, ImplicitUsings, TreatWarningsAsErrors) to all projects without duplication. `Directory.Packages.props` enables centralized NuGet versioning — every project omits `Version=` from `<PackageReference>`; the single props file is the version source of truth. This is the `.NET 10` recommended monorepo pattern.

**Key settings in `Directory.Build.props`**:
```xml
<TargetFramework>net10.0</TargetFramework>
<Nullable>enable</Nullable>
<ImplicitUsings>enable</ImplicitUsings>
<TreatWarningsAsErrors>true</TreatWarningsAsErrors>
```

**`Directory.Packages.props`**:
```xml
<ManagePackageVersionsCentrally>true</ManagePackageVersionsCentrally>
```

**Alternatives considered**: Per-project props files — rejected because they create version drift and duplicate boilerplate across 16 projects.

---

## Decision 2: ASP.NET Core 10 Minimal API Health Check

**Decision**: Use `app.MapHealthChecks("/health")` with a custom JSON response in each `Program.cs`.

**Rationale**: Built-in .NET health check infrastructure provides a standard `/health` endpoint. Returning `{"status": "Healthy"}` (HTTP 200) satisfies Docker `HEALTHCHECK`, Kubernetes liveness probes, and Prometheus blackbox exporter without any external dependencies. No NuGet packages required beyond `Microsoft.Extensions.Diagnostics.HealthChecks` (included in ASP.NET Core SDK).

**Pattern**:
```csharp
builder.Services.AddHealthChecks();
app.MapHealthChecks("/health", new HealthCheckOptions
{
    ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
});
```
*(Simplified to JSON inline writer for scaffold — no `AspNetCore.HealthChecks.UI.Client` dependency)*

**Alternatives considered**: Custom middleware — rejected as over-engineering for a scaffold.

---

## Decision 3: Multi-Stage Dockerfile Pattern for .NET 10

**Decision**: Two-stage Dockerfile: `build` stage uses `mcr.microsoft.com/dotnet/sdk:10.0`, `runtime` stage uses `mcr.microsoft.com/dotnet/aspnet:10.0`.

**Rationale**: Multi-stage builds produce minimal production images (SDK ~900MB vs ASPNet ~250MB). Build artifacts are not included in the final image. This is the official Microsoft-recommended pattern.

**Pattern**:
```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Methy.Services.User.dll"]
```

**Alternatives considered**: Single-stage SDK image — rejected; 3.5x larger final image, SDK tools present in production.

---

## Decision 4: Docker Compose V2 Format

**Decision**: No top-level `version:` key (Docker Compose V2+ format). All services on a single `methy-network` bridge. Two profiles: no-profile (core) and `observability`.

**Rationale**: `version:` key is deprecated in Compose V2 and generates a warning. Single network keeps service discovery simple via container names (Phase 1 learning goal). Profile separation allows 8GB RAM machines to run core services without the ~2GB observability overhead.

**Core services** (no profile): SQL Server 2022, RabbitMQ with management, API Gateway, 6 domain services.
**Observability profile**: Prometheus, Grafana, Jaeger all-in-one.

**Alternatives considered**: Separate `docker-compose.observability.yml` — rejected; managing multiple compose files with `-f` flag is more complex than profiles.

---

## Decision 5: Angular 19 Standalone-First Architecture

**Decision**: No NgModules (no AppModule, CoreModule, SharedModule). `app.config.ts` for providers. All components are standalone. Functional interceptors (`HttpInterceptorFn`) and guards (`CanActivateFn`, `CanMatchFn`).

**Rationale**: Angular 19 default scaffolding is standalone-first. Avoids the NgModule boilerplate that Angular 17+ deprecates. Functional interceptors/guards are simpler to test (pure functions). This is the "right way" for Angular 19 and aligns with Constitution Principle I (Learning First — learn the current paradigm).

**Alternatives considered**: NgModule-based architecture — rejected; Angular team has deprecated NgModules as the primary pattern as of Angular 17.

---

## Decision 6: Angular Material 3 Custom Theme

**Decision**: Use `mat.define-theme()` with `$color` parameter using `mat.m3-theme-palette-from-preset()` for Orange (primary) and Deep Purple (tertiary). Apply with `mat.theme()` mixin in `_theme.scss`. Both light and dark color schemes via `prefers-color-scheme` media query.

**Rationale**: Angular Material 3 (MDC-based) requires M3 theming API — the legacy `mat-palette()` approach is incompatible. Orange and Deep Purple are first-class M3 color preset palettes with full tonal range support. Using `prefers-color-scheme` follows the M3 spec and avoids custom class toggle complexity at scaffold stage.

**Key SCSS pattern**:
```scss
@use '@angular/material' as mat;

$methy-theme: mat.define-theme((
  color: (
    theme-type: light,
    primary: mat.$orange-palette,
    tertiary: mat.$deep-purple-palette,
  ),
));

html {
  @include mat.theme($methy-theme);
}

@media (prefers-color-scheme: dark) {
  html {
    @include mat.theme(mat.define-theme((
      color: (
        theme-type: dark,
        primary: mat.$orange-palette,
        tertiary: mat.$deep-purple-palette,
      ),
    )));
  }
}
```

**Alternatives considered**: Legacy `mat.define-light-theme()` — rejected; incompatible with M3 component system in Angular Material 3.

---

## Decision 7: GitHub Actions on ubuntu-latest

**Decision**: `ubuntu-latest` for all workflows (build.yml, docker.yml, deploy.yml).

**Rationale**: GitHub free tier bills Linux at 1:1 minute ratio (Windows = 2x, macOS = 10x). .NET 10 and Angular 19 both build cross-platform. Docker builds on Linux are faster. 2000 free minutes/month provides ample CI budget for Phase 1 development pace.

**Alternatives considered**: `windows-latest` — rejected; 2x minute consumption, no benefit for a cross-platform stack.

---

## Decision 8: Husky + Commitlint + lint-staged

**Decision**: Root-level `package.json` with Husky v9, lint-staged v15, commitlint v19. `pre-commit` runs lint-staged; `commit-msg` runs commitlint.

**Rationale**: Enforces conventional commit format (`feat:`, `fix:`, `docs:`, `chore:`, etc.) and code formatting at commit time — before CI. This is the industry-standard Node.js toolchain for polyglot repos. Using a root-level `package.json` separates git-hook tooling from the Angular app's `package.json`.

**Lint-staged config**:
- `*.cs` → `dotnet format --include <files> --verify-no-changes`
- `*.{ts,html,scss}` → `eslint --fix` + `prettier --write`

**Alternatives considered**: `.NET Husky` (C# alternative) — rejected; less ecosystem support; the Node.js toolchain is the standard and the project already has a Node.js frontend.

---

## Decision 9: OpenAPI 3.0 Stubs (Contract-First)

**Decision**: Hand-authored OpenAPI 3.0 YAML stubs in `api/` per service, each with `info`, `servers`, and a single `GET /health` path. Validated with `swagger-cli` or online validator.

**Rationale**: Constitution Principle IV mandates API-first design — contracts before implementation. A minimal valid OpenAPI file establishes the pattern (service name, version, server URL) that will be expanded in later phases. `GET /health` is the only endpoint that exists at scaffold time.

**Alternatives considered**: Auto-generating from Swashbuckle — rejected; Swashbuckle requires running code; scaffold has no business logic yet.

---

## Decision 10: Playwright .NET for E2E (Standalone Project)

**Decision**: `e2e/Methy.E2E.csproj` targets `.NET 10`, references `Microsoft.Playwright` NuGet, uses XUnit as the test framework. NOT added to `Methy.sln` — runs independently against the full running stack.

**Rationale**: Playwright for .NET is the constitution-approved E2E tool (Principle III). Keeping it outside `Methy.sln` prevents accidental `dotnet test` runs in CI before the full stack is running. Page Object Model pattern (`PageObjects/` folder) teaches maintainable E2E testing.

**Alternatives considered**: Including in Methy.sln — rejected; would require `dotnet test` to skip E2E project in unit/integration CI step, adding complexity. Playwright TypeScript — rejected; C# is the primary language, keeping it consistent with backend skills.
