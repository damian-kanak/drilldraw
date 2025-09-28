import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/shape.dart';

/// Test implementation of Shape for testing the abstract interface
class TestShape extends Shape {
  @override
  final String id;

  @override
  final bool isSelected;

  @override
  final Rect bounds;

  TestShape({
    required this.id,
    required this.bounds,
    this.isSelected = false,
  });

  @override
  bool hitTest(Offset point) {
    return bounds.contains(point);
  }

  @override
  TestShape copyWith({bool? isSelected}) {
    return TestShape(
      id: id,
      bounds: bounds,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

void main() {
  group('Shape Interface Tests', () {
    late TestShape shape;

    setUp(() {
      shape = TestShape(
        id: 'test-shape-1',
        bounds: const Rect.fromLTWH(10, 20, 30, 40),
        isSelected: false,
      );
    });

    test('should have correct properties', () {
      expect(shape.id, 'test-shape-1');
      expect(shape.isSelected, false);
      expect(shape.bounds, const Rect.fromLTWH(10, 20, 30, 40));
    });

    test('should implement hitTest correctly', () {
      // Point inside bounds (bounds: 10,20 to 40,60)
      expect(shape.hitTest(const Offset(25, 40)), isTrue);

      // Point outside bounds
      expect(shape.hitTest(const Offset(5, 10)), isFalse);
      expect(shape.hitTest(const Offset(50, 70)), isFalse);

      // Point on boundary (inclusive) - Rect.fromLTWH(10, 20, 30, 40) = (10,20) to (40,60)
      expect(shape.hitTest(const Offset(10, 20)), isTrue);
      expect(shape.hitTest(const Offset(39.9, 59.9)), isTrue); // Just inside
      expect(shape.hitTest(const Offset(40, 60)),
          isFalse); // Just outside (exclusive)
    });

    test('should implement copyWith correctly', () {
      final updatedShape = shape.copyWith(isSelected: true);

      expect(updatedShape.id, shape.id);
      expect(updatedShape.bounds, shape.bounds);
      expect(updatedShape.isSelected, true);
      expect(shape.isSelected, false); // Original unchanged
    });

    test('should implement equality correctly', () {
      final sameShape = TestShape(
        id: 'test-shape-1',
        bounds: const Rect.fromLTWH(10, 20, 30, 40),
        isSelected: false,
      );

      final differentShape = TestShape(
        id: 'test-shape-2',
        bounds: const Rect.fromLTWH(10, 20, 30, 40),
        isSelected: false,
      );

      expect(shape, equals(sameShape));
      expect(shape, isNot(equals(differentShape)));
    });

    test('should implement hashCode correctly', () {
      final sameShape = TestShape(
        id: 'test-shape-1',
        bounds: const Rect.fromLTWH(10, 20, 30, 40),
        isSelected: false,
      );

      final differentShape = TestShape(
        id: 'test-shape-2',
        bounds: const Rect.fromLTWH(10, 20, 30, 40),
        isSelected: false,
      );

      expect(shape.hashCode, equals(sameShape.hashCode));
      expect(shape.hashCode, isNot(equals(differentShape.hashCode)));
    });

    test('should implement toString correctly', () {
      final expectedString =
          'Shape{id: test-shape-1, isSelected: false, bounds: Rect.fromLTRB(10.0, 20.0, 40.0, 60.0)}';
      expect(shape.toString(), expectedString);
    });

    test('should be immutable', () {
      final originalId = shape.id;
      final originalBounds = shape.bounds;
      final originalIsSelected = shape.isSelected;

      // Attempting to modify should not affect original
      final updatedShape = shape.copyWith(isSelected: true);

      expect(shape.id, originalId);
      expect(shape.bounds, originalBounds);
      expect(shape.isSelected, originalIsSelected);

      expect(updatedShape.id, originalId);
      expect(updatedShape.bounds, originalBounds);
      expect(updatedShape.isSelected, true);
    });
  });

  group('Shape Interface Edge Cases', () {
    test('should handle zero-sized bounds', () {
      final zeroShape = TestShape(
        id: 'zero-shape',
        bounds: const Rect.fromLTWH(10, 20, 0, 0),
        isSelected: false,
      );

      // Zero-sized rect contains no points (width=0, height=0)
      expect(zeroShape.hitTest(const Offset(10, 20)), isFalse);

      // Point slightly offset
      expect(zeroShape.hitTest(const Offset(10.1, 20)), isFalse);
      expect(zeroShape.hitTest(const Offset(10, 20.1)), isFalse);
    });

    test('should handle negative bounds', () {
      final negativeShape = TestShape(
        id: 'negative-shape',
        bounds: const Rect.fromLTWH(-10, -20, 30, 40),
        isSelected: false,
      );

      // Bounds: (-10, -20) to (20, 20) - width=30, height=40
      expect(negativeShape.hitTest(const Offset(0, 0)), isTrue);
      expect(negativeShape.hitTest(const Offset(-10, -20)), isTrue);
      expect(negativeShape.hitTest(const Offset(19.9, 19.9)),
          isTrue); // Just inside
      expect(
          negativeShape.hitTest(const Offset(20, 20)), isFalse); // Just outside
      expect(negativeShape.hitTest(const Offset(-15, -25)), isFalse);
    });
  });
}
