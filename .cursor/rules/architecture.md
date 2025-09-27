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

### CanvasBounds Enforcement
```dart
// ✅ Correct: Always check bounds
final clampedPoint = canvasBounds.clamp(point);
final clampedSize = canvasBounds.clampSize(size);

// ❌ Wrong: No bounds checking
final shape = Rectangle(point, size); // Could be outside bounds
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