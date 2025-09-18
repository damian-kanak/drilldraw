import 'package:flutter/material.dart';

/// Represents a drawable rectangle on the canvas
@immutable
class Rectangle {
  final String id;
  final Rect bounds;
  final bool isSelected;
  final DateTime createdAt;

  const Rectangle({
    required this.id,
    required this.bounds,
    this.isSelected = false,
    required this.createdAt,
  });

  /// Creates a copy of this Rectangle with the given fields replaced with the
  /// new values
  Rectangle copyWith({
    String? id,
    Rect? bounds,
    bool? isSelected,
    DateTime? createdAt,
  }) {
    return Rectangle(
      id: id ?? this.id,
      bounds: bounds ?? this.bounds,
      isSelected: isSelected ?? this.isSelected,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Checks if a given point is contained within the rectangle's bounds
  bool containsPoint(Offset point) {
    return bounds.contains(point);
  }

  /// Calculates the area of the rectangle
  double get area => bounds.width * bounds.height;

  /// Checks if this rectangle intersects with another rectangle
  bool intersects(Rectangle other) {
    return bounds.overlaps(other.bounds);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Rectangle &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          bounds == other.bounds &&
          isSelected == other.isSelected &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, bounds, isSelected, createdAt);

  @override
  String toString() {
    return 'Rectangle(id: $id, bounds: $bounds, selected: $isSelected, '
        'createdAt: $createdAt)';
  }
}
