# DrillDraw PR Flow Rules

## Mandatory Planning Process

### Before Starting Any Work
Cursor AI MUST follow this planning process:

1. **Create detailed plan** with bullets/files/tests
2. **Reference relevant ADRs** (Architecture Decision Records)
3. **Include architecture checklist** in PRs
4. **Plan before coding** - no implementation without planning

## Planning Requirements

### Required Plan Structure
Every work session MUST start with:

```markdown
## Plan
- **Objective**: [Clear goal statement]
- **Files to modify**: [List specific files]
- **Tests to add**: [List test files and scenarios]
- **ADRs referenced**: [List relevant ADR documents]
- **Architecture impact**: [How this affects the system]
```

### ADR Reference Requirements
- **MUST reference** relevant ADRs before implementation
- **MUST explain** how changes align with architectural decisions
- **MUST document** any deviations from existing ADRs

### Test Planning Requirements
- **MUST plan tests** before implementing features
- **MUST include** unit tests, widget tests, integration tests
- **MUST specify** test scenarios and edge cases
- **MUST ensure** test coverage for new functionality

## PR Checklist Requirements

### Mandatory PR Checklist
Every PR MUST include this checklist:

```markdown
## Architecture Compliance Checklist
- [ ] **ADR Compliance**: Changes align with existing ADRs
- [ ] **Shape Abstraction**: All drawables implement Shape interface
- [ ] **Selection Management**: Selection only via SelectionManager
- [ ] **Hit Testing**: Hit-testing only via HitTestService
- [ ] **Widget Architecture**: Widgets are thin, logic in CanvasController
- [ ] **Canvas Bounds**: All coordinates within canvas bounds
- [ ] **Test Coverage**: Comprehensive tests for new functionality
- [ ] **Performance**: No performance regressions
- [ ] **Documentation**: Updated documentation as needed
```

### Code Quality Checklist
- [ ] **Code Formatting**: All code properly formatted
- [ ] **Static Analysis**: No linting errors or warnings
- [ ] **Type Safety**: Proper null safety and type checking
- [ ] **Error Handling**: Appropriate error handling implemented
- [ ] **Performance**: Efficient algorithms and data structures

### Testing Checklist
- [ ] **Unit Tests**: All business logic tested
- [ ] **Widget Tests**: UI components tested
- [ ] **Integration Tests**: User workflows tested
- [ ] **Edge Cases**: Boundary conditions tested
- [ ] **Performance Tests**: Large dataset scenarios tested

## Planning Templates

### Feature Development Plan
```markdown
## Feature Development Plan

### Objective
[Clear description of what we're building]

### Architecture Impact
- **Models**: [New/updated models]
- **Services**: [New/updated services]
- **Widgets**: [New/updated UI components]
- **Tests**: [New/updated test files]

### ADRs Referenced
- ADR-0001: [Architecture decisions relevant to this work]

### Implementation Steps
1. [Step 1 with specific files]
2. [Step 2 with specific files]
3. [Step 3 with specific files]

### Test Plan
- [ ] Unit test: [Specific test scenario]
- [ ] Widget test: [UI interaction test]
- [ ] Integration test: [End-to-end workflow test]
- [ ] Performance test: [Large dataset test]

### Risk Assessment
- **Architecture Risk**: [Potential impact on system architecture]
- **Performance Risk**: [Potential performance implications]
- **Breaking Changes**: [Any breaking changes and mitigation]
```

### Bug Fix Plan
```markdown
## Bug Fix Plan

### Problem Statement
[Clear description of the bug]

### Root Cause Analysis
[Analysis of why the bug exists]

### Solution Approach
[How we'll fix the bug]

### Files to Modify
- [File 1]: [What changes needed]
- [File 2]: [What changes needed]

### Test Plan
- [ ] Reproduce bug scenario
- [ ] Test fix with edge cases
- [ ] Regression test related functionality

### ADRs Impact
[How this fix aligns with or affects existing ADRs]
```

## Architecture Decision Record (ADR) Integration

### ADR Reference Process
1. **Review existing ADRs** before starting work
2. **Identify relevant decisions** that apply to current work
3. **Document alignment** with existing ADRs
4. **Create new ADR** if architectural decision is needed

### ADR Compliance Verification
- **All changes** must align with existing ADRs
- **New patterns** require new ADR creation
- **Deviations** must be documented and justified
- **Breaking changes** must update relevant ADRs

## Code Review Requirements

### Review Process
1. **Architecture review** for compliance with ADRs
2. **Code quality review** for best practices
3. **Test coverage review** for completeness
4. **Performance review** for efficiency
5. **Documentation review** for clarity

### Review Criteria
- **ADR Compliance**: Changes follow established patterns
- **Code Quality**: Clean, maintainable, well-documented code
- **Test Coverage**: Comprehensive test coverage
- **Performance**: No performance regressions
- **Documentation**: Clear documentation and comments

## Workflow Enforcement

### Pre-Development Checklist
Before starting ANY work:
- [ ] **Plan created** with bullets/files/tests
- [ ] **ADRs reviewed** and referenced
- [ ] **Architecture impact** assessed
- [ ] **Test strategy** defined
- [ ] **Risk assessment** completed

### Development Process
During development:
- [ ] **Follow plan** step by step
- [ ] **Update plan** if changes needed
- [ ] **Reference ADRs** in implementation
- [ ] **Write tests** as you code
- [ ] **Document decisions** and rationale

### Pre-PR Checklist
Before creating PR:
- [ ] **Architecture checklist** completed
- [ ] **All tests** passing
- [ ] **Code formatted** and analyzed
- [ ] **Documentation** updated
- [ ] **ADR compliance** verified

## Quality Gates

### Automatic Checks
- **Code formatting** must pass
- **Static analysis** must pass
- **All tests** must pass
- **Build** must succeed

### Manual Reviews
- **Architecture review** by senior developer
- **Code quality review** by peer
- **Test coverage review** by QA
- **Performance review** by performance team

### Approval Requirements
- **Architecture approval** for system changes
- **Code quality approval** for all changes
- **Test approval** for test coverage
- **Documentation approval** for user-facing changes

## Anti-Patterns to Avoid

### ❌ Planning Anti-Patterns
- Starting coding without planning
- Skipping ADR reference
- Not planning tests upfront
- Ignoring architecture impact

### ❌ PR Anti-Patterns
- Missing architecture checklist
- Incomplete test coverage
- Poor documentation
- Not referencing ADRs

### ❌ Review Anti-Patterns
- Rushing through architecture review
- Skipping performance review
- Not checking ADR compliance
- Approving without proper testing

## Success Metrics

### Planning Quality
- **Plan completeness**: All required sections filled
- **ADR alignment**: Clear reference to relevant ADRs
- **Test planning**: Comprehensive test strategy
- **Risk assessment**: Thorough risk analysis

### Implementation Quality
- **ADR compliance**: Changes follow established patterns
- **Test coverage**: High test coverage for new code
- **Code quality**: Clean, maintainable code
- **Performance**: No performance regressions

### Process Efficiency
- **Review time**: Faster reviews due to better planning
- **Bug rate**: Lower bug rate due to better testing
- **Architecture drift**: Reduced due to ADR compliance
- **Knowledge sharing**: Better due to documentation

## Continuous Improvement

### Process Refinement
- **Regular review** of planning process
- **Feedback collection** from developers
- **Process optimization** based on metrics
- **Tool improvements** for better automation

### Training and Education
- **Planning workshops** for new developers
- **ADR training** for architecture decisions
- **Review process** training
- **Quality standards** education

Remember: **Plan first, code second, review always.**
