# DrillDraw GitHub Actions Workflow Architecture

## Workflow Connection Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              GITHUB REPOSITORY                                 │
│                        damian-kanak/drilldraw                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
                                        │
                                        ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              TRIGGER EVENTS                                    │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │   Push to   │  │ Pull Request│  │   Schedule  │  │   Manual    │          │
│  │    main     │  │     to      │  │ (Daily 2AM) │  │   Trigger   │          │
│  │   branch    │  │    main     │  │             │  │             │          │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘          │
└─────────────────────────────────────────────────────────────────────────────────┘
                                        │
                                        ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                            WORKFLOW EXECUTION                                  │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         CI WORKFLOW (ci.yml)                           │   │
│  │  ┌─────────────────────────────────────────────────────────────────┐   │   │
│  │  │                    Test Flutter App                            │   │   │
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │   │   │
│  │  │  │   Setup     │  │   Install   │  │    Run      │            │   │   │
│  │  │  │   Flutter   │  │ Dependencies│  │   Tests     │            │   │   │
│  │  │  │  3.24.0     │  │             │  │             │            │   │   │
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘            │   │   │
│  │  └─────────────────────────────────────────────────────────────────┘   │   │
│  │                                                                         │   │
│  │  ┌─────────────────────────────────────────────────────────────────┐   │   │
│  │  │                Deploy to GitHub Pages                          │   │   │
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │   │   │
│  │  │  │   Build     │  │   Switch    │  │    Push     │            │   │   │
│  │  │  │   Web App   │  │   to        │  │   to        │            │   │   │
│  │  │  │             │  │ gh-pages    │  │ gh-pages    │            │   │   │
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘            │   │   │
│  │  └─────────────────────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                     QUALITY GATES (quality.yml)                        │   │
│  │  ┌─────────────────────────────────────────────────────────────────┐   │   │
│  │  │                Code Quality & Coverage                         │   │   │
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │   │   │
│  │  │  │   Run       │  │   Generate  │  │   Upload    │            │   │   │
│  │  │  │ Tests with  │  │  Coverage   │  │ Coverage    │            │   │   │
│  │  │  │ Coverage    │  │   Report    │  │ Reports     │            │   │   │
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘            │   │   │
│  │  └─────────────────────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                       SECURITY (security.yml)                          │   │
│  │  ┌─────────────────────────────────────────────────────────────────┐   │   │
│  │  │                Security Scanning                                │   │   │
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │   │   │
│  │  │  │ Dependency  │  │   Static    │  │   Secret    │            │   │   │
│  │  │  │   Audit     │  │  Analysis   │  │  Scanning   │            │   │   │
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘            │   │   │
│  │  └─────────────────────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         CODEQL (codeql.yml)                            │   │
│  │  ┌─────────────────────────────────────────────────────────────────┐   │   │
│  │  │                    Security Analysis                            │   │   │
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │   │   │
│  │  │  │ Initialize  │  │   Build     │  │  Analyze    │            │   │   │
│  │  │  │   CodeQL    │  │  Database   │  │ JavaScript  │            │   │   │
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘            │   │   │
│  │  └─────────────────────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────────┘
                                        │
                                        ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              OUTPUTS & ARTIFACTS                              │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                           DEPLOYMENT                                   │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                    │   │
│  │  │   GitHub    │  │   Live      │  │   Build     │                    │   │
│  │  │   Pages     │  │   Site      │  │ Artifacts   │                    │   │
│  │  │   Branch    │  │             │  │             │                    │   │
│  │  │  (gh-pages) │  │ https://    │  │  (web/      │                    │   │
│  │  └─────────────┘  │ damian-     │  │  macOS)     │                    │   │
│  │                   │ kanak.      │  └─────────────┘                    │   │
│  │                   │ github.io/  │                                     │   │
│  │                   │ drilldraw/  │                                     │   │
│  │                   └─────────────┘                                     │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                           QUALITY METRICS                              │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                    │   │
│  │  │   Test      │  │  Coverage   │  │   Code      │                    │   │
│  │  │  Results    │  │   Reports   │  │  Quality    │                    │   │
│  │  │             │  │   (HTML)    │  │  Metrics    │                    │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘                    │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                           SECURITY REPORTS                             │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                    │   │
│  │  │ Dependency  │  │   Static    │  │   CodeQL    │                    │   │
│  │  │ Vulnerabil. │  │ Analysis    │  │   Alerts    │                    │   │
│  │  │             │  │  Reports    │  │             │                    │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘                    │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────────┘
                                        │
                                        ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              GITHUB FEATURES                                  │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                           BADGES & STATUS                              │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                    │   │
│  │  │    CI       │  │   Quality   │  │  Security   │                    │   │
│  │  │   Status    │  │    Gates    │  │   Scanning  │                    │   │
│  │  │   Badge     │  │    Badge    │  │    Badge    │                    │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘                    │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                          SECURITY TAB                                  │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                    │   │
│  │  │   CodeQL    │  │   Secret    │  │ Dependency  │                    │   │
│  │  │   Alerts    │  │  Scanning   │  │   Scanning  │                    │   │
│  │  │             │  │   Results   │  │   Results   │                    │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘                    │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## Workflow Dependencies

### 1. **CI Workflow (ci.yml)**
- **Triggers**: Push to main, Pull requests
- **Dependencies**: None (primary workflow)
- **Outputs**: 
  - Test results
  - Built web app
  - GitHub Pages deployment
  - Build artifacts

### 2. **Quality Gates (quality.yml)**
- **Triggers**: Push to main, Pull requests
- **Dependencies**: None (parallel execution)
- **Outputs**:
  - Test coverage reports
  - Code quality metrics
  - HTML coverage reports

### 3. **Security (security.yml)**
- **Triggers**: Push to main, Pull requests, Daily schedule
- **Dependencies**: None (parallel execution)
- **Outputs**:
  - Dependency vulnerability reports
  - Static analysis results
  - Secret scanning alerts

### 4. **CodeQL (codeql.yml)**
- **Triggers**: Push to main, Pull requests, Daily schedule
- **Dependencies**: None (parallel execution)
- **Outputs**:
  - JavaScript security analysis
  - CodeQL alerts
  - Security database

## Data Flow

```
Source Code → Workflows → Analysis → Reports → GitHub Features
     │           │           │          │           │
     ▼           ▼           ▼          ▼           ▼
   lib/      ci.yml      Tests      Coverage    Badges
   test/   quality.yml   Security   Reports     Security
   web/   security.yml   Analysis   Artifacts    Tab
        codeql.yml       CodeQL     Alerts     Pages
```

## Workflow Execution Order

1. **Parallel Execution**: All workflows run simultaneously
2. **Independent**: No workflow depends on another
3. **Shared Resources**: All use same Flutter 3.24.0 environment
4. **Convergent**: All contribute to repository health metrics

## Integration Points

- **GitHub Pages**: CI workflow deploys to gh-pages branch
- **Security Tab**: CodeQL and Security workflows feed alerts
- **Badges**: All workflows contribute to status badges
- **Artifacts**: Coverage reports, build outputs, security data
- **Pull Requests**: All workflows run on PRs for quality gates
