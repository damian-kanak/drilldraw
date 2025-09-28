import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'rectangle.dart';
import 'shape.dart';

/// A concrete implementation of Shape for rectangles
///
/// RectangleShape represents a rectangle on the canvas with bounds, selection
/// state, and creation timestamp. It provides hit-testing based on bounds
/// containment and implements the Shape interface for unified handling.
class RectangleShape implements Shape {
  @override
  final String id;

  @override
  final bool isSelected;

  /// The bounds of the rectangle on the canvas
  @override
  final Rect bounds;

  /// The creation timestamp of the rectangle
  final DateTime createdAt;

  RectangleShape({
    required this.id,
    required this.bounds,
    this.isSelected = false,
    required this.createdAt,
  });

  /// Factory constructor to create a new RectangleShape with a unique ID
  factory RectangleShape.create({
    required Rect bounds,
    bool isSelected = false,
    DateTime? createdAt,
  }) {
    return RectangleShape(
      id: const Uuid().v4(),
      bounds: bounds,
      isSelected: isSelected,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  /// Factory constructor to create RectangleShape from existing Rectangle
  factory RectangleShape.fromRectangle(Rectangle rectangle) {
    return RectangleShape(
      id: rectangle.id,
      bounds: rectangle.bounds,
      isSelected: rectangle.isSelected,
      createdAt: rectangle.createdAt,
    );
  }

  @override
  bool hitTest(Offset point) {
    return bounds.contains(point);
  }

  @override
  RectangleShape copyWith({bool? isSelected}) {
    return RectangleShape(
      id: id,
      bounds: bounds,
      isSelected: isSelected ?? this.isSelected,
      createdAt: createdAt,
    );
  }

  /// Creates a copy of this RectangleShape with the given fields replaced
  RectangleShape copyWithFull({
    String? id,
    Rect? bounds,
    bool? isSelected,
    DateTime? createdAt,
  }) {
    return RectangleShape(
      id: id ?? this.id,
      bounds: bounds ?? this.bounds,
      isSelected: isSelected ?? this.isSelected,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Calculates the area of the rectangle
  double get area => bounds.width * bounds.height;

  /// Checks if this rectangle intersects with another rectangle
  bool intersects(RectangleShape other) {
    return bounds.overlaps(other.bounds);
  }

  /// Converts this RectangleShape to a Rectangle for backward compatibility
  Rectangle toRectangle() {
    return Rectangle(
      id: id,
      bounds: bounds,
      isSelected: isSelected,
      createdAt: createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RectangleShape &&
        other.id == id &&
        other.bounds == bounds &&
        other.isSelected == isSelected &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(id, bounds, isSelected, createdAt);

  @override
  String toString() {
    return 'RectangleShape{id: $id, bounds: $bounds, isSelected: $isSelected, '
        'createdAt: $createdAt}';
  }
}
