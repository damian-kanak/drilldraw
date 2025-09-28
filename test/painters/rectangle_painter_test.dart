import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_state.dart';
import 'package:drilldraw/models/rectangle.dart';
import 'package:drilldraw/models/rectangle_shape.dart';
import 'package:drilldraw/painters/rectangle_painter.dart';

void main() {
  group('RectanglePainter Tests', () {
    test('RectanglePainter constructor is const', () {
      const state = DrawingState();
      const rectanglePainter = RectanglePainter(state);
      expect(rectanglePainter.drawingState, equals(state));
    });

    test('RectanglePainter shouldRepaint returns true when rectangles change',
        () {
      const state1 = DrawingState();
      final state2 = DrawingState(
        rectangles: [
          Rectangle(
            id: 'test',
            bounds: Rect.fromLTWH(0, 0, 100, 100),
            createdAt: DateTime(2025, 1, 1),
          ),
        ],
      );

      const painter1 = RectanglePainter(state1);
      final painter2 = RectanglePainter(state2);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('RectanglePainter shouldRepaint returns false when state is identical',
        () {
      final state = DrawingState(
        rectangles: [
          Rectangle(
            id: 'test',
            bounds: Rect.fromLTWH(0, 0, 100, 100),
            createdAt: DateTime(2025, 1, 1),
          ),
        ],
      );

      final painter1 = RectanglePainter(state);
      final painter2 = RectanglePainter(state);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    test('RectanglePainter shouldRepaint returns true when selection changes',
        () {
      final state1 = DrawingState(
        rectangles: [
          Rectangle(
            id: 'test',
            bounds: Rect.fromLTWH(0, 0, 100, 100),
            createdAt: DateTime(2025, 1, 1),
          ),
        ],
        selectedRectangleId: null,
      );

      final state2 = DrawingState(
        rectangles: [
          Rectangle(
            id: 'test',
            bounds: Rect.fromLTWH(0, 0, 100, 100),
            createdAt: DateTime(2025, 1, 1),
          ),
        ],
        selectedRectangleId: 'test',
      );

      final painter1 = RectanglePainter(state1);
      final painter2 = RectanglePainter(state2);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test(
        'RectanglePainter shouldRepaint returns true when drag preview changes',
        () {
      const state1 = DrawingState(
        isDrawing: false,
        dragPreview: null,
      );

      const state2 = DrawingState(
        isDrawing: true,
        dragPreview: Rect.fromLTWH(0, 0, 50, 50),
      );

      const painter1 = RectanglePainter(state1);
      const painter2 = RectanglePainter(state2);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('getRectangleAt returns correct rectangle for point', () {
      final rect1 = Rectangle(
        id: 'rect1',
        bounds: Rect.fromLTWH(0, 0, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final rect2 = Rectangle(
        id: 'rect2',
        bounds: Rect.fromLTWH(50, 50, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final state = DrawingState(rectangles: [rect1, rect2]);
      final rectanglePainter = RectanglePainter(state);

      // Point in first rectangle only
      final result1 = rectanglePainter.getRectangleAt(const Offset(25, 25));
      expect(result1?.id, equals('rect1'));

      // Point in second rectangle (should return top-most)
      final result2 = rectanglePainter.getRectangleAt(const Offset(75, 75));
      expect(result2?.id, equals('rect2'));

      // Point outside both rectangles
      final result3 = rectanglePainter.getRectangleAt(const Offset(200, 200));
      expect(result3, isNull);
    });

    test('getRectanglesInArea returns rectangles that intersect with area', () {
      final rect1 = Rectangle(
        id: 'rect1',
        bounds: Rect.fromLTWH(0, 0, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final rect2 = Rectangle(
        id: 'rect2',
        bounds: Rect.fromLTWH(50, 50, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final rect3 = Rectangle(
        id: 'rect3',
        bounds: Rect.fromLTWH(200, 200, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final state = DrawingState(rectangles: [rect1, rect2, rect3]);
      final rectanglePainter = RectanglePainter(state);

      // Area that intersects with first two rectangles
      final intersectingArea = const Rect.fromLTWH(25, 25, 50, 50);
      final result = rectanglePainter.getRectanglesInArea(intersectingArea);

      expect(result.length, equals(2));
      expect(result.any((r) => r.id == 'rect1'), isTrue);
      expect(result.any((r) => r.id == 'rect2'), isTrue);
      expect(result.any((r) => r.id == 'rect3'), isFalse);
    });
  });
}
