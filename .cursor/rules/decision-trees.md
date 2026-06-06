# DrillDraw Decision Trees

> See [.cursorrules](../../.cursorrules) for critical rules and doc map.

Keywords: when, how to, add shape, new feature, bug fix, refactor, decision

Use these trees to decide what to do and which docs to read.

---

## When Adding a New Shape

1. Read [architecture.md](architecture.md) (Shape Abstraction, Shape Interface)
2. Read [docs/ADR-0001-architecture.md](../../docs/ADR-0001-architecture.md)
3. Create model class implementing `Shape` (id, bounds, hitTest, copyWith)
4. Add painter for the shape (or extend CombinedPainter)
5. Add shape to `DrawingState` shape lists (currently `dots` or `rectangles`; no registry yet)
6. Add unit tests (see [testing.md](testing.md))
7. Update [glossary.md](glossary.md) if new terminology

---

## When Starting Work (Any Task)

1. Check branch: `git branch --show-current`
2. If on main: create branch `type/issue-number-description` (see [workflow.md](workflow.md))
3. Create plan: objective, files, tests, ADRs (see [pr-flow.md](pr-flow.md))
4. Read relevant ADRs and architecture rules
5. Implement
6. Pre-commit: format, analyze, test (see [workflow.md](workflow.md))

---

## When Fixing a Bug

1. Create plan: root cause, fix approach, regression tests
2. Add or extend tests that reproduce the bug
3. Implement fix
4. Verify existing tests pass; new tests cover the bug
5. Pre-commit: format, analyze, test

---

## When Refactoring

1. Read [architecture.md](architecture.md) for target patterns
2. Create plan: what changes, which files, test strategy
3. Ensure tests pass before refactor
4. Refactor incrementally; run tests after each step
5. No new behavior: same tests, same results
6. Pre-commit: format, analyze, test

---

## When Writing or Reviewing Tests

1. Read [testing.md](testing.md) (requirements, strategy, coverage)
2. Plan: unit vs widget vs integration; scenarios and edge cases
3. Follow AAA: Arrange, Act, Assert
4. Target 80%+ coverage for new code
5. Mock external dependencies

---

## When Creating a PR

1. Ensure branch follows `type/issue-number-description`
2. Use PR template: [.github/PULL_REQUEST_TEMPLATE.md](../../.github/PULL_REQUEST_TEMPLATE.md)
3. Complete Architecture Compliance Checklist (see [pr-flow.md](pr-flow.md))
4. Reference issue: "Resolves #NNN"
5. Verify CI passes before requesting review

---

## When Modifying Canvas or Painters

1. Read [architecture.md](architecture.md) (Hit Testing, Widget Architecture)
2. Read [code-quality.md](code-quality.md) (Canvas-Specific Guidelines, Performance)
3. No direct hit-testing in painters; use HitTestService when available
4. Optimize shouldRepaint; avoid new Paint in paint()
5. Add/update tests for canvas behavior
