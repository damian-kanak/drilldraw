# Contributing to DrillDraw

Thank you for your interest in contributing to DrillDraw! This document provides guidelines for contributing to the project.

## 🏷️ Label System

We use a simplified label system with 18 essential labels to organize issues and pull requests.

### Area Labels (8)
Categorize issues by the area of the codebase they affect:

- **`area-canvas`** - Canvas drawing and interaction features
- **`area-node`** - Node creation and management functionality  
- **`area-edge`** - Edge/connection functionality
- **`area-hierarchy`** - Hierarchical structure features
- **`area-ui`** - User interface components and layout
- **`area-devops`** - CI/CD, deployment, and infrastructure
- **`area-docs`** - Documentation and guides
- **`area-mermaid`** - Mermaid diagram integration

### Kind Labels (4)
Classify the type of work:

- **`kind-feature`** - New feature or enhancement
- **`kind-bug`** - Bug fix or issue resolution
- **`kind-chore`** - Maintenance, refactoring, cleanup
- **`kind-spike`** - Research, experimentation, proof of concept

### Priority Labels (3)
Indicate the urgency and importance:

- **`prio-P1`** - Critical priority - must fix immediately
- **`prio-P2`** - High priority - should fix soon  
- **`prio-P3`** - Medium priority - nice to have

### Phase Labels (3)
Show which development phase the issue belongs to:

- **`phase-PoC`** - Proof of Concept phase
- **`phase-MVP`** - Minimum Viable Product phase
- **`phase-Beta`** - Beta release phase

## 🚀 Getting Started

### Prerequisites
- Flutter 3.24.0 or later
- Dart SDK 3.3.0 or later
- Git
- GitHub account

### Development Setup
1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/drilldraw.git`
3. Navigate to the project: `cd drilldraw`
4. Install dependencies: `flutter pub get`
5. Run the app: `flutter run`

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run analysis
flutter analyze

# Check formatting
dart format --set-exit-if-changed .
```

## 📝 Contributing Process

### 1. Create an Issue
Before starting work, create an issue to discuss:
- What you want to implement
- Why it's needed
- How you plan to approach it

### 2. Fork and Branch
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes

### 3. Code Standards
- Follow Dart/Flutter style guidelines
- Write tests for new functionality
- Ensure all tests pass
- Run `flutter analyze` and fix any issues
- Format code with `dart format .`

### 4. Commit Messages
Use clear, descriptive commit messages:
```
feat: add canvas zoom functionality
fix: resolve dot placement accuracy issue
docs: update README with new features
test: add unit tests for dot management
```

### 5. Pull Request
1. Push your branch: `git push origin feature/your-feature-name`
2. Create a pull request
3. Ensure CI checks pass
4. Request review from maintainers

## 🔍 Issue Guidelines

### Creating Issues
- Use clear, descriptive titles
- Provide detailed descriptions
- Include steps to reproduce (for bugs)
- Add relevant labels
- Link to related issues

### Labeling Issues
When creating issues, apply appropriate labels:
- **Area**: Which part of the system is affected
- **Kind**: What type of work is needed
- **Priority**: How urgent is it
- **Phase**: Which development phase it belongs to

### Example Issue
```
Title: Canvas zoom functionality not working on mobile devices

Labels: area-canvas, kind-bug, prio-P2, phase-MVP

Description:
The canvas zoom feature works on desktop but fails on mobile devices.

Steps to reproduce:
1. Open app on mobile device
2. Try to pinch-to-zoom on canvas
3. Observe that zoom doesn't work

Expected behavior:
Canvas should zoom in/out with pinch gestures

Actual behavior:
Canvas remains at fixed zoom level
```

## 🧪 Testing Guidelines

### Test Coverage
- Aim for high test coverage
- Write unit tests for business logic
- Write widget tests for UI components
- Write integration tests for user flows

### Test Structure
```dart
group('Dot Management', () {
  test('should add dot when canvas is tapped', () {
    // Test implementation
  });
  
  test('should remove dot when clear button is pressed', () {
    // Test implementation
  });
});
```

## 📚 Documentation

### Code Documentation
- Document public APIs with Dartdoc comments
- Include examples for complex functions
- Keep documentation up to date

### README Updates
- Update README.md when adding new features
- Include screenshots for UI changes
- Update installation instructions if needed

## 🔒 Security

### Security Issues
- Report security issues privately to maintainers
- Use `prio-P1` priority for security issues
- Apply `area-devops` or relevant area label

### Code Security
- Validate all user inputs
- Use secure coding practices
- Follow Flutter security guidelines

## 🎯 Development Phases

### PoC (Proof of Concept)
- Core canvas functionality
- Basic dot placement
- Simple UI
- Essential CI/CD

### MVP (Minimum Viable Product)
- Complete diagram editor
- Node and edge management
- Hierarchical structures
- Performance optimization

### Beta
- Advanced features
- Mermaid integration
- PWA capabilities
- Production readiness

## 📞 Getting Help

- Check existing issues first
- Join our discussions
- Ask questions in issues
- Review documentation

## 📄 License

By contributing to DrillDraw, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to DrillDraw! 🎨