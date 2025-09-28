import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'dot_shape.dart';
import 'drawing_mode.dart';
import 'rectangle.dart';
import 'rectangle_shape.dart';
import 'shape.dart';

/// Represents the current state of the drawing canvas
class DrawingState {
  final List<Offset> dots;
  final List<Rectangle> rectangles;

  /// Unified storage for all shapes (new system)
  final List<Shape> shapes;

  final Offset? selectedDot;
  final String? selectedRectangleId;
  final DrawingMode drawingMode;
  final bool isDrawing;
  final Rect? dragPreview;
  final bool isMoving;
  final Offset? moveStartPosition;
  final bool isResizing;
  final String? resizeHandle;
  final Offset? resizeStartPosition;
  final Rect? resizeStartBounds;

  const DrawingState({
    this.dots = const [],
    this.rectangles = const [],
    this.shapes = const [],
    this.selectedDot,
    this.selectedRectangleId,
    this.drawingMode = DrawingMode.dot,
    this.isDrawing = false,
    this.dragPreview,
    this.isMoving = false,
    this.moveStartPosition,
    this.isResizing = false,
    this.resizeHandle,
    this.resizeStartPosition,
    this.resizeStartBounds,
  });

  /// Create a copy of this state with updated values
  DrawingState copyWith({
    List<Offset>? dots,
    List<Rectangle>? rectangles,
    List<Shape>? shapes,
    Offset? selectedDot,
    String? selectedRectangleId,
    DrawingMode? drawingMode,
    bool? isDrawing,
    Rect? dragPreview,
    bool? isMoving,
    Offset? moveStartPosition,
    bool? isResizing,
    String? resizeHandle,
    Offset? resizeStartPosition,
    Rect? resizeStartBounds,
    bool clearSelectedDot = false,
    bool clearSelectedRectangleId = false,
    bool clearDragPreview = false,
    bool clearMoveStartPosition = false,
    bool clearResizeHandle = false,
    bool clearResizeStartPosition = false,
    bool clearResizeStartBounds = false,
  }) {
    return DrawingState(
      dots: dots ?? this.dots,
      rectangles: rectangles ?? this.rectangles,
      shapes: shapes ?? this.shapes,
      selectedDot: clearSelectedDot ? null : (selectedDot ?? this.selectedDot),
      selectedRectangleId: clearSelectedRectangleId
          ? null
          : (selectedRectangleId ?? this.selectedRectangleId),
      drawingMode: drawingMode ?? this.drawingMode,
      isDrawing: isDrawing ?? this.isDrawing,
      dragPreview: clearDragPreview ? null : (dragPreview ?? this.dragPreview),
      isMoving: isMoving ?? this.isMoving,
      moveStartPosition: clearMoveStartPosition
          ? null
          : (moveStartPosition ?? this.moveStartPosition),
      isResizing: isResizing ?? this.isResizing,
      resizeHandle:
          clearResizeHandle ? null : (resizeHandle ?? this.resizeHandle),
      resizeStartPosition: clearResizeStartPosition
          ? null
          : (resizeStartPosition ?? this.resizeStartPosition),
      resizeStartBounds: clearResizeStartBounds
          ? null
          : (resizeStartBounds ?? this.resizeStartBounds),
    );
  }

  /// Add a new dot to the canvas
  DrawingState addDot(Offset position) {
    final newDots = List<Offset>.from(dots)..add(position);
    return copyWith(dots: newDots);
  }

  /// Add a new rectangle to the canvas
  DrawingState addRectangle(Rectangle rectangle) {
    final newRectangles = List<Rectangle>.from(rectangles)..add(rectangle);
    return copyWith(rectangles: newRectangles);
  }

  /// Update an existing rectangle
  DrawingState updateRectangle(String id, Rectangle updatedRectangle) {
    if (isUsingUnifiedStorage) {
      // Use unified storage
      final newShapes = shapes.map((shape) {
        if (shape is RectangleShape && shape.id == id) {
          return RectangleShape.fromRectangle(updatedRectangle);
        }
        return shape;
      }).toList();
      return copyWith(shapes: newShapes);
    } else {
      // Use legacy storage
      final newRectangles = rectangles.map((rect) {
        return rect.id == id ? updatedRectangle : rect;
      }).toList();
      return copyWith(rectangles: newRectangles);
    }
  }

