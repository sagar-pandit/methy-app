## Why monorepo for microservices?

**Short answer**: "Because it's a learning project with one developer, and the alternative (polyrepo) adds operational overhead that teaches nothing new at this stage."

## The real-world trade-off

| | Monorepo (what you have) | Polyrepo (repo per service) |
|---|---|---|
| **When it works** | Small teams, single owner, early stages | Large orgs, independent teams per service |
| **CI/CD** | One pipeline sees all changes | Each service has its own pipeline |
| **Cross-cutting changes** | One PR (update shared lib → all services) | 7+ PRs coordinated across repos |
| **Refactoring** | Atomic — rename an API contract + all consumers in one commit | Multi-repo PRs, version bumps, compatibility hell |
| **Discoverability** | `git clone` → everything | Clone 10+ repos, figure out relationships |
| **Who does this** | Google, Meta, Microsoft (eShop), Uber | Netflix, Amazon, Spotify |

## Your specific justification

1. **Single developer** — polyrepo coordination overhead (versioning shared libs via NuGet feed, syncing API contracts across repos) teaches *git operations*, not *architecture*
2. **Learning project** — you need to see the whole system in one place to understand how pieces connect
3. **Constitution Principle II (Simplicity)** — YAGNI. You don't have 7 teams needing independent deploy cadences
4. **Atomic CI** — one push validates backend + frontend + infra together. A broken API contract is caught immediately, not 3 days later when another team discovers it
5. **Same architecture** — the code inside is still microservices (independent projects, separate Dockerfiles, independent deployments). The *repo boundary* doesn't define the *service boundary*

## When to split

You'd move to polyrepo **only** when:
- Multiple teams need independent release schedules
- CI takes 30+ minutes because of repo size
- Access control per service matters (different teams, different permissions)

None of these apply here. The architecture is microservices. The repository strategy is monorepo. They're orthogonal decisions.

**TL;DR**: "Monorepo is the container for the code. Microservices are the architecture of the code. Google runs thousands of microservices in one repo. The two decisions are independent."