import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_state.dart';
import 'package:drilldraw/models/rectangle.dart';
import 'package:drilldraw/painters/combined_painter.dart';

void main() {
  group('CombinedPainter Tests', () {
    test('CombinedPainter constructor is const', () {
      const state = DrawingState();
      const combinedPainter = CombinedPainter(state);
      expect(combinedPainter.drawingState, equals(state));
    });

    test('CombinedPainter shouldRepaint returns true when dots change', () {
      const state1 = DrawingState(dots: []);
      const state2 = DrawingState(dots: [Offset(10, 10)]);

      const painter1 = CombinedPainter(state1);
      const painter2 = CombinedPainter(state2);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('CombinedPainter shouldRepaint returns true when rectangles change',
        () {
      const state1 = DrawingState(rectangles: []);
      final state2 = DrawingState(
        rectangles: [
          Rectangle(
            id: 'test',
            bounds: Rect.fromLTWH(0, 0, 100, 100),
            createdAt: DateTime(2025, 1, 1),
          ),
        ],
      );

      const painter1 = CombinedPainter(state1);
      final painter2 = CombinedPainter(state2);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('CombinedPainter shouldRepaint returns true when selection changes',
        () {
      const state1 = DrawingState(selectedDot: null);
      const state2 = DrawingState(selectedDot: Offset(10, 10));

      const painter1 = CombinedPainter(state1);
      const painter2 = CombinedPainter(state2);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test(
        'CombinedPainter shouldRepaint returns true when drawing state changes',
        () {
      const state1 = DrawingState(isDrawing: false);
      const state2 = DrawingState(isDrawing: true);

      const painter1 = CombinedPainter(state1);
      const painter2 = CombinedPainter(state2);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('CombinedPainter shouldRepaint returns false when state is identical',
        () {
      final state = DrawingState(
        dots: [Offset(10, 10)],
        rectangles: [
          Rectangle(
            id: 'test',
            bounds: Rect.fromLTWH(0, 0, 100, 100),
            createdAt: DateTime(2025, 1, 1),
          ),
        ],
      );

      final painter1 = CombinedPainter(state);
      final painter2 = CombinedPainter(state);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    test('getRectangleAt delegates to RectanglePainter', () {
      final rect = Rectangle(
        id: 'test',
        bounds: Rect.fromLTWH(0, 0, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final state = DrawingState(rectangles: [rect]);
      final combinedPainter = CombinedPainter(state);

      // Point inside rectangle
      final result1 = combinedPainter.getRectangleAt(const Offset(50, 50));
      expect(result1?.id, equals('test'));

      // Point outside rectangle
      final result2 = combinedPainter.getRectangleAt(const Offset(200, 200));
      expect(result2, isNull);
    });

    test('getRectanglesInArea delegates to RectanglePainter', () {
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
      final combinedPainter = CombinedPainter(state);

      final intersectingArea = const Rect.fromLTWH(25, 25, 50, 50);
      final result = combinedPainter.getRectanglesInArea(intersectingArea);

      expect(result.length, equals(2));
      expect(result.any((r) => r.id == 'rect1'), isTrue);
      expect(result.any((r) => r.id == 'rect2'), isTrue);
    });
  });
}
