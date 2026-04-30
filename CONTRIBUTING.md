# Contributing to Methy

Thank you for contributing! This guide covers everything you need to get started.

## Branch Naming

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/<description>` | `feature/002-user-auth` |
| Bug fix | `fix/<description>` | `fix/health-check-timeout` |
| Documentation | `docs/<description>` | `docs/update-api-stubs` |
| Chore | `chore/<description>` | `chore/update-dependencies` |

## Commit Messages

This repo enforces [Conventional Commits](https://www.conventionalcommits.org/) via Husky + commitlint.

**Format**: `<type>(<scope>): <description>`

| Type | When to use |
|------|------------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `chore` | Tooling, dependencies, config |
| `refactor` | Code change that isn't a fix or feature |
| `test` | Adding or updating tests |
| `ci` | CI/CD workflow changes |

**Examples**:
```
feat(user-service): add JWT authentication middleware
fix(docker): correct SQL Server health check command
docs(readme): add troubleshooting section for port conflicts
chore(deps): update @angular/material to 19.2.0
```

## Pull Request Workflow

1. Create a feature branch from `main`
2. Implement your change with atomic commits
3. Ensure all quality gates pass locally (see below)
4. Open a PR — the template will guide you through the checklist
5. Request review from at least one other contributor
6. Squash-merge after approval

## Code Quality Gates

Before opening a PR, all of the following must pass:

```powershell
# Backend
cd backend
dotnet build Methy.sln          # Zero errors, zero warnings
dotnet test                      # All tests pass
dotnet format Methy.sln --verify-no-changes   # No formatting issues

# Frontend
cd frontend/methy-app
ng build                         # Builds without errors
ng lint                          # ESLint passes

# Docker
cd infra/docker
docker compose build             # All 7 images build
```

**No TODO items** may be merged without a linked GitHub issue number.

## Running the Full Local Stack

See [README.md](README.md) for the quick-start guide, or [scripts/setup.ps1](scripts/setup.ps1) for the automated setup script.
