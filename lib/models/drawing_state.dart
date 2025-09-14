import 'package:flutter/material.dart';

/// Represents the current state of the drawing canvas
class DrawingState {
  final List<Offset> dots;
  final Offset? selectedDot;
  final bool isDrawing;

  const DrawingState({
    this.dots = const [],
    this.selectedDot,
    this.isDrawing = false,
  });

  /// Create a copy of this state with updated values
  DrawingState copyWith({
    List<Offset>? dots,
    Offset? selectedDot,
    bool? isDrawing,
  }) {
    return DrawingState(
      dots: dots ?? this.dots,
      selectedDot: selectedDot ?? this.selectedDot,
      isDrawing: isDrawing ?? this.isDrawing,
    );
  }

  /// Add a new dot to the canvas
  DrawingState addDot(Offset position) {
    final newDots = List<Offset>.from(dots)..add(position);
    return copyWith(dots: newDots);
  }

  /// Clear all dots from the canvas
  DrawingState clearDots() {
    return copyWith(dots: []);
  }

  /// Get the number of dots currently on the canvas
  int get dotCount => dots.length;

  /// Check if the canvas is empty
  bool get isEmpty => dots.isEmpty;

  /// Check if the canvas has dots
  bool get isNotEmpty => dots.isNotEmpty;
}
