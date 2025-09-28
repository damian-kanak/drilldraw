import 'package:flutter/material.dart';

/// Abstract base class for all drawable shapes on the canvas
///
/// This class defines the common interface that all shapes must implement,
/// providing a unified way to handle different shape types (dots, rectangles,
/// etc.) through a single abstraction.
abstract class Shape {
  /// Unique identifier for this shape instance
  String get id;

  /// Whether this shape is currently selected
  bool get isSelected;

  /// Bounding rectangle of this shape
  Rect get bounds;

  /// Checks if the given point is within this shape's bounds
  ///
  /// This method is used for hit-testing to determine if a user's
  /// tap/click should interact with this shape.
  bool hitTest(Offset point);

  /// Creates a copy of this shape with the given fields replaced
  ///
  /// This method is essential for immutable state management,
  /// allowing shapes to be updated without mutating the original.
  Shape copyWith({bool? isSelected});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Shape && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Shape{id: $id, isSelected: $isSelected, bounds: $bounds}';
  }
}