  /// Remove a rectangle by ID
  DrawingState removeRectangle(String id) {
    if (isUsingUnifiedStorage) {
      // Use unified storage
      final newShapes = shapes
          .where((shape) => !(shape is RectangleShape && shape.id == id))
          .toList();
      return copyWith(shapes: newShapes);
    } else {
      // Use legacy storage
      final newRectangles = rectangles.where((rect) => rect.id != id).toList();
      return copyWith(rectangles: newRectangles);
    }
  }

  /// Select a dot by position
  DrawingState selectDot(Offset position) {
    // First, deselect all rectangles
    final deselectedRectangles = rectangles.map((rect) {
      return rect.isSelected ? rect.copyWith(isSelected: false) : rect;
    }).toList();

    return copyWith(
      selectedDot: position,
      rectangles: deselectedRectangles,
      clearSelectedRectangleId: true, // Clear rectangle selection
    );
  }

  /// Clear dot selection
  DrawingState clearDotSelection() {
    return copyWith(clearSelectedDot: true);
  }

  /// Select a rectangle by ID
  DrawingState selectRectangle(String id) {
    // First, deselect all rectangles
    final deselectedRectangles = rectangles.map((rect) {
      return rect.isSelected ? rect.copyWith(isSelected: false) : rect;
    }).toList();

    // Then select the specified rectangle
    final updatedRectangles = deselectedRectangles.map((rect) {
      return rect.id == id ? rect.copyWith(isSelected: true) : rect;
    }).toList();

    return copyWith(
      rectangles: updatedRectangles,
      selectedRectangleId: id,
      clearSelectedDot: true, // Clear dot selection
    );
  }

  /// Clear selection from all rectangles
  DrawingState clearRectangleSelection() {
    final deselectedRectangles = rectangles.map((rect) {
      return rect.isSelected ? rect.copyWith(isSelected: false) : rect;
    }).toList();

    return copyWith(
      rectangles: deselectedRectangles,
      clearSelectedRectangleId: true,
      clearSelectedDot: true, // Also clear dot selection
    );
  }

  /// Clear all selections (dots, rectangles, arrows)
  DrawingState clearAllSelections() {
    final deselectedRectangles = rectangles.map((rect) {
      return rect.isSelected ? rect.copyWith(isSelected: false) : rect;
    }).toList();

    return copyWith(
      rectangles: deselectedRectangles,
      clearSelectedRectangleId: true,
      clearSelectedDot: true,
    );
  }

  /// Clear all dots from the canvas
  DrawingState clearDots() {
    return copyWith(dots: []);
  }

  /// Clear all rectangles from the canvas
  DrawingState clearRectangles() {
    return copyWith(rectangles: [], clearSelectedRectangleId: true);
  }

  /// Clear all shapes from the canvas
  DrawingState clearAll() {
    return copyWith(
      dots: [],
      rectangles: [],
      clearSelectedDot: true,
      clearSelectedRectangleId: true,
    );
  }

  /// Delete selected shapes (dots and rectangles)
  DrawingState deleteSelectedShapes() {
    // Start with current state
    DrawingState newState = this;

    // Delete selected dot if any
    if (selectedDot != null) {
      final newDots = dots.where((dot) => dot != selectedDot).toList();
      newState = newState.copyWith(
        dots: newDots,
        clearSelectedDot: true,
      );
    }

    // Delete selected rectangle if any
    if (selectedRectangleId != null) {
      final newRectangles =
          rectangles.where((rect) => rect.id != selectedRectangleId).toList();
      newState = newState.copyWith(
        rectangles: newRectangles,
        clearSelectedRectangleId: true,
      );
    }

    return newState;
  }

  /// Delete a specific dot by position
  DrawingState deleteDot(Offset position) {
    final newDots = dots.where((dot) => dot != position).toList();
    final shouldClearSelection = selectedDot == position;
    return copyWith(
      dots: newDots,
      clearSelectedDot: shouldClearSelection,
    );
  }

