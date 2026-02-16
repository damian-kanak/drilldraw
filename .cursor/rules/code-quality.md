# DrillDraw Code Quality Rules

Keywords: quality, performance, Flutter, canvas, review, documentation, accessibility

## Code Quality Standards

- **Tests**: Always write tests for new functionality
- **Flutter**: Follow Flutter/Dart best practices and conventions
- **Naming**: Use meaningful variable, function, and class names
- **Comments**: Add comments for complex logic and business rules
- **Functions**: Keep functions small and focused (max 20-30 lines)
- **Imports**: Organize imports (dart, flutter, packages, local)
- **Constants**: Use AppConstants for all magic numbers and colors
- **Error Handling**: Implement proper error handling and validation

## Project Structure

- `lib/models/` - Data models and state management
- `lib/painters/` - Custom painters for canvas rendering
- `lib/widgets/` - Reusable UI components
- `lib/services/` - Business logic and external services
- `lib/constants/` - Application constants and configuration
- `lib/utils/` - Utility functions and helpers
- `test/` - Unit and widget tests organized by feature

## Performance Guidelines

- Optimize canvas painting operations
- Use const constructors where possible
- Implement proper shouldRepaint logic
- Avoid unnecessary rebuilds
- Profile performance for large datasets

## Performance & Optimization Guidelines

- **Profile canvas operations** for large datasets
- **Use const constructors** where possible
- **Implement shouldRepaint** logic efficiently
- **Avoid unnecessary setState** calls
- **Optimize gesture detection** for smooth interactions
- **Test with realistic data sizes**
- **Monitor memory usage** during development
- **Use Flutter DevTools** for performance profiling
- **Optimize painting operations** in custom painters
- **Cache expensive calculations** when possible

## Accessibility Requirements

- Semantic labels for all interactive elements
- Keyboard navigation support
- Screen reader compatibility
- High contrast mode support
- Focus management for canvas interactions

## Error Handling & Debugging Guidelines

- **Always check CI status** before considering work complete
- **Run tests locally** before pushing: `flutter test`
- **Format code** before committing: `flutter format .`
- **Analyze code** before committing: `flutter analyze`
- **Handle merge conflicts** by rebasing on latest main
- **Verify branch is up-to-date** before creating PRs
- **Check pre-commit hooks** - they run automatically on commit
- **Test with realistic data** to catch edge cases early
- **Use debug prints** sparingly and remove before committing

## Pull Request Best Practices

- **Always check merge conflicts** before creating PR
- **Use simple PR descriptions** to avoid shell parsing issues
- **Avoid backticks in PR descriptions** (causes command substitution errors)
- **Include acceptance criteria** in PR description
- **Reference related issues** with "Resolves #123"
- **Ensure CI passes** before requesting review
- **Keep PRs focused** - one feature per PR
- **Write descriptive titles** following conventional commit format
- **Add screenshots** for UI changes when applicable

## Flutter-Specific Best Practices

- **Use const constructors** wherever possible for performance optimization
- **Implement proper dispose()** methods to prevent memory leaks
- **Use RepaintBoundary** for expensive widget subtrees to limit repaints
- **Optimize CustomPainter** with efficient shouldRepaint logic
- **Use proper keys** for widget identity and performance (ValueKey, ObjectKey)
- **Implement proper gesture handling** with GestureDetector and appropriate callbacks
- **Choose appropriate widget types** (StatelessWidget vs StatefulWidget vs RenderObjectWidget)
- **Follow Material Design** guidelines for UI consistency and user experience
- **Use proper state management** patterns (setState, Provider, Riverpod, Bloc)
- **Implement proper error boundaries** with ErrorWidget.builder
- **Use efficient list rendering** with ListView.builder for large datasets
- **Optimize image handling** with proper caching and sizing
- **Implement proper navigation** with named routes and proper back stack management
- **Use appropriate animation** controllers and avoid unnecessary rebuilds
- **Implement proper theming** with ThemeData and consistent color schemes
- **Use proper text styling** with TextTheme and consistent typography
- **Implement proper responsive design** with MediaQuery and LayoutBuilder
- **Use proper asset management** with pubspec.yaml and asset bundles
- **Implement proper localization** support for international users
- **Use proper debugging tools** (Flutter Inspector, DevTools, debugPrint)

## Canvas-Specific Guidelines

- **Optimize hit testing** for large numbers of shapes using spatial indexing
- **Use efficient collision detection** algorithms (AABB, spatial partitioning)
- **Implement proper gesture handling** for touch/mouse events with appropriate thresholds
- **Handle coordinate system** transformations correctly (local vs global coordinates)
- **Optimize painting operations** for smooth performance (avoid unnecessary redraws)
- **Implement proper selection feedback** for user interaction (visual indicators)
- **Handle edge cases** (empty canvas, single shapes, overlapping elements)
- **Use appropriate canvas sizes** and viewport management for different screen sizes
- **Implement proper zoom/pan** functionality when needed with coordinate transformations
- **Optimize CustomPainter** with efficient shouldRepaint logic to minimize redraws
- **Use proper paint objects** and avoid creating new Paint instances in paint() methods
- **Implement efficient shape rendering** with appropriate anti-aliasing settings
- **Handle high-DPI displays** correctly with proper pixel ratio calculations
- **Use proper clipping** to improve performance and prevent overflow
- **Implement proper caching** for expensive drawing operations when possible
- **Handle touch events** with appropriate hit testing and gesture recognition
- **Use proper coordinate systems** for different input devices (touch vs mouse)
- **Implement proper undo/redo** functionality with state snapshots
- **Handle memory management** for large numbers of drawn elements
- **Use proper debugging** with canvas overlay tools for development

## Code Review Guidelines

- **Review for logic correctness** and edge cases in business logic
- **Check test coverage** for new functionality (aim for 80%+ coverage)
- **Verify performance impact** for canvas operations and large datasets
- **Ensure accessibility compliance** for UI changes and interactions
- **Validate error handling** and user feedback mechanisms
- **Check for code duplication** and suggest refactoring opportunities
- **Verify documentation** is updated appropriately (comments, README, etc.)
- **Test with realistic data** to catch edge cases and performance issues
- **Review security implications** of new features and data handling
- **Check for memory leaks** in long-running operations and dispose methods
- **Validate state management** patterns are consistent and efficient
- **Review UI/UX consistency** with existing design patterns and Material Design
- **Check Flutter best practices** (const constructors, proper keys, etc.)
- **Verify canvas optimization** (shouldRepaint logic, efficient painting)
- **Review gesture handling** for proper touch/mouse event processing
- **Validate coordinate systems** and transformations for canvas operations
- **Check for proper null safety** and defensive programming practices
- **Review commit message quality** and conventional commit format
- **Verify branch naming** follows issue number conventions
- **Ensure PR description** includes acceptance criteria and testing notes

## Documentation Standards

- **Comment complex algorithms** (e.g., hit testing, collision detection)
- **Document public APIs** with dartdoc comments
- **Update README** for new features
- **Include usage examples** in widget documentation
- **Document breaking changes** in PR descriptions
- **Write clear commit messages** explaining what and why
- **Document configuration changes** in .cursorrules updates
- **Include inline comments** for business logic
- **Document edge cases** and error handling
