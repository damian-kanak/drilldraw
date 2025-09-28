import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/rectangle.dart';
import '../../lib/models/rectangle_shape.dart';
import '../../lib/models/shape.dart';

void main() {
  group('RectangleShape Tests', () {
    late RectangleShape rectangleShape;

    setUp(() {
      rectangleShape = RectangleShape(
        id: 'rect-shape-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: false,
        createdAt: DateTime(2023, 1, 1),
      );
    });

    test('should have correct properties', () {
      expect(rectangleShape.id, 'rect-shape-1');
      expect(rectangleShape.bounds, const Rect.fromLTWH(10, 20, 100, 50));
      expect(rectangleShape.isSelected, false);
      expect(rectangleShape.createdAt, DateTime(2023, 1, 1));
    });

    test('should implement Shape interface', () {
      expect(rectangleShape, isA<Shape>());
    });

    test('should implement hitTest correctly', () {
      // Point inside bounds
      expect(rectangleShape.hitTest(const Offset(50, 40)), isTrue);
      expect(rectangleShape.hitTest(const Offset(15, 25)), isTrue);
      expect(rectangleShape.hitTest(const Offset(109, 69)), isTrue);

      // Point outside bounds
      expect(rectangleShape.hitTest(const Offset(5, 15)), isFalse);
      expect(rectangleShape.hitTest(const Offset(115, 75)), isFalse);
      expect(rectangleShape.hitTest(const Offset(50, 10)), isFalse);

      // Point on boundary (inclusive)
      expect(rectangleShape.hitTest(const Offset(10, 20)), isTrue);
      expect(rectangleShape.hitTest(const Offset(110, 70)),
          isFalse); // Just outside
    });

    test('should implement Shape copyWith correctly', () {
      final updatedShape = rectangleShape.copyWith(isSelected: true);

      expect(updatedShape, isA<Shape>());
      expect(updatedShape.id, rectangleShape.id);
      expect(updatedShape.bounds, rectangleShape.bounds);
      expect(updatedShape.isSelected, true);

      // Original unchanged
      expect(rectangleShape.isSelected, false);
    });

    test('should implement copyWithFull correctly', () {
      final updatedShape = rectangleShape.copyWithFull(
        bounds: const Rect.fromLTWH(0, 0, 200, 100),
        isSelected: true,
      );

      expect(updatedShape.id, rectangleShape.id);
      expect(updatedShape.bounds, const Rect.fromLTWH(0, 0, 200, 100));
      expect(updatedShape.isSelected, true);
      expect(updatedShape.createdAt, rectangleShape.createdAt);
    });

    test('should calculate area correctly', () {
      expect(rectangleShape.area, 5000.0); // 100 * 50
    });

    test('should check intersection correctly', () {
      final otherShape = RectangleShape(
        id: 'rect-shape-2',
        bounds: const Rect.fromLTWH(50, 40, 80, 60),
        isSelected: false,
        createdAt: DateTime(2023, 1, 2),
      );

      final nonIntersectingShape = RectangleShape(
        id: 'rect-shape-3',
        bounds: const Rect.fromLTWH(200, 200, 50, 50),
        isSelected: false,
        createdAt: DateTime(2023, 1, 3),
      );

      expect(rectangleShape.intersects(otherShape), isTrue);
      expect(rectangleShape.intersects(nonIntersectingShape), isFalse);
    });

    test('should work with Shape collections', () {
      final shapes = <Shape>[
        RectangleShape(
          id: 'rect-1',
          bounds: const Rect.fromLTWH(10, 20, 100, 50),
          isSelected: false,
          createdAt: DateTime(2023, 1, 1),
        ),
        RectangleShape(
          id: 'rect-2',
          bounds: const Rect.fromLTWH(50, 50, 80, 60),
          isSelected: true,
          createdAt: DateTime(2023, 1, 2),
        ),
      ];

      expect(shapes.length, 2);
      expect(shapes[0].id, 'rect-1');
      expect(shapes[1].id, 'rect-2');
      expect(shapes[0].isSelected, false);
      expect(shapes[1].isSelected, true);
    });

    test('should implement equality correctly', () {
      final sameShape = RectangleShape(
        id: 'rect-shape-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: false,
        createdAt: DateTime(2023, 1, 1),
      );

      final differentShape = RectangleShape(
        id: 'rect-shape-2',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: false,
        createdAt: DateTime(2023, 1, 1),
      );

      expect(rectangleShape, equals(sameShape));
      expect(rectangleShape, isNot(equals(differentShape)));
    });

    test('should implement toString correctly', () {
      final shapeString = rectangleShape.toString();
      expect(shapeString, contains('rect-shape-1'));
      expect(shapeString, contains('false'));
      expect(shapeString, contains('Rect.fromLTRB'));
    });

    test('should be immutable', () {
      final originalId = rectangleShape.id;
      final originalBounds = rectangleShape.bounds;
      final originalIsSelected = rectangleShape.isSelected;

      final updatedShape = rectangleShape.copyWith(isSelected: true);

      // Original unchanged
      expect(rectangleShape.id, originalId);
      expect(rectangleShape.bounds, originalBounds);
      expect(rectangleShape.isSelected, originalIsSelected);

      // Updated shape has new selection state
      expect(updatedShape.id, originalId);
      expect(updatedShape.bounds, originalBounds);
      expect(updatedShape.isSelected, true);
    });
  });

  group('RectangleShape Factory Methods', () {
    test('should create RectangleShape with unique ID', () {
      final shape1 = RectangleShape.create(
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: false,
      );

      final shape2 = RectangleShape.create(
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: false,
      );

      expect(shape1.id, isNot(equals(shape2.id)));
      expect(shape1.bounds, shape2.bounds);
      expect(shape1.isSelected, shape2.isSelected);
    });

    test('should create RectangleShape from Rectangle', () {
      final rectangle = Rectangle(
        id: 'rect-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: true,
        createdAt: DateTime(2023, 1, 1),
      );

      final shape = RectangleShape.fromRectangle(rectangle);

      expect(shape.id, rectangle.id);
      expect(shape.bounds, rectangle.bounds);
      expect(shape.isSelected, rectangle.isSelected);
      expect(shape.createdAt, rectangle.createdAt);
    });

    test('should convert to Rectangle for backward compatibility', () {
      final shape = RectangleShape(
        id: 'rect-shape-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: true,
        createdAt: DateTime(2023, 1, 1),
      );

      final rectangle = shape.toRectangle();

      expect(rectangle.id, shape.id);
      expect(rectangle.bounds, shape.bounds);
      expect(rectangle.isSelected, shape.isSelected);
      expect(rectangle.createdAt, shape.createdAt);
    });
  });

  group('RectangleShape Edge Cases', () {
    test('should handle zero-sized bounds', () {
      final zeroShape = RectangleShape(
        id: 'zero-shape',
        bounds: const Rect.fromLTWH(10, 20, 0, 0),
        isSelected: false,
        createdAt: DateTime(2023, 1, 1),
      );

      expect(zeroShape.hitTest(const Offset(10, 20)), isFalse);
      expect(zeroShape.hitTest(const Offset(10.1, 20)), isFalse);
      expect(zeroShape.area, 0.0);
    });

    test('should handle negative bounds', () {
      final negativeShape = RectangleShape(
        id: 'negative-shape',
        bounds: const Rect.fromLTWH(-10, -20, 30, 40),
        isSelected: false,
        createdAt: DateTime(2023, 1, 1),
      );

      expect(negativeShape.hitTest(const Offset(0, 0)), isTrue);
      expect(negativeShape.hitTest(const Offset(-10, -20)), isTrue);
      expect(negativeShape.hitTest(const Offset(19, 19)), isTrue);
      expect(negativeShape.hitTest(const Offset(20, 20)), isFalse);
    });

    test('should handle large bounds', () {
      final largeShape = RectangleShape(
        id: 'large-shape',
        bounds: const Rect.fromLTWH(0, 0, 10000, 10000),
        isSelected: false,
        createdAt: DateTime(2023, 1, 1),
      );

      expect(largeShape.hitTest(const Offset(5000, 5000)), isTrue);
      expect(largeShape.hitTest(const Offset(0, 0)), isTrue);
      expect(largeShape.hitTest(const Offset(9999, 9999)), isTrue);
      expect(largeShape.hitTest(const Offset(10000, 10000)), isFalse);
      expect(largeShape.area, 100000000.0);
    });
  });

  group('RectangleShape Shape Interface Compliance', () {
    test('should implement all Shape interface methods', () {
      final shape = RectangleShape(
        id: 'test-shape',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: false,
        createdAt: DateTime(2023, 1, 1),
      );

      // Test that it implements Shape interface
      expect(shape, isA<Shape>());

      // Test interface properties
      expect(shape.id, 'test-shape');
      expect(shape.isSelected, false);
      expect(shape.bounds, const Rect.fromLTWH(10, 20, 100, 50));

      // Test interface methods
      expect(shape.hitTest(const Offset(50, 40)), isTrue);
      expect(shape.copyWith(isSelected: true), isA<Shape>());
    });

    test('should work with Shape collections', () {
      final shapes = <Shape>[
        RectangleShape(
          id: 'rect-1',
          bounds: const Rect.fromLTWH(10, 20, 100, 50),
          isSelected: false,
          createdAt: DateTime(2023, 1, 1),
        ),
        RectangleShape(
          id: 'rect-2',
          bounds: const Rect.fromLTWH(50, 50, 80, 60),
          isSelected: true,
          createdAt: DateTime(2023, 1, 2),
        ),
      ];

      expect(shapes.length, 2);
      expect(shapes[0].id, 'rect-1');
      expect(shapes[1].id, 'rect-2');
      expect(shapes[0].isSelected, false);
      expect(shapes[1].isSelected, true);
    });
  });
}
