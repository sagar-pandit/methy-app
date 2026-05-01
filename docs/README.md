# Methy Documentation

Architecture decisions, technical guides, and product context.

## Contents

| Folder                         | Description                                                                            |
| ------------------------------ | -------------------------------------------------------------------------------------- |
| [architecture/](architecture/) | Architectural Decision Records (ADRs), folder structure rationale, and design diagrams |
| [guides/](guides/)             | Setup, onboarding, and contribution playbooks                                          |
| [prompts/](prompts/)           | Raw and refined prompts used during Speckit planning sessions                          |

## Key Documents

- [Product Vision](product-vision.md) — high-level goals and domain context
- [Folder Structure](architecture/folder-structure.md) — monorepo layout explanation
- [Why Monorepo?](architecture/why-monorepo.md) — ADR for monorepo vs polyrepo decision

## Adding Documentation

- Place ADRs in `architecture/` with prefix `adr-NNN-short-title.md`
- Use Markdown tables and code blocks for technical specs
- Keep docs close to the code they describe (prefer `README.md` in each service folder)
