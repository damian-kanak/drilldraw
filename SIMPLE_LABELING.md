# DrillDraw Simple Labeling System

## Core Labels (Maximum 3 per issue)

### 1. **Area** (`area/`) - What part of the system
**Color**: `#0e8a16` (Green)
- `area/canvas` - Canvas and rendering
- `area/editor` - Editor functionality  
- `area/model` - Data models
- `area/ui` - User interface
- `area/process` - Development workflow and process ⭐ **For project workflow issues**

### 2. **Type** (Standard GitHub labels)
**Colors**: Various
- `bug` - Something isn't working
- `enhancement` - New feature or improvement
- `documentation` - Documentation updates

### 3. **Priority** (`prio/`) - How urgent
**Color**: `#d73a4a` (Red) for high, `#fbca04` (Yellow) for medium
- `prio/P1` - Critical (blocking, security, data loss)
- `prio/P2` - High (important features, major bugs)
- `prio/P3` - Medium (nice-to-have, minor improvements)

## For Project Workflow Issues:
Use **exactly 3 labels**:
1. `area/process` - Identifies it as a workflow/process issue
2. `enhancement` or `bug` - Type of work
3. `prio/P1`, `prio/P2`, or `prio/P3` - Priority level

## Examples:

### Workflow Issues:
```
Issue: "Set up feature branch workflow"
Labels: area/process, enhancement, prio/P2

Issue: "Fix broken CI pipeline" 
Labels: area/process, bug, prio/P1

Issue: "Update contribution guidelines"
Labels: area/process, documentation, prio/P3
```

### Feature Issues:
```
Issue: "Add rectangle selection"
Labels: area/canvas, enhancement, prio/P2

Issue: "Fix rectangle disappearing bug"
Labels: area/canvas, bug, prio/P1
```

## Rule: Maximum 3 labels per issue
- 1 Area label (required)
- 1 Type label (required) 
- 1 Priority label (optional but recommended)

This keeps things simple and focused while still providing good organization.
