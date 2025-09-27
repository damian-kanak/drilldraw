# DrillDraw Architecture Rules

## Core Architectural Constraints

### Shape Abstraction
- **ALL drawables MUST implement `Shape` interface**
- No direct rendering of dots/rectangles without Shape abstraction
- Unified storage via `List<Shape>` instead of separate lists

### Selection Management  
- **Selection ONLY via `SelectionManager`**
- No direct selection state in widgets
- Centralized selection logic and state

### Hit Testing
- **Hit-testing ONLY via `HitTestService`**
- No direct hit-testing in painters or widgets
- Unified hit-testing logic across all shapes

### Widget Architecture
- **Widgets MUST be thin (logic in `CanvasController`)**
- No business logic in UI components
- All canvas operations through controller

### Canvas Bounds
- **Enforce `CanvasBounds` constraints**
- All coordinates must be within canvas bounds
- Proper boundary checking for all operations

### CanvasBounds Service
- **Centralized coordinate validation service**
- Provides clamping, size normalization, and bounds checking
- Integrates with snapping and shape creation services

## Implementation Rules

### Shape Interface Requirements
```dart
abstract class Shape {
  void paint(Canvas canvas);
  bool hitTest(Offset point);
  Rect get bounds;
  String get id;
}
```

### SelectionManager Usage
```dart
// ✅ Correct: Use SelectionManager
selectionManager.select(shape);
selectionManager.clearSelection();

// ❌ Wrong: Direct selection state
widget.selected = true;
```

### HitTestService Usage
```dart
// ✅ Correct: Use HitTestService
final shape = hitTestService.hitTest(point, shapes);

// ❌ Wrong: Direct hit-testing
if (rect.contains(point)) { /* ... */ }
```

### CanvasController Pattern
```dart
// ✅ Correct: Thin widgets, logic in controller
class DotCanvas extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => canvasController.handleTap(context.localToGlobal(offset)),
      child: CustomPaint(painter: painter),
    );
  }
}

// ❌ Wrong: Business logic in widget
class DotCanvas extends StatefulWidget {
  void _handleTap() {
    // Business logic here - WRONG!
  }
}
```

### CanvasBounds Service Implementation
```dart
class CanvasBounds {
  final Rect bounds;
  
  // Clamp point within bounds
  Offset clamp(Offset point);
  
  // Clamp size to minimum and maximum
  Size clampSize(Size size);
  
  // Check if point is within bounds
  bool contains(Offset point);
  
  // Check if rect intersects with bounds
  bool intersects(Rect rect);
}
```

### CanvasBounds Usage
```dart
// ✅ Correct: Always use CanvasBounds service
final clampedPoint = canvasBounds.clamp(userPoint);
final clampedSize = canvasBounds.clampSize(userSize);
final snappedPoint = snapToGrid(clampedPoint);

// ❌ Wrong: Direct coordinate usage
final shape = Rectangle(userPoint, userSize); // No validation
```

### Canvas Coordinate Validation Rules
- **ALL coordinates MUST be clamped within canvas bounds**
- **NEVER allow coordinates outside canvas boundaries**
- **ALWAYS validate coordinates before drawing operations**
- **ALL shapes MUST have minimum size constraints**
- **SNAP coordinates AFTER clamping, never before**

### Required Validation Pattern
```dart
// ✅ Correct: Always validate coordinates
final clampedPoint = canvasBounds.clamp(point);
final clampedSize = canvasBounds.clampSize(size);
final snappedPoint = snapToGrid(clampedPoint);

// ❌ Wrong: No validation
final shape = Rectangle(point, size); // Could be outside bounds
```

### Error Handling Requirements
```dart
// ✅ Correct: Graceful error handling
try {
  final shape = createShape(validatedPoint, validatedSize);
  if (canvasBounds.contains(shape.bounds)) {
    drawingState.addShape(shape);
  } else {
    throw CanvasBoundsException('Shape outside canvas bounds');
  }
} catch (e) {
  showUserError('Cannot create shape: ${e.message}');
}
```

## Anti-Patterns to Avoid

### ❌ Direct Shape Manipulation
```dart
// ❌ Wrong: Direct shape access
shapes.add(newShape);
shapes.remove(shape);

// ✅ Correct: Use controller
canvasController.addShape(newShape);
canvasController.removeShape(shape);
```

### ❌ Widget State Management
```dart
// ❌ Wrong: State in widgets
class DotCanvas extends StatefulWidget {
  List<Rectangle> rectangles = [];
  List<Dot> dots = [];
}

// ✅ Correct: State in controller
class DotCanvas extends StatelessWidget {
  final CanvasController controller;
}
```

### ❌ Direct Painter Hit-Testing
```dart
// ❌ Wrong: Hit-testing in painter
class RectanglePainter extends CustomPainter {
  bool hitTest(Offset point) {
    return rect.contains(point); // WRONG!
  }
}

// ✅ Correct: Use HitTestService
class RectanglePainter extends CustomPainter {
  // Only rendering logic
}
```

## Enforcement Guidelines

### Code Review Checklist
- [ ] All shapes implement `Shape` interface
- [ ] No direct selection state in widgets
- [ ] All hit-testing goes through `HitTestService`
- [ ] Widgets contain only UI logic
- [ ] All coordinates are bounds-checked
- [ ] Canvas operations go through `CanvasController`

### Architecture Validation
- **Shape Abstraction**: Verify all drawables implement `Shape`
- **Selection Management**: Confirm no direct selection state
- **Hit Testing**: Ensure all hit-testing uses service
- **Widget Thickness**: Check widgets are thin
- **Bounds Enforcement**: Validate all coordinates are clamped

## Migration Path

### Current State → Target State
1. **Extract services** from existing code
2. **Implement Shape interface** for all drawables
3. **Create SelectionManager** and migrate selection logic
4. **Create HitTestService** and migrate hit-testing
5. **Create CanvasController** and migrate business logic
6. **Enforce bounds checking** throughout codebase

### Implementation Priority
1. **Shape interface** (foundation)
2. **SelectionManager** (selection logic)
3. **HitTestService** (hit-testing logic)
4. **CanvasController** (orchestration)
5. **Bounds enforcement** (safety)