  /// Delete a specific rectangle by ID
  DrawingState deleteRectangle(String id) {
    final newRectangles = rectangles.where((rect) => rect.id != id).toList();
    final shouldClearSelection = selectedRectangleId == id;
    return copyWith(
      rectangles: newRectangles,
      clearSelectedRectangleId: shouldClearSelection,
    );
  }

  /// Set the drawing mode
  DrawingState setDrawingMode(DrawingMode mode) {
    return copyWith(
      drawingMode: mode,
      clearSelectedDot: true,
      clearSelectedRectangleId: true,
    );
  }

  /// Set the drag preview rectangle
  DrawingState setDragPreview(Rect? preview) {
    return copyWith(dragPreview: preview);
  }

  /// Clear the drag preview
  DrawingState clearDragPreview() {
    return copyWith(clearDragPreview: true);
  }

  /// Start moving a selected rectangle
  DrawingState startMoveOperation(Offset startPosition) {
    if (selectedRectangleId == null) return this;

    return copyWith(
      isMoving: true,
      moveStartPosition: startPosition,
    );
  }

  /// Update the position of the rectangle being moved
  DrawingState updateMoveOperation(Offset currentPosition) {
    if (!isMoving || moveStartPosition == null || selectedRectangleId == null) {
      return this;
    }

    final delta = currentPosition - moveStartPosition!;
    final updatedRectangles = rectangles.map((rect) {
      if (rect.id == selectedRectangleId) {
        return rect.copyWith(
          bounds: rect.bounds.translate(delta.dx, delta.dy),
        );
      }
      return rect;
    }).toList();

    return copyWith(
      rectangles: updatedRectangles,
      moveStartPosition: currentPosition, // Update start position for next
      // delta
    );
  }

  /// End the move operation
  DrawingState endMoveOperation() {
    return copyWith(
      isMoving: false,
      clearMoveStartPosition: true,
    );
  }

  /// Start resizing a selected rectangle
  DrawingState startResizeOperation(
    String handle,
    Offset startPosition,
  ) {
    if (selectedRectangleId == null) return this;

    final selectedRect = selectedRectangle;
    if (selectedRect == null) return this;

    return copyWith(
      isResizing: true,
      resizeHandle: handle,
      resizeStartPosition: startPosition,
      resizeStartBounds: selectedRect.bounds,
    );
  }

  /// Update the size of the rectangle being resized
  DrawingState updateResizeOperation(Offset currentPosition) {
    if (!isResizing ||
        resizeHandle == null ||
        resizeStartPosition == null ||
        resizeStartBounds == null ||
        selectedRectangleId == null) {
      return this;
    }

    final delta = currentPosition - resizeStartPosition!;
    final newBounds = _calculateResizedBounds(
      resizeStartBounds!,
      resizeHandle!,
      delta,
    );

    final updatedRectangles = rectangles.map((rect) {
      if (rect.id == selectedRectangleId) {
        return rect.copyWith(bounds: newBounds);
      }
      return rect;
    }).toList();

    return copyWith(rectangles: updatedRectangles);
  }

  /// End the resize operation
  DrawingState endResizeOperation() {
    return copyWith(
      isResizing: false,
      clearResizeHandle: true,
      clearResizeStartPosition: true,
      clearResizeStartBounds: true,
    );
  }

  /// Calculate the new bounds for a resize operation
  Rect _calculateResizedBounds(
    Rect originalBounds,
    String handle,
    Offset delta,
  ) {
    double left = originalBounds.left;
    double top = originalBounds.top;
    double right = originalBounds.right;
    double bottom = originalBounds.bottom;

    switch (handle) {
      case 'topLeft':
        left = originalBounds.left + delta.dx;
        top = originalBounds.top + delta.dy;
        break;
      case 'topRight':
        right = originalBounds.right + delta.dx;
        top = originalBounds.top + delta.dy;
        break;
      case 'bottomLeft':
        left = originalBounds.left + delta.dx;
        bottom = originalBounds.bottom + delta.dy;
        break;
      case 'bottomRight':
        right = originalBounds.right + delta.dx;
        bottom = originalBounds.bottom + delta.dy;
        break;
      case 'top':
        top = originalBounds.top + delta.dy;
        break;
      case 'bottom':
        bottom = originalBounds.bottom + delta.dy;
        break;
      case 'left':
        left = originalBounds.left + delta.dx;
        break;
      case 'right':
        right = originalBounds.right + delta.dx;
        break;
    }

    // Ensure minimum size
    const minSize = 10.0;
    if (right - left < minSize) {
      if (handle.contains('Left')) {
        left = right - minSize;
      } else {
        right = left + minSize;
      }
    }
    if (bottom - top < minSize) {
      if (handle.contains('top')) {
        top = bottom - minSize;
      } else {
        bottom = top + minSize;
      }
    }

    return Rect.fromLTRB(left, top, right, bottom);
  }

