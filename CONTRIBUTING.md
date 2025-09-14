# Contributing to DrillDraw

Thank you for your interest in contributing to DrillDraw! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Development Standards](#development-standards)
- [Testing](#testing)
- [Architecture Guidelines](#architecture-guidelines)
- [Issue Guidelines](#issue-guidelines)

## Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [your-email@example.com].

## Getting Started

### Prerequisites

- Flutter SDK (version 3.9.2 or higher)
- Dart SDK
- Git
- A code editor (VS Code, Android Studio, or IntelliJ IDEA)

### Setup

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/your-username/drilldraw.git
   cd drilldraw
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app to ensure everything works:
   ```bash
   flutter run
   ```

## Development Workflow

### Branching Strategy

We use **trunk-based development** with short-lived feature branches:

- `main` - Production-ready code
- `feature/description` - New features (e.g., `feature/canvas-zoom`)
- `fix/description` - Bug fixes (e.g., `fix/edge-rendering`)
- `chore/description` - Maintenance tasks (e.g., `chore/update-deps`)

### Branch Naming Convention

Use descriptive branch names:
- `feature/canvas-pan-zoom`
- `fix/node-drag-snap`
- `chore/update-flutter-sdk`
- `docs/update-readme`

## Commit Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools

### Examples

```bash
feat(canvas): add pan and zoom functionality
fix(edge): resolve edge rendering on node move
docs: update README with new features
test(node): add unit tests for node creation
chore(deps): update Flutter to 3.24.0
```

## Pull Request Process

### Before Submitting

1. **Check existing issues** - Ensure your work addresses an existing issue or create one
2. **Update tests** - Add tests for new functionality
3. **Update documentation** - Update relevant docs
4. **Run checks locally**:
   ```bash
   flutter analyze
   flutter test
   flutter format .
   ```

### PR Requirements

- [ ] **Description**: Clear description of changes
- [ ] **Tests**: All tests pass
- [ ] **Documentation**: Updated if needed
- [ ] **Breaking Changes**: Documented if any
- [ ] **Issue Reference**: Links to related issue(s)

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Widget tests pass
- [ ] Integration tests pass (if applicable)
- [ ] Manual testing completed

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or documented)

## Related Issues
Fixes #(issue number)
```

## Development Standards

### Code Style

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter format .` before committing
- Follow SOLID principles (see [ADR-0001](docs/ADR-0001-architecture.md))

### Architecture

- Follow layered architecture (Model → Services → Presentation)
- Use dependency injection with Riverpod
- Implement interfaces for testability
- Keep components focused and single-responsibility

### Performance

- Target 60fps with 500+ nodes
- Use `RepaintBoundary` for canvas rendering
- Implement proper state management
- Profile performance-critical code

## Testing

### Testing Strategy

We follow the testing pyramid:

1. **Unit Tests** (75% coverage target)
   - Pure logic (layout math, commands, serializers)
   - Run: `flutter test test/unit/`

2. **Widget/Golden Tests**
   - UI components and rendering
   - Run: `flutter test test/widget/`

3. **Integration Tests**
   - End-to-end user flows
   - Run: `flutter test integration_test/`

### Running Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/widget/canvas_test.dart

# Coverage report
flutter test --coverage
```

## Architecture Guidelines

### SOLID Principles

- **SRP**: Single Responsibility - separate model, layout, rendering, interaction
- **OCP**: Open/Closed - plugin architecture for layouts and serializers
- **LSP**: Liskov Substitution - interchangeable service implementations
- **ISP**: Interface Segregation - narrow, focused interfaces
- **DIP**: Dependency Inversion - depend on abstractions via Riverpod

### Key Components

- **Model**: Immutable entities (`Node`, `Edge`, `DiagramSpace`)
- **Services**: `LayoutService`, `CommandService`, `DiagramRepository`
- **Presentation**: Widgets and painters
- **Integration**: Mermaid bridge with proper interfaces

## Issue Guidelines

### Bug Reports

Include:
- Flutter/Dart version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable

### Feature Requests

Include:
- Use case description
- Proposed solution
- Alternative solutions considered
- Impact on existing functionality

### Labels

We use structured labels:
- `area/*` - Component area (canvas, node, edge, etc.)
- `kind/*` - Type (feature, bug, chore, etc.)
- `prio/*` - Priority (P1, P2, P3)
- `milestone/*` - Development milestone

## Getting Help

- **Issues**: Use GitHub Issues for bugs and feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Check existing docs in `/docs` folder

## Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md file
- Release notes
- Project README

Thank you for contributing to DrillDraw! 🚀
