# DrillDraw Testing Rules

> After tests pass: see [pr-flow.md](pr-flow.md) for the PR checklist.

Keywords: test, coverage, unit, widget, integration, accessibility, regression

## Testing Requirements

- Unit tests for all models and services
- Widget tests for UI components
- Integration tests for user workflows
- Performance tests for canvas operations
- Accessibility tests for UI components

## Testing Strategy & Guidelines

- **Unit tests** for all business logic and models (DrawingState, Rectangle, etc.)
- **Widget tests** for UI components and user interactions
- **Integration tests** for complete user workflows (drawing, selecting, moving)
- **Performance tests** for canvas operations with large datasets
- **Accessibility tests** for screen reader compatibility and keyboard navigation
- **Golden tests** for UI consistency across platforms and screen sizes
- **Test coverage** minimum 80% for production code
- **Mock external dependencies** in tests to ensure isolation
- **Test edge cases** and error conditions thoroughly
- **Use realistic test data** that matches production scenarios
- **Automate test execution** in CI/CD pipeline
- **Document test scenarios** and expected behaviors
- **Test canvas operations** with various shape counts and complexities
- **Validate gesture handling** with different input methods (touch, mouse)
- **Test state management** for complex operations (move, resize, delete)
- **Verify error handling** and user feedback mechanisms
- **Test performance** under different device capabilities
- **Validate accessibility** with assistive technologies
- **Test cross-platform** compatibility (web, mobile, desktop)
- **Regression testing** after each change to prevent breaking existing functionality

## Code Review (Testing)

- **Check test coverage** for new functionality (aim for 80%+ coverage)
- **Test with realistic data** to catch edge cases and performance issues