  /// Get the number of dots currently on the canvas
  int get dotCount => dots.length;

  /// Get the number of rectangles currently on the canvas
  int get rectangleCount => rectangles.length;

  /// Get the total number of shapes on the canvas
  int get totalShapeCount => dotCount + rectangleCount;

  /// Get the selected rectangle
  Rectangle? get selectedRectangle {
    if (selectedRectangleId == null) return null;
    try {
      if (isUsingUnifiedStorage) {
        return rectanglesFromShapes
            .firstWhere((rect) => rect.id == selectedRectangleId);
      } else {
        return rectangles.firstWhere((rect) => rect.id == selectedRectangleId);
      }
    } on StateError {
      return null;
    }
  }

  /// Check if the canvas is empty
  bool get isEmpty => dots.isEmpty && rectangles.isEmpty;

  /// Check if the canvas has any shapes
  bool get isNotEmpty => dots.isNotEmpty || rectangles.isNotEmpty;

  /// Check if any rectangles are selected
  bool get hasSelectedRectangles => rectangles.any((rect) => rect.isSelected);

  /// Get all selected rectangles
  List<Rectangle> get selectedRectangles =>
      rectangles.where((rect) => rect.isSelected).toList();

  /// Check if any dots are selected
  bool get hasSelectedDots => selectedDot != null;

  /// Check if any shapes are selected
  bool get hasSelectedShapes => hasSelectedDots || hasSelectedRectangles;

  /// Check if there are any selected shapes that can be deleted
  bool get hasSelectedShapesToDelete {
    return selectedDot != null || selectedRectangleId != null;
  }

  // =========================================================================
  // PHASE 1: UNIFIED STORAGE HELPERS (Backward Compatible)
  // =========================================================================

  /// Get all shapes from unified storage, or convert from legacy storage if
  /// empty
  List<Shape> get allShapes {
    if (shapes.isNotEmpty) {
      return shapes;
    }
    return _convertLegacyToShapes();
  }

  /// Convert legacy dots and rectangles to unified shapes
  List<Shape> _convertLegacyToShapes() {
    final result = <Shape>[];

    // Convert dots to DotShapes
    for (final dot in dots) {
      result.add(DotShape(
        id: const Uuid().v4(),
        position: dot,
      ));
    }

    // Convert rectangles to RectangleShapes
    for (final rect in rectangles) {
      result.add(RectangleShape.fromRectangle(rect));
    }

    return result;
  }

  /// Get dots from unified storage (for backward compatibility)
  List<Offset> get dotsFromShapes {
    if (shapes.isEmpty) {
      return dots; // Use legacy storage
    }
    return shapes.whereType<DotShape>().map((shape) => shape.position).toList();
  }

  /// Get rectangles from unified storage (for backward compatibility)
  List<Rectangle> get rectanglesFromShapes {
    if (shapes.isEmpty) {
      return rectangles; // Use legacy storage
    }
    return shapes
        .whereType<RectangleShape>()
        .map((shape) => shape.toRectangle())
        .toList();
  }

  /// Check if we're using unified storage
  bool get isUsingUnifiedStorage => shapes.isNotEmpty;

  /// Get total count from unified storage
  int get unifiedShapeCount => allShapes.length;

  /// Get dot count from unified storage
  int get unifiedDotCount => allShapes.whereType<DotShape>().length;

  /// Get rectangle count from unified storage
  int get unifiedRectangleCount => allShapes.whereType<RectangleShape>().length;
}
