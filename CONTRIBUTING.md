# Contributing to DrillDraw

Thank you for your interest in contributing to DrillDraw! This document provides guidelines for contributing to the project.

## 📋 Development Setup

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK (included with Flutter)
- Git
- Code editor (VS Code, Android Studio, or IntelliJ IDEA recommended)

### Local Setup
1. Fork the repository
2. Clone your fork locally
3. Install dependencies: `flutter pub get`
4. Run tests: `flutter test`
5. Start development: `flutter run`

## 🎨 Code Formatting

### Dart Code Formatting
All Dart code must be properly formatted using the official Dart formatter.

#### Formatting Commands
```bash
# Check if code is properly formatted
dart format --output=none --set-exit-if-changed .

# Format all Dart files
dart format .

# Format specific file
dart format lib/main.dart
```

#### Pre-commit Formatting Check
Before committing, always run:
```bash
dart format --output=none --set-exit-if-changed .
```

If formatting issues are found, fix them with:
```bash
dart format .
```

### Formatting Rules
- **Line Length**: Maximum 80 characters per line
- **Indentation**: 2 spaces (no tabs)
- **Braces**: Opening brace on same line as declaration
- **Trailing Commas**: Use trailing commas in multi-line structures
- **Import Organization**: Organize imports in this order:
  1. Dart SDK imports
  2. Flutter imports
  3. Third-party package imports
  4. Local imports

### Example Formatting
```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/drawing_state.dart';
import '../widgets/canvas.dart';

class MyWidget extends StatelessWidget {
  final String title;
  final List<String> items;

  const MyWidget({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        ...items.map((item) => ListTile(title: Text(item))),
      ],
    );
  }
}
```

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/models/drawing_state_test.dart

# Run tests in watch mode
flutter test --watch
```

### Test Guidelines
- Write tests for all new functionality
- Aim for high test coverage (>90%)
- Use descriptive test names
- Group related tests using `group()`
- Follow AAA pattern: Arrange, Act, Assert

### Example Test Structure
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_state.dart';

void main() {
  group('DrawingState Tests', () {
    test('should create empty state by default', () {
      // Arrange
      const state = DrawingState();
      
      // Act & Assert
      expect(state.dots, isEmpty);
      expect(state.rectangles, isEmpty);
    });
  });
}
```

## 🔄 Git Workflow

### Branch Naming Convention
All feature branches MUST start with an issue number:
- `feature/123-description` - New features
- `bugfix/124-description` - Bug fixes
- `refactor/125-description` - Code refactoring
- `docs/126-description` - Documentation updates

### Commit Message Format
Use conventional commits:
```
type(scope): description

feat(selection): add dot selection functionality
fix(canvas): resolve rectangle persistence issue
docs(readme): update installation instructions
test(rectangle): add creation and selection tests
```

### Pull Request Process
1. Create feature branch with issue number prefix
2. Implement changes with tests
3. Ensure all tests pass locally
4. Run formatting check: `dart format --output=none --set-exit-if-changed .`
5. Create pull request with detailed description
6. Address review feedback
7. Merge after approval

## 🏗️ Architecture Guidelines

### Project Structure
```
lib/
├── constants/          # Application constants
├── models/            # Data models and state
├── painters/          # Custom painters for canvas
├── services/          # Business logic services
├── utils/             # Utility functions
├── widgets/           # Reusable UI components
└── main.dart          # Application entry point
```

### Code Organization
- Keep files focused and small (<300 lines)
- Use meaningful variable and function names
- Add comments for complex business logic
- Follow Flutter/Dart best practices
- Use `const` constructors where possible

## 🚀 Performance Guidelines

### Canvas Operations
- Optimize painting operations for large datasets
- Use `shouldRepaint` logic effectively
- Avoid unnecessary rebuilds
- Profile performance for canvas-heavy operations

### Memory Management
- Dispose of controllers and streams properly
- Use `const` widgets to prevent rebuilds
- Be mindful of memory usage with large datasets

## 📝 Documentation

### Code Comments
- Document complex algorithms and business logic
- Use Dart doc comments for public APIs
- Keep comments up to date with code changes

### README Updates
- Update README.md for significant changes
- Document new features and APIs
- Include usage examples where helpful

## 🐛 Bug Reports

When reporting bugs, please include:
- Flutter/Dart version
- Operating system
- Steps to reproduce
- Expected vs actual behavior
- Screenshots or logs if applicable

## 💡 Feature Requests

For feature requests:
- Check existing issues first
- Provide clear use case and motivation
- Include mockups or examples if possible
- Consider implementation complexity

## 📞 Getting Help

- Check existing issues and discussions
- Join our community discussions
- Create a new issue for questions

Thank you for contributing to DrillDraw! 🎉