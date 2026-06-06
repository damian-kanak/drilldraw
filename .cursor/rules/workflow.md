# DrillDraw Workflow Rules

> After committing: see [pr-flow.md](pr-flow.md) for the PR checklist.

Keywords: branch, git, commit, PR, checklist, troubleshooting, issue

## CRITICAL: Branch Naming Rule

**NEVER START WORK WITHOUT CREATING A BRANCH WITH ISSUE NUMBER**
**ALWAYS CHECK: Are you on main? → Create branch first!**
**BRANCH NAMING: `type/issue-number-description` (e.g., `feature/177-architecture-rules`)**

## Pre-Work Checklist (MANDATORY)

Before starting ANY work, Cursor MUST:

1. **Check current branch**: `git branch --show-current`
2. **If on main**: Create branch with issue number first
3. **Verify branch name**: Must start with issue number
4. **Only then**: Start implementing changes

## Pre-Commit Checklist (MANDATORY)

Before committing ANY work, Cursor MUST:

1. **Format code**: `dart format .` - Ensure code formatting compliance
2. **Run analyzer**: `flutter analyze` - Fix ALL issues before committing
3. **Run tests**: `flutter test` - Ensure all tests pass
4. **Check for lints**: `read_lints` tool - Verify no linting issues
5. **Only then**: Commit with proper message format

## Example Workflow

```bash
# 1. Check current branch
git branch --show-current  # Should NOT be "main"

# 2. If on main, create branch first
git checkout -b feature/177-architecture-rules

# 3. Then start work
```

## Git Workflow

- ALWAYS create feature branches for new features - NEVER commit directly to main
- **MANDATORY: All branch names MUST start with issue number** (e.g., `feature/122-description`)
- Always create pull requests for feature branches
- Keep main branch stable and deployable
- **NO EXCEPTIONS**: Even small changes require issue numbers in branch names

## Branch Naming Convention

**REQUIRED: All feature branches MUST start with issue number**

- `feature/issue-number-description` - New features (e.g., `feature/110-select-operation`) - **REQUIRED FORMAT**
- `bugfix/issue-number-description` - Bug fixes (e.g., `bugfix/104-rectangle-persistence`)
- `hotfix/issue-number-description` - Critical production fixes
- `refactor/issue-number-description` - Code refactoring (e.g., `refactor/122-cursor-branching`)
- `docs/issue-number-description` - Documentation updates (e.g., `docs/122-workflow-docs`)
- `test/issue-number-description` - Test improvements (e.g., `test/122-branch-validation`)
- `chore/issue-number-description` - Maintenance tasks (e.g., `chore/122-dependency-updates`)

**NO EXCEPTIONS: Always use issue number prefix**

## Branch Creation Commands

```bash
# ALWAYS use issue number prefix - NO EXCEPTIONS
git checkout -b feature/110-select-operation
git checkout -b bugfix/104-rectangle-persistence
git checkout -b refactor/122-cursor-branching
git checkout -b docs/122-workflow-docs

# Using GitHub CLI (automatically creates proper naming)
gh issue develop 110 --checkout  # Creates feature/110-issue-title

# NEVER create branches without issue numbers
# WRONG: git checkout -b feature/rectangle-styling
# RIGHT: git checkout -b feature/122-rectangle-styling
```

## Commit Message Format

- Start with issue number: `#123: type(scope): description`
- Must include issue number for traceability
- Use conventional commits format after issue number
- Types: feat, fix, docs, style, refactor, test, chore
- Scopes: rectangle, dot, canvas, ui, test, etc.
- Examples:
  - `#107: feat(rectangle): implement rectangle resize operation`
  - `#104: fix(canvas): resolve rectangle persistence issue`
  - `#128: style(lint): update formatting standards`
  - `#110: test(rectangle): add creation and selection tests`

## Pull Request Title Format

- Start with issue number: `#123: type(scope): description`
- Must include issue number for traceability
- Follow conventional commit format after issue number
- Examples:
  - `#107: feat(rectangle): implement rectangle resize operation`
  - `#104: fix(canvas): resolve rectangle persistence issue`
  - `#128: style(lint): update formatting standards`
  - `#110: test(rectangle): add creation and selection tests`

## Development Workflow

1. **Prepare**: Follow Pre-Development Workflow (fetch, checkout main, pull latest)
2. **Start**: `git checkout -b feature/issue-number-description`
3. **Develop**: Implement feature with comprehensive tests
4. **Test**: Run `flutter test` and ensure all tests pass
5. **Format**: Run `flutter format .` to format code
6. **Commit**: Use conventional commit messages
7. **Push**: Push feature branch to remote
8. **PR**: Create pull request with detailed description
9. **Review**: Address review feedback
10. **Merge**: Merge to main after approval

## Essential Commands Reference

```bash
# Development workflow
git fetch origin && git checkout main && git pull origin main
git checkout -b feature/123-description

# Testing & Quality
flutter test                    # Run all tests
flutter format .               # Format code
flutter analyze               # Check for issues
dart format --set-exit-if-changed .  # CI format check

# Branch management
git rebase origin/main         # Update branch with latest main
git push --force-with-lease    # Force push after rebase
gh pr create --title "..."     # Create PR with GitHub CLI

# Issue management
gh issue list --state open     # List open issues
gh issue view 123             # View specific issue
gh issue develop 123 --checkout # Create branch from issue
```

## Issue Management Guidelines

- **Always create issues first** before starting development
- **Use descriptive issue titles** that clearly state the feature/fix
- **Include acceptance criteria** in issue descriptions
- **Link related issues** when applicable
- **Assign appropriate labels** (area/canvas, phase/MVP, etc.)
- **Close issues** with PR merges using "Resolves #123"
- **Update issue status** as development progresses
- **Use GitHub CLI** for efficient issue management

## Troubleshooting Guide

### CI Failures

- Format issues: Run `flutter format .`
- Test failures: Run `flutter test` locally first
- Analysis issues: Run `flutter analyze` and fix warnings
- Dependency issues: Run `flutter pub get`

### Merge Conflicts

- Rebase on latest main: `git rebase origin/main`
- Resolve conflicts manually
- Force push: `git push --force-with-lease`
- Verify branch is up-to-date before creating PR

### PR Creation Errors

- Avoid complex descriptions with backticks
- Use simple, clear PR titles
- Check branch is up-to-date first
- Ensure CI passes before requesting review

### Performance Issues

- Profile canvas operations with Flutter DevTools
- Check for memory leaks in long-running operations
- Optimize shouldRepaint logic
- Test with large datasets
