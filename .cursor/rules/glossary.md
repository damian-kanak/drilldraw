# DrillDraw Glossary

## Core Architecture Terms

### Shape
**Definition**: Abstract base class that all drawable elements must implement.

**Interface**:
```dart
abstract class Shape {
  void paint(Canvas canvas);
  bool hitTest(Offset point);
  Rect get bounds;
  String get id;
}
```

**Usage**: All drawable elements (dots, rectangles, arrows) must implement this interface for unified storage and manipulation.

**Examples**: `DotShape`, `RectangleShape`, `ArrowShape` (future)

### SelectionManager
**Definition**: Centralized service responsible for managing selection state across all shapes.

**Responsibilities**:
- Track selected shapes
- Handle single and multi-selection
- Provide selection state queries
- Manage selection clearing

**Usage**:
```dart
// Select a single shape
selectionManager.select(shape);

// Select multiple shapes
selectionManager.selectMultiple([shape1, shape2]);

// Clear all selections
selectionManager.clearSelection();

// Query selection state
final selectedShapes = selectionManager.selectedShapes;
```

### HitTestService
**Definition**: Centralized service for determining which shape is at a given coordinate.

**Responsibilities**:
- Perform hit-testing for all shape types
- Handle coordinate transformations
- Optimize hit-testing performance
- Support area-based hit-testing

**Usage**:
```dart
// Single point hit-testing
final shape = hitTestService.hitTest(point, shapes);

// Area-based hit-testing
final shapesInArea = hitTestService.hitTestArea(rect, shapes);

// Find nearest shape
final nearestShape = hitTestService.findNearest(point, shapes);
```

### CanvasBounds
**Definition**: Constraint system that enforces all coordinates and shapes stay within canvas boundaries.

**Responsibilities**:
- Clamp coordinates to valid ranges
- Enforce minimum/maximum sizes
- Validate shape positions
- Handle boundary constraints

**Usage**:
```dart
// Clamp a point to canvas bounds
final clampedPoint = canvasBounds.clamp(point);

// Clamp a size to valid range
final clampedSize = canvasBounds.clampSize(size);

// Validate shape bounds
final isValid = canvasBounds.isValid(shape.bounds);
```

### SnapService
**Definition**: Service for snapping coordinates to grid, guides, or other shapes.

**Responsibilities**:
- Grid snapping
- Shape-to-shape snapping
- Guide line snapping
- Snap tolerance management

**Usage**:
```dart
// Snap point to grid
final snappedPoint = snapService.snapToGrid(point);

// Snap to nearest shape
final snappedPoint = snapService.snapToShape(point, shapes);

// Snap to guide lines
final snappedPoint = snapService.snapToGuides(point, guides);
```

## Canvas and Rendering Terms

### CustomPainter
**Definition**: Flutter class for custom drawing operations on canvas.

**Responsibilities**:
- Render shapes to canvas
- Handle repaint optimization
- Manage paint objects and styles
- Coordinate with Flutter's rendering pipeline

**Usage**: All shape rendering goes through specialized CustomPainter implementations.

### CombinedPainter
**Definition**: Orchestrator painter that coordinates rendering of all shapes.

**Responsibilities**:
- Coordinate multiple specialized painters
- Manage rendering order
- Handle canvas clearing
- Optimize repaint operations

### DotPainter
**Definition**: Specialized painter for rendering dot shapes.

**Responsibilities**:
- Render individual dots
- Handle dot selection highlighting
- Optimize dot rendering performance
- Manage dot-specific paint styles

### RectanglePainter
**Definition**: Specialized painter for rendering rectangle shapes.

**Responsibilities**:
- Render rectangles with proper styling
- Handle selection highlighting
- Render resize handles
- Manage rectangle-specific paint styles

## State Management Terms

### DrawingState
**Definition**: Immutable state object containing all canvas data and UI state.

**Properties**:
- `List<Dot> dots` - All dot shapes
- `List<Rectangle> rectangles` - All rectangle shapes
- `DrawingMode mode` - Current drawing mode
- `Selection? selection` - Current selection state
- `Offset? dragPreview` - Current drag preview position

**Usage**: All state changes create new DrawingState instances to maintain immutability.

### DrawingMode
**Definition**: Enum defining the current interaction mode.

**Values**:
- `dot` - Place dots on canvas
- `rectangle` - Create rectangles by dragging
- `select` - Select and manipulate existing shapes

### Selection
**Definition**: State object representing current selection.

**Properties**:
- `Set<String> selectedIds` - IDs of selected shapes
- `SelectionType type` - Single or multi-selection
- `Offset? selectionStart` - Where selection started

## Coordinate System Terms

### Local Coordinates
**Definition**: Coordinates relative to a specific widget or shape.

**Usage**: Used within CustomPainter for shape-relative positioning.

### Global Coordinates
**Definition**: Coordinates relative to the entire screen/canvas.

**Usage**: Used for hit-testing and gesture handling.

### Canvas Coordinates
**Definition**: Coordinates within the drawing canvas area.

**Usage**: All shape positions and interactions use canvas coordinates.

## Interaction Terms

### Hit Testing
**Definition**: Process of determining which shape is at a given coordinate.

**Usage**: Used for selection, hover effects, and interaction feedback.

### Drag Preview
**Definition**: Visual feedback shown during drag operations.

**Usage**: Shows where a shape will be placed or moved before the operation completes.

### Selection Feedback
**Definition**: Visual indicators showing which shapes are selected.

**Usage**: Highlights selected shapes with different colors, borders, or handles.

## Performance Terms

### Repaint Boundary
**Definition**: Flutter widget that isolates repaint operations.

**Usage**: Used to optimize canvas rendering by limiting repaint scope.

### Should Repaint
**Definition**: CustomPainter method that determines if repaint is needed.

**Usage**: Optimizes performance by skipping unnecessary redraws.

### Spatial Indexing
**Definition**: Data structure for efficient spatial queries.

**Usage**: Optimizes hit-testing and collision detection for large numbers of shapes.

## Development Terms

### ADR (Architecture Decision Record)
**Definition**: Documented architectural decisions and their rationale.

**Usage**: Guides development decisions and maintains architectural consistency.

### Canvas Controller
**Definition**: Service that orchestrates all canvas operations.

**Responsibilities**:
- Coordinate between services
- Manage state transitions
- Handle user interactions
- Maintain architectural boundaries

### Service Layer
**Definition**: Business logic layer separate from UI components.

**Usage**: Encapsulates complex operations and provides testable interfaces.

## Anti-Patterns

### God Class
**Definition**: Class with too many responsibilities.

**Avoid**: Don't put all logic in one class - use service layer pattern.

### Tight Coupling
**Definition**: Direct dependencies between unrelated components.

**Avoid**: Use interfaces and dependency injection.

### State in Painters
**Definition**: Storing mutable state in CustomPainter.

**Avoid**: Keep painters stateless and pure.

### Business Logic in Widgets
**Definition**: Complex logic in widget build methods.

**Avoid**: Extract logic to services or controllers.

## Best Practices

### Immutable State
Always use immutable state objects and create new instances for changes.

### Service Separation
Keep UI logic separate from business logic using services.

### Performance Optimization
Use const constructors, RepaintBoundary, and efficient shouldRepaint logic.

### Testing Strategy
Write unit tests for services, widget tests for UI, and integration tests for workflows.

## Common Patterns

### Factory Pattern
Use for creating different types of shapes based on mode.

### Observer Pattern
Use for notifying UI of state changes.

### Command Pattern
Use for undo/redo operations and action history.

### Strategy Pattern
Use for different layout algorithms and rendering strategies.
