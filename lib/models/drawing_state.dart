import 'package:flutter/material.dart';

import 'drawing_mode.dart';
import 'rectangle.dart';

/// Represents the current state of the drawing canvas
class DrawingState {
  final List<Offset> dots;
  final List<Rectangle> rectangles;
  final Offset? selectedDot;
  final String? selectedRectangleId;
  final DrawingMode drawingMode;
  final bool isDrawing;
  final Rect? dragPreview;

  const DrawingState({
    this.dots = const [],
    this.rectangles = const [],
    this.selectedDot,
    this.selectedRectangleId,
    this.drawingMode = DrawingMode.dot,
    this.isDrawing = false,
    this.dragPreview,
  });

  /// Create a copy of this state with updated values
  DrawingState copyWith({
    List<Offset>? dots,
    List<Rectangle>? rectangles,
    Offset? selectedDot,
    String? selectedRectangleId,
    DrawingMode? drawingMode,
    bool? isDrawing,
    Rect? dragPreview,
    bool clearSelectedDot = false,
    bool clearSelectedRectangleId = false,
    bool clearDragPreview = false,
  }) {
    return DrawingState(
      dots: dots ?? this.dots,
      rectangles: rectangles ?? this.rectangles,
      selectedDot: clearSelectedDot ? null : (selectedDot ?? this.selectedDot),
      selectedRectangleId: clearSelectedRectangleId
          ? null
          : (selectedRectangleId ?? this.selectedRectangleId),
      drawingMode: drawingMode ?? this.drawingMode,
      isDrawing: isDrawing ?? this.isDrawing,
      dragPreview: clearDragPreview ? null : (dragPreview ?? this.dragPreview),
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
    final newRectangles = rectangles.map((rect) {
      return rect.id == id ? updatedRectangle : rect;
    }).toList();
    return copyWith(rectangles: newRectangles);
  }

  /// Remove a rectangle by ID
  DrawingState removeRectangle(String id) {
    final newRectangles = rectangles.where((rect) => rect.id != id).toList();
    return copyWith(rectangles: newRectangles);
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
      return rectangles.firstWhere((rect) => rect.id == selectedRectangleId);
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
}
