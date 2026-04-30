# Methy Food Delivery Platform - Product Vision Document

**Version**: 1.0  
**Date**: April 30, 2026  
**Status**: Approved  
**Document Owner**: Sagar Pandit  
**Last Review**: April 30, 2026

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Vision Statement](#vision-statement)
3. [Problem Statement](#problem-statement)
4. [Target Audience](#target-audience)
5. [Prerequisites](#prerequisites)
6. [Product Goals & Objectives](#product-goals--objectives)
7. [Key Features & Capabilities](#key-features--capabilities)
8. [Success Metrics](#success-metrics)
9. [Technical Strategy](#technical-strategy)
10. [Development Environment & Tools](#development-environment--tools)
11. [Implementation Roadmap](#implementation-roadmap)
12. [Risk Management](#risk-management)
13. [Cost Estimates](#cost-estimates)
14. [Key Principles](#key-principles)
15. [Success Criteria](#success-criteria)
16. [Resources & References](#resources--references)
17. [FAQ](#faq)
18. [Conclusion](#conclusion)
19. [Document Control](#document-control)

---

## How to Use This Document

This product vision document serves as the **strategic foundation** for the Methy food delivery platform. It should be:

- **Referenced** before starting any development phase
- **Updated** when scope, technology, or goals change
- **Shared** with all team members and stakeholders
- **Reviewed** quarterly or at major milestones

**Target Readers**: Developers, architects, DevOps engineers, technical leads, and learners participating in the project.

### Quick Start

**New to the project? Start here:**

1. 📖 **Read**: [Executive Summary](#executive-summary) and [Vision Statement](#vision-statement)
2. ✅ **Check**: [Prerequisites](#prerequisites) to ensure readiness
3. 🎯 **Review**: [Product Goals & Objectives](#product-goals--objectives) to understand learning outcomes
4. 🗺️ **Plan**: Review [Implementation Roadmap](#implementation-roadmap) to see the journey
5. 🚀 **Begin**: Start with [Phase 1: Foundation](#phase-1-foundation-weeks-1-4)

---

## Executive Summary

Methy is an enterprise-grade food delivery platform designed as a comprehensive learning ecosystem for modern software development. While architected as a production-inspired application, its primary purpose is to serve as a hands-on training ground for mastering full-stack development, cloud-native architecture, and DevOps practices using industry-standard technologies.

This project bridges the gap between theoretical knowledge and practical expertise by implementing real-world patterns and technologies in a controlled, learning-focused environment.

**Key Differentiator**: Methy uses a **100% local development approach**, allowing you to learn enterprise cloud patterns using free tools (Docker Desktop, Minikube, SQL Server Developer Edition, RabbitMQ, GitHub Actions) with **zero cloud costs**. 
---

## Vision Statement

**"Build production-quality software skills through hands-on implementation of a modern food delivery platform."**

Methy empowers developers to progress from basic to senior-level proficiency across the entire modern software development lifecycle—from frontend and backend engineering to cloud infrastructure, CI/CD automation, and observability—all while creating a functional, well-architected application.

---

## Problem Statement

### The Challenge
Developers often struggle to bridge the gap between learning isolated technologies and understanding how they work together in real-world, enterprise-grade systems. Traditional tutorials focus on toy examples, while production systems are too complex for learning purposes.

### Our Solution
Methy provides a "Goldilocks" learning environment—complex enough to demonstrate industry best practices, simple enough to understand and implement progressively. It offers:

- **Structured complexity**: Real-world patterns without production overhead
- **Progressive learning**: Start simple, evolve to advanced
- **Hands-on experience**: Learn by building, not just reading
- **Modern stack**: Current, in-demand technologies
- **Complete lifecycle**: From code to deployment

---

## Target Audience

### Primary Users
- **Aspiring Full-Stack Developers**: Building comprehensive skills
- **Backend Developers**: Learning .NET 10 and microservices architecture
- **Frontend Developers**: Advancing Angular 19 expertise
- **DevOps Engineers**: Implementing CI/CD and cloud infrastructure
- **Self-learners**: Using GitHub Copilot and modern AI-assisted development

### Skill Level Progression
- **Entry Point**: Basic understanding of web development
- **Target Achievement**: Senior developer capabilities across the stack
- **Advanced Topics**: Lead-level backend architecture and cloud-native patterns

---

## Prerequisites

Before starting this project, participants should have:

### Required Knowledge
- ✅ **Programming Fundamentals**: Variables, loops, functions, OOP concepts
- ✅ **Web Basics**: HTTP protocol, REST APIs, JSON
- ✅ **Version Control**: Basic Git commands (clone, commit, push, pull)
- ✅ **Command Line**: Navigation, running commands

### Recommended Experience
- 📚 Basic exposure to any modern web framework (Angular, React, Vue)
- 📚 Familiarity with C# or similar object-oriented language
- 📚 Understanding of databases and SQL
- 📚 Basic Docker concepts (helpful but not required)

### Technical Setup
- 💻 **Computer**: Windows 10/11, 8GB RAM minimum (16GB recommended for Docker)
- 💻 **Required Software**: 
  - Visual Studio Code with extensions
  - Node.js 20 LTS (pinned via `.nvmrc`)
  - .NET 10 SDK
  - Docker Desktop (primary development environment)
  - Git for Windows
- 💻 **Local Development Tools**:
  - SQL Server 2022 Developer Edition (free)
  - Minikube (free Kubernetes)
  - RabbitMQ (free message queue)
- 💻 **Required Accounts**:
  - Docker Hub Account: Free (for image registry)
  - GitHub Account: Free (for version control and CI/CD)
- 💻 **Azure Account Status**:
  - ⏸️ **Deferred**: $50/month subscription reserved for AZ-900 certification practice
  - ⏸️ **Future Consideration**: Azure integration will be added after AZ-900 completion
  - ✅ **Current Approach**: 100% local development with zero cloud costs

### Time Commitment
- ⏰ **Estimated Total**: 300-400 hours (36 weeks × 8-12 hours/week)
- ⏰ **Flexibility**: Self-paced learning with milestone checkpoints
- ⏰ **Accelerated Path**: 6 months full-time equivalent

---

## Product Goals & Objectives

### Learning Objectives

1. **Frontend Mastery**
   - Progress from basic to senior-level Angular 19 proficiency
   - Master Angular Material Design components and theming
   - Implement component architecture, state management, and testing
   - Apply security best practices (XSS prevention, CSP, secure HTTP)

2. **Backend Excellence**
   - Achieve lead-level expertise in .NET 10 Web API development
   - Master Entity Framework Core and database design
   - Implement microservices architecture and design patterns

3. **Cloud-Native Development** ⏸️ *Deferred for Future*
   - ⏸️ Azure integration deferred (reserved for AZ-900 practice)
   - ✅ Learn cloud-native patterns using local alternatives
   - ✅ Container orchestration with Minikube
   - ✅ Serverless concepts with Azure Functions Core Tools (local)
   - ✅ Message queuing with RabbitMQ
   - 🔮 **Future**: Migrate to Azure after AZ-900 certification

4. **DevOps & Automation**
   - Build complete CI/CD pipelines from scratch
   - Implement Infrastructure as Code (IaC)
   - Master Docker containerization and Kubernetes deployment

5. **Software Engineering Excellence**
   - Apply SOLID principles and design patterns
   - Implement comprehensive testing strategies
   - Build observable, resilient, production-quality systems

### Technical Objectives

- ✅ API-first, microservices-based architecture
- ✅ Event-driven design with message queues
- ✅ Automated testing at all levels
- ✅ Containerized deployments
- ✅ Distributed tracing and observability
- ✅ Security-first implementation
- ✅ Clean, maintainable codebase

---

## Key Features & Capabilities

### Application Features (Food Delivery Domain)

#### Customer Experience
- Browse restaurants and menus with Material cards and lists
- Search and filter options using Material form controls
- Place and track orders with Material steppers and progress indicators
- Payment processing with Material dialogs and forms
- Order history and favorites using Material tables and chips

#### Restaurant Management
- Menu management with Material CRUD forms
- Order fulfillment with Material kanban boards
- Real-time notifications using Material snackbars and badges
- Analytics dashboard with Material charts and cards

#### Delivery Operations
- Driver assignment
- Route optimization
- Real-time tracking
- Delivery status updates

### Technical Capabilities

#### Frontend (Angular 19 + Material Design)
- **UI Framework**: Material Design 3 components (buttons, cards, dialogs, tables, forms)
- **Responsive Design**: Mobile-first approach with Material layout system (flexbox, grid)
- **Accessibility**: WCAG 2.1 AA compliance, ARIA labels, keyboard navigation
- **Theming**: Custom color palettes, typography, dark mode support
- **State Management**: Angular Signals (primary) or NgRx for complex scenarios
- **Real-time Features**: WebSocket integration for live order updates
- **PWA Capabilities**: Offline support, push notifications, installable app
- **Testing**: Unit tests (Jasmine/Jest), component tests, E2E (Playwright/Cypress)
- **Performance**: Lazy loading, virtual scrolling, optimized change detection

#### Backend (.NET 10 Microservices)
- RESTful Web APIs
- Microservices decomposition:
  - User Service
  - Restaurant Service
  - Order Service
  - Payment Service
  - Notification Service
  - Delivery Service
- API Gateway pattern
- Event-driven communication
- Entity Framework Core with SQL Server 2022

#### Cloud & Infrastructure (100% Local)
- **Local Development Stack** (Active):
  - Docker Desktop for containerization
  - Minikube for Kubernetes orchestration
  - RabbitMQ for message queue and event-driven patterns
  - SQL Server Developer Edition for database
  - Docker Hub for container registry (free)
  - Local secrets management (dotnet user-secrets, .env files)
  - Azure Functions Core Tools for local serverless development

- **Azure Services** ⏸️ *Deferred for Future*:
  - ⏸️ **Status**: All Azure services deferred (budget reserved for AZ-900)
  - ⏸️ **Reason**: $50/month subscription dedicated to certification practice
  - 🔮 **Future Phase**: After AZ-900 completion
    - Azure Service Bus (message queue)
    - Azure Functions (serverless)
    - Azure Static Web Apps (frontend hosting)
    - Azure Container Registry (ACR)
    - Azure Key Vault (secrets management)
    - Azure Kubernetes Service (AKS)
  - ✅ **Learning Impact**: Zero - all patterns learned with local alternatives

#### CI/CD Pipeline
- Automated builds and testing
- Docker image creation
- Multi-stage deployments (dev → staging → production)
- Infrastructure as Code (Bicep/Terraform)
- Automated rollback capabilities

#### Observability & Monitoring
- Centralized logging (ILogger)
- Distributed tracing (Jaeger)
- Metrics and dashboards (Prometheus + Grafana)
- Health checks and probes
- Real-time alerting

#### Security
- JWT-based authentication
- Role/policy-based authorization
- HTTPS enforcement
- Input validation and sanitization
- Secrets management in pipelines
- CORS policies and rate limiting

---

## Success Metrics

### Learning Outcomes
- ✅ Complete working application demonstrating all technologies
- ✅ Comprehensive test coverage (>70% code coverage)
- ✅ Successful deployments through automated CI/CD
- ✅ Observable system with metrics and tracing
- ✅ Security best practices implemented throughout

### Technical Achievements
- ✅ Microservices independently deployable
- ✅ Zero-downtime deployments
- ✅ Sub-second API response times
- ✅ Resilient error handling (circuit breakers, retries)
- ✅ Complete API documentation (Swagger/OpenAPI)

### Skill Development Milestones
| Technology | Starting Level | Target Level | Key Competencies |
|------------|---------------|--------------|------------------|
| Angular | Basic | Senior | Component architecture, RxJS, state management, testing |
| .NET/C# | Intermediate | Lead | Microservices, async patterns, EF Core, SOLID principles |
| Docker/K8s | Novice | Advanced | Containerization, orchestration, deployments, troubleshooting |
| CI/CD | Novice | Advanced | GitHub Actions, automated testing, deployment strategies |
| Observability | Novice | Advanced | Logging, tracing, metrics, dashboards (Grafana/Prometheus) |
| Azure Cloud | N/A | ⏸️ Deferred | (future consideration) |

### Progress Tracking

**Learning Metrics** (Self-Assessment):
- 📊 **Code Reviews**: Peer feedback on completed features
- 📊 **Knowledge Checks**: End-of-phase quizzes or practical exercises
- 📊 **Portfolio**: Documented GitHub repository with commit history
- 📊 **Reflection**: Weekly learning journals or blog posts

**Milestone Celebrations**:
- 🎯 **Phase Completion**: Mark each phase done with a summary
- 🎯 **Feature Demos**: Record demos of working features
- 🎯 **Skill Badges**: Create personal skill progression chart
- 🎯 **Knowledge Sharing**: Write blog posts or give presentations

---

## Technical Strategy

### High-Level Architecture

The Methy platform follows a **cloud-native microservices architecture**:

```
┌─────────────────────────────────────────────────────────┐
│                    Angular Frontend                     │
│            (Material Design + PWA)                      │
└────────────────────┬────────────────────────────────────┘
                     │ HTTPS
                     ↓
┌─────────────────────────────────────────────────────────┐
│                    API Gateway                          │
│              (Authentication, Routing)                  │
└────────────────────┬────────────────────────────────────┘
                     │
        ┌────────────┼────────────┬─────────────┐
        ↓            ↓            ↓             ↓
    ┌───────┐   ┌───────┐   ┌───────┐    ┌─────────┐
    │ User  │   │Restaurant│ │ Order │    │Delivery │
    │Service│   │ Service│   │Service│    │Service  │
    └───┬───┘   └───┬───┘   └───┬───┘    └────┬────┘
        │           │           │             │
        └───────────┴───────────┴─────────────┘
                     │
        ┌────────────┼────────────┐
        ↓            ↓            ↓
    ┌────────┐  ┌──────────┐  ┌─────────┐
    │SQL     │  │ RabbitMQ │  │ Docker  │
    │Server  │  │ (Message │  │ (Local  │
    │        │  │  Broker) │  │  Infra) │
    └────────┘  └──────────┘  └─────────┘
```

**Reference**: Detailed architecture diagrams will be created in Phase 1.

---

### Architecture Principles

#### 1. Microservices Architecture
- Domain-driven service boundaries
- Independent deployment and scaling
- API Gateway for unified entry point
- Service-to-service communication via events and APIs

#### 2. Event-Driven Design
- RabbitMQ for asynchronous messaging (local-first; Azure Service Bus deferred)
- Saga pattern for distributed transactions
- Event sourcing where appropriate
- Dead-letter queues for failed messages

#### 3. Design Patterns & Best Practices
- **SOLID Principles**: Foundation for all code
- **Repository Pattern**: Data access abstraction
- **Factory Pattern**: Object creation management
- **Circuit Breaker**: Prevent cascading failures
- **Retry Policies**: Transient fault handling with Polly

#### 4. API Design
- RESTful conventions
- OpenAPI/Swagger documentation
- Versioning strategy (URL or header-based)
- Pagination for large datasets
- HATEOAS principles where applicable

#### 5. Testing Strategy
```
Frontend (Angular):
├── Unit Tests (Components, Services, Pipes)
├── Integration Tests (Feature modules)
└── E2E Tests (Critical user flows)

Backend (.NET):
├── Unit Tests (Business logic, validators)
├── Integration Tests (API endpoints, database)
├── Contract Tests (Microservice boundaries)
└── Load Tests (Performance baselines)
```

### Technology Decisions

#### Why .NET 10?
- Long-term support (LTS) release
- Industry-leading performance
- Comprehensive ecosystem
- Strong typing and tooling
- Enterprise adoption

#### Why Angular 19 + Material Design?
- Enterprise framework with strong conventions
- Angular Material provides production-ready, accessible UI components
- Material Design 3 offers modern, consistent design language
- TypeScript for type safety
- Comprehensive tooling and CLI
- Component-based architecture
- Built-in theming and responsive design
- Long-term support (LTS)

#### Why Defer Azure? ⏸️
- **Primary Reason**: $50/month subscription dedicated to AZ-900 certification prep
- **Learning Strategy**: Master cloud-native patterns locally first
- **Local Equivalents**: RabbitMQ, Minikube, Docker provide identical learning
- **Future Integration**: Post-AZ-900 completion (Phase 9+)
- **Zero Impact**: All skills transfer directly to Azure when ready
- **Cost Savings**: $0/month for entire development phase

#### Why Local-First Development?
- Learn at your own pace without cost pressure
- Identical skills to cloud platforms (portable knowledge)
- No distractions from certification studies
- Easy migration path when Azure budget becomes available

#### Why Docker + Kubernetes?
- Industry-standard containerization
- Consistent dev/prod environments
- Orchestration capabilities
- Cloud-agnostic skills
- Microservices enablement

---

## Development Environment & Tools

### Local Development
- **IDE**: Visual Studio Code with GitHub Copilot (Speckit)
- **Version Control**: Git + GitHub
- **Frontend**: Angular CLI, Angular Material (npm packages)
- **Database**: SQL Server 2022 (local installation)
- **Containerization**: Docker Desktop
- **API Testing**: Swagger UI, Postman, or REST Client

### Cloud Infrastructure

#### Azure Services Status ⏸️ DEFERRED
- **Azure Subscription**: $50/month reserved for AZ-900 certification practice
- **Implementation Strategy**: 100% local development, zero Azure usage
- **Future Migration**: After AZ-900 completion (estimated Phase 9+)
- **Learning Impact**: None - local tools provide identical learning outcomes

#### Active Local Infrastructure
- **Container Registry**: Docker Hub (free)
- **Orchestration**: Minikube (local Kubernetes)
- **Messaging**: RabbitMQ (local message broker)
- **Serverless**: Azure Functions Core Tools (local runtime)
- **Static Hosting**: Local development server or Netlify/Vercel (free)

### DevOps Tools
- **CI/CD**: GitHub Actions (free 2000 minutes/month)
- **IaC**: Terraform (learn syntax, apply locally)
- **Monitoring**: Grafana + Prometheus + Jaeger (all local)
- **Secrets**: GitHub Secrets, dotnet user-secrets, .env files
- ⏸️ **Deferred**: Azure DevOps, Azure Key Vault (post-AZ-900)

---

## Implementation Roadmap

### Roadmap Overview

The implementation follows an **8-phase progressive approach** spanning 36 weeks:

```
Phase 1: Foundation (Weeks 1-4)
    ↓
Phase 2: Core Backend Services (Weeks 5-10)
    ↓
Phase 3: Frontend Foundation (Weeks 11-14)
    ↓
Phase 4: Advanced Backend Features (Weeks 15-20)
    ↓
Phase 5: Cloud & Containerization (Weeks 21-24)
    ↓
Phase 6: CI/CD & Automation (Weeks 25-28)
    ↓
Phase 7: Observability & Monitoring (Weeks 29-32)
    ↓
Phase 8: Optimization & Polish (Weeks 33-36)
```

**Key Principles**:
- ✅ Each phase builds on previous learning
- ✅ Phases can be adjusted based on learning pace
- ✅ Major checkpoints at weeks 10, 20, 28, and 36
- ✅ Flexibility to deep-dive into areas of interest

---

### Phase 1: Foundation (Weeks 1-4)
**Goal**: Establish core infrastructure and architecture

**Deliverables**:
- [ ] Project structure and repository setup
- [ ] System architecture design and documentation
- [ ] Database schema design
- [ ] Docker configurations for all services
- [ ] Local development environment setup
- [ ] CI/CD pipeline skeleton (GitHub Actions)

**Learning Focus**: Project setup, architecture design, Git workflows

---

### Phase 2: Core Backend Services (Weeks 5-10)
**Goal**: Implement foundational microservices

**Deliverables**:
- [ ] User Service (authentication, registration, profiles)
- [ ] Restaurant Service (CRUD operations, menu management)
- [ ] API Gateway implementation
- [ ] Entity Framework Core integration
- [ ] Unit and integration tests
- [ ] Swagger documentation

**Learning Focus**: .NET Web APIs, EF Core, testing, API design

---

### Phase 3: Frontend Foundation (Weeks 11-14)
**Goal**: Build Angular application foundation

**Deliverables**:
- [ ] Angular project structure
- [ ] Angular Material setup and custom theme
- [ ] Authentication module (JWT integration)
- [ ] Restaurant browsing and search with Material components
- [ ] Menu display and filtering using Material tables/cards
- [ ] Responsive UI/UX with Material layout system
- [ ] Frontend unit tests

**Learning Focus**: Angular architecture, Material Design components, theming, component design, HTTP services, testing

---

### Phase 4: Advanced Backend Features (Weeks 15-20)
**Goal**: Complete remaining microservices

**Deliverables**:
- [ ] Order Service (placement, tracking)
- [ ] Payment Service integration (mock/test mode)
- [ ] Notification Service using RabbitMQ (pub/sub patterns)
- [ ] Delivery Service (assignment, tracking)
- [ ] Event-driven communication with RabbitMQ
- [ ] Circuit breaker and retry policies (Polly)

**Learning Focus**: Microservices patterns, event-driven architecture, resilience

**Azure Status**: ⏸️ Azure Service Bus deferred (using RabbitMQ locally)

**Cost**: $0 (100% local)

---

### Phase 5: Cloud & Containerization (Weeks 21-24)
**Goal**: Master containerization and orchestration (100% local)

**Deliverables**:
- [ ] Docker images for all microservices
- [ ] Minikube setup for local Kubernetes cluster
- [ ] Kubernetes manifests (deployments, services, ingress)
- [ ] Docker Hub for container registry (free)
- [ ] RabbitMQ setup for local message queue and pub/sub patterns
- [ ] Azure Functions Core Tools (local serverless development)
- [ ] Infrastructure as Code with Terraform (syntax learning, local apply)
- [ ] Local load balancing with Nginx or Traefik

**Learning Focus**: Docker, Kubernetes, container orchestration, message queuing, IaC

**Azure Status**: ⏸️ All Azure services deferred (reserved for AZ-900)

**Cost**: $0 (100% free local tools)

---

### Phase 6: CI/CD & Automation (Weeks 25-28)
**Goal**: Build automated pipeline using free tools

**Deliverables**:
- [ ] GitHub Actions workflows (build → test → deploy)
- [ ] Automated testing in pipeline (free 2000 minutes/month)
- [ ] Docker image building and pushing to Docker Hub (free)
- [ ] Automated deployments to local Minikube or optional Azure
- [ ] Environment-specific configurations (dev, staging, prod)
- [ ] Secrets management with GitHub Secrets (free)
- [ ] Rollback capabilities
- [ ] Infrastructure as Code validation

**Learning Focus**: GitHub Actions, automated testing, deployment strategies, GitOps

**Azure Status**: ⏸️ No Azure DevOps usage (using GitHub Actions exclusively)

**Cost**: $0 (GitHub Actions free tier)

---

### Phase 7: Observability & Monitoring (Weeks 29-32)
**Goal**: Implement comprehensive observability (locally)

**Deliverables**:
- [ ] Centralized logging with .NET ILogger and Serilog
- [ ] Distributed tracing with Jaeger (local Docker container)
- [ ] Metrics collection with Prometheus (local)
- [ ] Grafana dashboards (local)
- [ ] Docker container health checks
- [ ] Kubernetes liveness and readiness probes
- [ ] Alerting rules and notifications
- [ ] Log aggregation and search

**Learning Focus**: Logging, tracing, metrics, dashboards, alerting

**Azure Status**: ⏸️ Application Insights deferred (using Grafana/Prometheus locally)

**Cost**: $0 (100% local tools)

---

### Phase 8: Optimization & Polish (Weeks 33-36)
**Goal**: Refine, optimize, and document

**Deliverables**:
- [ ] Performance optimization
- [ ] Security hardening
- [ ] Code refactoring and cleanup
- [ ] Comprehensive documentation
- [ ] API versioning implementation
- [ ] Load testing and benchmarks
- [ ] Final architecture review

**Learning Focus**: Performance tuning, security best practices, documentation

---

## Risk Management

### Assumptions

**Project assumptions that impact planning**:
- ✔️ Participant has access to a development machine meeting minimum specs
- ✔️ Stable internet connection for documentation and package downloads
- ✔️ Azure account with $50/month budget (reserved for AZ-900 certification, not for this project)
- ✔️ Commitment to 100% local development during AZ-900 prep period
- ✔️ GitHub account with access to GitHub Actions (free tier)
- ✔️ Availability of 8-12 hours per week for learning
- ✔️ Willingness to seek help and engage with community resources
- ✔️ Docker Desktop installed and functional (primary development environment)

### Constraints

**Known limitations and boundaries**:
- ⚠️ **Time**: 36-week timeline is guideline, not strict requirement
- ⚠️ **Budget**: $50/month Azure budget reserved for AZ-900; this project uses $0/month (100% local)
- ⚠️ **Azure Integration**: Deferred until post-AZ-900 completion (future phase)
- ⚠️ **Scope**: Limited to technologies specified; no scope expansion without review
- ⚠️ **Support**: Self-directed learning with community support, no dedicated instructor
- ⚠️ **Environment**: Development focused; not production-hardened
- ⚠️ **Cloud Usage**: Azure for validation only; majority of work done locally

---

### Technical Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Azure costs | None | ✅ **Eliminated**: 100% local development; Azure deferred for AZ-900 certification |
| Docker Desktop performance issues | Medium | Ensure 16GB RAM; optimize container resources; use lightweight images |
| Microservices complexity overwhelming | Medium | Start with monolith, decompose gradually; focus on 2-3 core services first |
| Learning curve too steep | Medium | Progressive approach, one technology at a time; extensive documentation |
| Local environment setup issues | Medium | Detailed setup guides, community support, alternative tools available |

### Learning Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Scope creep delays learning goals | Medium | Strict adherence to MVP features |
| Technology changes during development | Low | LTS versions minimize breaking changes |
| Burnout from complexity | Medium | Clear milestones, celebrate small wins |

---

## Cost Estimates

### Budget Status: $0/month (Azure Deferred)

**Azure Subscription**: $50/month reserved exclusively for **AZ-900 certification practice**  
**Project Cost**: **$0/month** - 100% free local development  
**Azure Integration**: ⏸️ Deferred until post-AZ-900 completion

---

### Current Development Approach (100% Free)

**Philosophy**: Learn all cloud-native patterns locally without any Azure costs. Preserve Azure budget for certification prep.

| Component | Local Tool (Free) | Learning Value | Azure Migration (Future) |
|-----------|-------------------|----------------|--------------------------|
| **Kubernetes** | Minikube | ✅ Same kubectl, YAML, concepts | → Azure Kubernetes Service (AKS) |
| **Database** | SQL Server 2022 Developer | ✅ 100% identical to Azure SQL | → Azure SQL Database |
| **Message Queue** | RabbitMQ | ✅ Same pub/sub patterns | → Azure Service Bus |
| **Container Registry** | Docker Hub (free) | ✅ Same docker push/pull | → Azure Container Registry |
| **Serverless** | Functions Core Tools | ✅ Same function code | → Azure Functions |
| **Secrets** | dotnet user-secrets | ✅ Same access patterns | → Azure Key Vault |
| **Monitoring** | Grafana + Prometheus | ✅ Same dashboards/queries | → Azure Monitor/App Insights |
| **CI/CD** | GitHub Actions | ✅ Production-quality | → Keep GitHub Actions (free) |
| **Static Hosting** | Local dev server | ✅ Same app | → Azure Static Web Apps |
| **Load Balancer** | Nginx/Traefik | ✅ Same concepts | → Azure Load Balancer |

**Total Project Cost**: **$0/month** ✅  
**Learning Coverage**: **100%** ✅  
**Azure Budget Reserved**: **$50/month for AZ-900** ✅

---

### Future Azure Migration Plan (Post-AZ-900)

**Phase 9: Azure Integration** (Future - After Certification)

When AZ-900 is complete and Azure budget becomes available:

| Azure Service | Estimated Cost | Migration Effort | Priority |
|---------------|----------------|------------------|----------|
| Azure Static Web Apps | Free tier | Low (1 day) | High |
| Azure Container Registry | $5/month | Low (1 day) | Medium |
| Azure Functions | $0-5/month (free tier) | Low (2 days) | Medium |
| Azure Service Bus | $0-5/month (basic tier) | Medium (3 days) | Medium |
| Azure SQL Database | $5-15/month | Medium (3 days) | Low (local works fine) |
| Azure Kubernetes Service | $60-80/month | High (1-2 weeks) | Low (Minikube works) |
| **Optional Total** | **$10-25/month** | **1-3 weeks** | **All optional** |

**Decision Points**:
- ✅ **After AZ-900**: Evaluate which services add value
- ✅ **Cost-Benefit**: Only migrate if learning justifies cost
- ✅ **Portfolio**: Cloud deployment nice-to-have, not required
- ⚠️ **Recommendation**: Keep local unless Azure experience needed for job applications

---

### Why This Approach Works

**Separation of Concerns**:
| Purpose | Budget Allocation | Timeline |
|---------|------------------|----------|
| **AZ-900 Certification** | $50/month Azure | Current priority |
| **Methy Development** | $0/month (local tools) | Current project |
| **Azure Integration** | $10-25/month (optional) | Future consideration |

**Benefits**:
- ✅ **No Budget Conflict**: AZ-900 study undisturbed
- ✅ **Zero Financial Risk**: No accidental cloud charges
- ✅ **Full Learning**: All skills acquired locally
- ✅ **Future Ready**: Easy Azure migration when ready
- ✅ **Portable Skills**: Local knowledge transfers to any cloud (AWS, GCP, Azure)

---

### Free Tools & Services (Everything You Need)

**Complete Development Stack at $0/month**:
- ✅ Docker Desktop (free for education/learning)
- ✅ Minikube (free Kubernetes)
- ✅ SQL Server Developer Edition (free)
- ✅ Visual Studio Code (free)
- ✅ .NET SDK (free)
- ✅ Node.js & Angular CLI (free)
- ✅ GitHub (free with 2000 Actions minutes)
- ✅ RabbitMQ (free message queue)
- ✅ Grafana + Prometheus + Jaeger (free observability)
- ✅ All learning resources and documentation (free)

---

## Out of Scope

To maintain focus on learning objectives, the following are explicitly **NOT** included:

- ❌ Production deployment to public users
- ❌ Real payment processing (use mock/test mode)
- ❌ Mobile native applications (web-only)
- ❌ Advanced ML/AI features
- ❌ Multi-tenancy
- ❌ Internationalization (i18n)
- ❌ Advanced caching strategies (Redis, CDN)
- ❌ Real-time GPS tracking (simplified simulation)
- ❌ Production-grade security audits
- ❌ Compliance certifications (PCI-DSS, HIPAA)

---

## Key Principles

### Development Philosophy

1. **Learning First, Production Second**
   - Prioritize understanding over optimization
   - Implement patterns to learn, not just to solve

2. **Simplicity Over Complexity**
   - Avoid over-engineering
   - Choose clarity over cleverness
   - Refactor as understanding grows

3. **Progressive Enhancement**
   - Start simple, add complexity gradually
   - Each phase builds on previous learning
   - Iterate and improve continuously

4. **Quality Through Automation**
   - Automate testing and deployment
   - Catch issues early in pipeline
   - Build confidence through automation

5. **Documentation as Learning**
   - Document decisions and rationale
   - Explain why, not just how
   - Create learning artifacts for future reference

### Best Practices

#### Development Workflow
- 💻 **Commit Frequently**: Small, atomic commits with clear messages
- 💻 **Branch Strategy**: Feature branches from main, PRs for review
- 💻 **Code Reviews**: Self-review before pushing, peer review when possible
- 💻 **Testing**: Write tests alongside code, not after
- 💻 **Documentation**: Update docs as you build features

#### Learning Strategies
- 📚 **Time Boxing**: Set specific time limits for research/debugging
- 📚 **Active Learning**: Type code manually, don't just copy-paste
- 📚 **Reflection**: Weekly review of what worked and what didn't
- 📚 **Community**: Ask questions, share progress, help others
- 📚 **Breaks**: Take regular breaks to prevent burnout

#### Technical Excellence
- 🛠️ **Start Simple**: Get it working, then make it better
- 🛠️ **Refactor Often**: Clean code as understanding improves
- 🛠️ **Monitor Early**: Add logging and metrics from the start
- 🛠️ **Security First**: Never commit secrets, validate all inputs
- 🛠️ **Performance Later**: Optimize based on metrics, not assumptions

---

## Success Criteria

### Project Completion Checklist

#### Functional Requirements
- [ ] Complete food ordering workflow (browse → order → track)
- [ ] Restaurant management interface
- [ ] User authentication and authorization
- [ ] Payment processing simulation
- [ ] Real-time notifications

#### Technical Requirements
- [ ] All microservices deployed and running
- [ ] CI/CD pipeline fully automated
- [ ] Monitoring and observability operational
- [ ] Security measures implemented
- [ ] API documentation complete

#### Quality Metrics
- [ ] >70% code coverage
- [ ] <500ms average API response time
- [ ] Zero critical security vulnerabilities
- [ ] All builds passing in CI
- [ ] Kubernetes health checks green

#### Learning Outcomes
- [ ] Demonstrable proficiency in all stack technologies
- [ ] Understanding of microservices patterns
- [ ] Ability to deploy and manage cloud infrastructure
- [ ] Competence in CI/CD pipeline creation
- [ ] Knowledge of observability and monitoring

---

## Conclusion

Methy represents more than a food delivery platform—it's a **comprehensive learning journey** through modern software development. By building this application, developers will gain hands-on experience with the technologies, patterns, and practices used in today's enterprise environments.

### Why This Matters

In an industry where practical experience is valued above all, Methy provides:
- 🎯 **Portfolio-Ready Project**: Demonstrate real-world capabilities to employers
- 🎯 **Full-Stack Expertise**: Master the complete development lifecycle
- 🎯 **Modern Technologies**: Work with current, in-demand tools and frameworks
- 🎯 **Production Patterns**: Learn patterns used in enterprise applications
- 🎯 **Career Advancement**: Build skills that lead to senior/lead positions

### Your Journey Ahead

The project balances real-world complexity with learning accessibility, ensuring each component serves both as functional code and educational reference. Through structured phases and progressive skill building, you will emerge with production-quality development capabilities across the entire stack.

**Remember**: Every expert was once a beginner. The journey of building Methy is as valuable as the destination. Embrace challenges, celebrate small wins, and enjoy the process of becoming a better developer.

### Next Steps

Ready to begin? Here's how to start:

1. ✅ **Review and approve this vision document**
2. 📋 **Set up local development environment**  
   _Install: VS Code, Node.js, .NET SDK, Docker Desktop, SQL Server Developer, Git_  
   _Cost: $0 (all free tools)_
3. 📋 **Install additional local infrastructure**  
   _Setup: Minikube, RabbitMQ, configure Docker Hub account_  
   _Cost: $0 (all free)_
4. 📋 **Create detailed system architecture diagram**  
   _Output: High-level and detailed architecture diagrams (100% local infrastructure)_
5. 📋 **Define database schema (ERD)**  
   _Output: Entity-relationship diagram with table definitions_
6. 📋 **Initialize Git repository and GitHub project**  
   _Create: Repository, README, .gitignore, initial structure_
7. 📋 **Begin Phase 1: Foundation**  
   _Duration: 4 weeks, Focus: Infrastructure and architecture (100% local)_

**Azure Status**: ⏸️ All Azure services deferred for AZ-900 certification practice  
**Budget Reality**: Weeks 1-36 cost $0. Azure integration optional in future Phase 9 (post-certification).

**Let's build something amazing—completely free! 🚀**

---

## Document Control

### Version History

| Version | Date | Author | Changes | Approved By |
|---------|------|--------|---------|-------------|
| 1.0 | April 30, 2026 | Sagar Pandit | Initial product vision document | - |

### Official Documentation
- 📘 [Angular Documentation](https://angular.dev)
- 📘 [Angular Material](https://material.angular.io)
- 📘 [.NET Documentation](https://docs.microsoft.com/dotnet)
- 📘 [ASP.NET Core](https://docs.microsoft.com/aspnet/core)
- 📘 [Azure Documentation](https://docs.microsoft.com/azure)
- 📘 [Docker Documentation](https://docs.docker.com)
- 📘 [Kubernetes Documentation](https://kubernetes.io/docs)

### Learning Resources
- 🎓 [Microsoft Learn - Azure Fundamentals](https://docs.microsoft.com/learn/azure)
- 🎓 [Pluralsight - .NET Microservices](https://www.pluralsight.com)
- 🎓 [Angular University](https://angular-university.io)
- 🎓 [GitHub Actions Documentation](https://docs.github.com/actions)

### Architecture Patterns
- 📖 "Microservices Patterns" by Chris Richardson
- 📖 "Clean Architecture" by Robert C. Martin
- 📖 "Designing Data-Intensive Applications" by Martin Kleppmann
- 📖 "Building Microservices" by Sam Newman

### Tools & Extensions
- 🔧 [GitHub Copilot](https://github.com/features/copilot)
- 🔧 [Azure CLI](https://docs.microsoft.com/cli/azure)
- 🔧 [kubectl](https://kubernetes.io/docs/reference/kubectl)
- 🔧 [Postman](https://www.postman.com)
- 🔧 [DBeaver](https://dbeaver.io) or Azure Data Studio

### Community & Support
- 💬 [Stack Overflow](https://stackoverflow.com)
- 💬 [Angular Community Discord](https://discord.gg/angular)
- 💬 [.NET Community Discord](https://discord.gg/dotnet)
- 💬 [Azure Community](https://techcommunity.microsoft.com/azure)

---

## FAQ

### General Questions

**Q: Is this project suitable for complete beginners?**  
A: It requires basic programming knowledge. Complete beginners should first complete foundational courses in web development before attempting this project.

**Q: How long will it take to complete?**  
A: The roadmap spans 36 weeks at 8-12 hours/week (300-400 total hours). You can accelerate or decelerate based on your schedule and experience.

**Q: Can I work on this alone or do I need a team?**  
A: This is designed as both a solo learning journey and a team project. Collaboration enhances learning but isn't required.

**Q: Will this prepare me for a job?**  
A: Yes! This project covers technologies and patterns used in enterprise environments. The portfolio demonstrates real-world capabilities to employers.

### Technical Questions

**Q: Why not use React or Vue instead of Angular?**  
A: Angular is chosen for its enterprise focus, comprehensive framework, TypeScript integration, and strong conventions—all valuable for learning structured development.

**Q: Can I use a different cloud provider (AWS/GCP)?**  
A: Yes, but you'll need to adapt Azure-specific services. The architecture principles remain the same.

**Q: Do I need to implement all microservices?**  
A: Start with 2-3 core services (User, Restaurant, Order). Add others as you progress and gain confidence.

**Q: What if Azure costs are too high?**  
A: **Problem solved!** This project now uses **100% local development** with **$0 Azure costs**. Your $50/month subscription is preserved for **AZ-900 certification study**. All Azure services are deferred until after you complete your certification. You'll learn the exact same patterns using free local tools (Minikube, RabbitMQ, Docker Hub, etc.).

**Q: Can I complete the project without any Azure costs?**  
A: **Yes, absolutely!** The entire project (Phases 1-8, 36 weeks) uses only free local tools. Azure is **completely optional** and deferred for future consideration. You get 100% of the learning with $0 cloud spend. GitHub Actions provides free CI/CD. All skills transfer perfectly to Azure when you're ready (post-AZ-900).

**Q: Will local development tools teach me the same skills as Azure?**  
A: Absolutely! Minikube uses the same kubectl commands as AKS. RabbitMQ teaches the same messaging patterns as Azure Service Bus. SQL Server Developer is identical to Azure SQL. Docker Desktop containers work exactly like Azure Container Instances. The skills are 100% transferable.

**Q: When will I integrate Azure services?**  
A: After completing AZ-900 certification, you can optionally add a "Phase 9: Azure Migration" to deploy your working application to Azure cloud services. This is completely optional for portfolio enhancement. The timeline depends on your certification completion. Estimated migration effort: 1-3 weeks, cost: $10-25/month.

**Q: Should I use NgRx or Angular Signals for state management?**  
A: Start with Angular Signals (simpler, modern). Consider NgRx if you need advanced patterns like time-travel debugging or complex state trees.

**Q: Is SQL Server required or can I use PostgreSQL?**  
A: SQL Server is specified for .NET ecosystem integration, but PostgreSQL works equally well with EF Core. Choose based on your preference.

### Learning & Progress Questions

**Q: What if I get stuck on a phase?**  
A: Use the resources section, community forums, and GitHub Copilot. Break the problem into smaller pieces and tackle one at a time.

**Q: Should I follow the phases strictly?**  
A: The phases provide structure, but you can adjust based on your learning style. Ensure prerequisites are met before advancing.

**Q: Can I add features not in the scope?**  
A: After completing the core project, absolutely! Extensions like payment integrations, advanced analytics, or mobile apps make great portfolio additions.

**Q: How do I track my progress?**  
A: Use GitHub Projects or a simple checklist. Document your learnings in a README or blog. Commit regularly with descriptive messages.

---

## Glossary

**AKS**: Azure Kubernetes Service - Managed Kubernetes orchestration service  
**CI/CD**: Continuous Integration/Continuous Deployment - Automated build and deployment  
**EF Core**: Entity Framework Core - ORM for .NET  
**IaC**: Infrastructure as Code - Managing infrastructure through code  
**JWT**: JSON Web Token - Secure authentication token format  
**Material Design**: Google's design system for building user interfaces  
**Microservices**: Architectural style with loosely coupled, independently deployable services  
**NgRx**: State management library for Angular based on Redux pattern  
**ORM**: Object-Relational Mapping - Database abstraction layer  
**PWA**: Progressive Web App - Web applications with native-like capabilities  
**SOLID**: Design principles (Single responsibility, Open-closed, Liskov substitution, Interface segregation, Dependency inversion)  
**WCAG**: Web Content Accessibility Guidelines - Standards for accessible web content

---

### Document Review Schedule
- **Next Review**: End of Phase 2 (Week 10)
- **Review Frequency**: After each major phase or when significant changes occur
- **Approval Required**: Architecture changes, technology stack modifications, scope adjustments

### Related Documents
- 📄 System Architecture Design (TBD)
- 📄 Database Schema & ERD (TBD)
- 📄 API Specification (TBD)
- 📄 Development Guidelines & Standards (TBD)
- 📄 Deployment Runbooks (TBD)

### Change Control Process
1. **Propose**: Submit change request with rationale
2. **Review**: Assess impact on timeline, cost, learning objectives
3. **Approve**: Document owner approval required for major changes
4. **Update**: Revise document and increment version
5. **Communicate**: Notify all stakeholders of changes

---

**For questions or clarifications, refer to the [FAQ](#faq) section or contact the development team.**
