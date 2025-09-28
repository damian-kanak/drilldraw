import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/drawing_state.dart';
import '../../lib/models/rectangle.dart';
import '../../lib/models/shape.dart';
import '../../lib/models/dot_shape.dart';
import '../../lib/models/rectangle_shape.dart';

void main() {
  group('DrawingState Unified Storage Tests', () {
    test('should have empty shapes by default', () {
      const state = DrawingState();
      expect(state.shapes, isEmpty);
      expect(state.isUsingUnifiedStorage, isFalse);
    });

    test('should convert legacy dots to unified shapes', () {
      final state = DrawingState(
        dots: [const Offset(10, 20), const Offset(30, 40)],
      );

      final allShapes = state.allShapes;
      expect(allShapes.length, 2);
      expect(allShapes[0], isA<DotShape>());
      expect(allShapes[1], isA<DotShape>());
      expect((allShapes[0] as DotShape).position, const Offset(10, 20));
      expect((allShapes[1] as DotShape).position, const Offset(30, 40));
    });

    test('should convert legacy rectangles to unified shapes', () {
      final rect1 = Rectangle(
        id: 'rect-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        createdAt: DateTime(2023, 1, 1),
      );
      final rect2 = Rectangle(
        id: 'rect-2',
        bounds: const Rect.fromLTWH(50, 60, 80, 40),
        createdAt: DateTime(2023, 1, 2),
      );

      final state = DrawingState(rectangles: [rect1, rect2]);

      final allShapes = state.allShapes;
      expect(allShapes.length, 2);
      expect(allShapes[0], isA<RectangleShape>());
      expect(allShapes[1], isA<RectangleShape>());
      expect((allShapes[0] as RectangleShape).id, 'rect-1');
      expect((allShapes[1] as RectangleShape).id, 'rect-2');
    });

    test('should convert mixed legacy data to unified shapes', () {
      final rect = Rectangle(
        id: 'rect-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        createdAt: DateTime(2023, 1, 1),
      );

      final state = DrawingState(
        dots: [const Offset(5, 10)],
        rectangles: [rect],
      );

      final allShapes = state.allShapes;
      expect(allShapes.length, 2);
      expect(allShapes[0], isA<DotShape>());
      expect(allShapes[1], isA<RectangleShape>());
    });

    test('should use unified storage when shapes are provided', () {
      final dotShape = DotShape(
        id: 'dot-1',
        position: const Offset(10, 20),
      );
      final rectShape = RectangleShape(
        id: 'rect-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        createdAt: DateTime(2023, 1, 1),
      );

      final state = DrawingState(shapes: [dotShape, rectShape]);

      expect(state.isUsingUnifiedStorage, isTrue);
      expect(state.allShapes.length, 2);
      expect(state.allShapes[0], dotShape);
      expect(state.allShapes[1], rectShape);
    });

    test('should provide backward compatibility getters', () {
      final dotShape = DotShape(
        id: 'dot-1',
        position: const Offset(10, 20),
      );
      final rectShape = RectangleShape(
        id: 'rect-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        createdAt: DateTime(2023, 1, 1),
      );

      final state = DrawingState(shapes: [dotShape, rectShape]);

      // Test dotsFromShapes
      final dots = state.dotsFromShapes;
      expect(dots.length, 1);
      expect(dots[0], const Offset(10, 20));

      // Test rectanglesFromShapes
      final rectangles = state.rectanglesFromShapes;
      expect(rectangles.length, 1);
      expect(rectangles[0].id, 'rect-1');
    });

    test('should provide unified count getters', () {
      final dotShape = DotShape(
        id: 'dot-1',
        position: const Offset(10, 20),
      );
      final rectShape = RectangleShape(
        id: 'rect-1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        createdAt: DateTime(2023, 1, 1),
      );

      final state = DrawingState(shapes: [dotShape, rectShape]);

      expect(state.unifiedShapeCount, 2);
      expect(state.unifiedDotCount, 1);
      expect(state.unifiedRectangleCount, 1);
    });

    test('should work with empty unified storage', () {
      const state = DrawingState();

      expect(state.unifiedShapeCount, 0);
      expect(state.unifiedDotCount, 0);
      expect(state.unifiedRectangleCount, 0);
      expect(state.dotsFromShapes, isEmpty);
      expect(state.rectanglesFromShapes, isEmpty);
    });
  });
}
