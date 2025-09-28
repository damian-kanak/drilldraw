import 'package:flutter/material.dart';

import 'shape.dart';

/// A concrete implementation of Shape for dots
///
/// DotShape represents a point on the canvas with a position and selection
/// state.
/// It provides hit-testing based on distance from the center point.
class DotShape extends Shape {
  @override
  final String id;

  @override
  final bool isSelected;

  /// The position of the dot on the canvas
  final Offset position;

  /// The radius for hit-testing (default: 10px)
  final double hitTestRadius;

  DotShape({
    required this.id,
    required this.position,
    this.isSelected = false,
    this.hitTestRadius = 10.0,
  });

  @override
  Rect get bounds {
    return Rect.fromCircle(
      center: position,
      radius: hitTestRadius,
    );
  }

  @override
  bool hitTest(Offset point) {
    final distance = (point - position).distance;
    return distance <= hitTestRadius;
  }

  @override
  DotShape copyWith({
    bool? isSelected,
    Offset? position,
    double? hitTestRadius,
  }) {
    return DotShape(
      id: id,
      position: position ?? this.position,
      isSelected: isSelected ?? this.isSelected,
      hitTestRadius: hitTestRadius ?? this.hitTestRadius,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DotShape &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          position == other.position &&
          isSelected == other.isSelected &&
          hitTestRadius == other.hitTestRadius;

  @override
  int get hashCode => Object.hash(
        id,
        position,
        isSelected,
        hitTestRadius,
      );

  @override
  String toString() {
    return 'DotShape{id: $id, position: $position, isSelected: $isSelected, '
        'hitTestRadius: $hitTestRadius}';
  }
}
