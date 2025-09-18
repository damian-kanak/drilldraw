import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_state.dart';
import 'package:drilldraw/painters/dot_painter.dart';

void main() {
  group('DotPainter Tests', () {
    test('DotPainter constructor is const', () {
      const drawingState = DrawingState();
      const painter = DotPainter(drawingState);
      expect(painter, isA<DotPainter>());
    });

    test('DotPainter shouldRepaint returns true when dots change', () {
      const drawingState1 = DrawingState(dots: [Offset(10, 10)]);
      const drawingState2 = DrawingState(dots: [Offset(20, 20)]);
      const painter1 = DotPainter(drawingState1);
      const painter2 = DotPainter(drawingState2);

      expect(painter1.shouldRepaint(painter2), true);
    });

    test('DotPainter shouldRepaint returns true when selection changes', () {
      const drawingState1 = DrawingState(
        dots: [Offset(10, 10)],
        selectedDot: Offset(10, 10),
      );
      const drawingState2 = DrawingState(
        dots: [Offset(10, 10)],
        selectedDot: null,
      );
      const painter1 = DotPainter(drawingState1);
      const painter2 = DotPainter(drawingState2);

      expect(painter1.shouldRepaint(painter2), true);
    });

    test('DotPainter shouldRepaint returns false when state is identical', () {
      const drawingState = DrawingState(dots: [Offset(10, 10)]);
      const painter1 = DotPainter(drawingState);
      const painter2 = DotPainter(drawingState);

      expect(painter1.shouldRepaint(painter2), false);
    });

    test('getDotAt returns correct dot for point', () {
      const drawingState = DrawingState(dots: [
        Offset(10, 10),
        Offset(50, 50),
      ]);
      const painter = DotPainter(drawingState);

      // Test clicking on first dot
      final dot1 = painter.getDotAt(const Offset(10, 10));
      expect(dot1, const Offset(10, 10));

      // Test clicking on second dot
      final dot2 = painter.getDotAt(const Offset(50, 50));
      expect(dot2, const Offset(50, 50));

      // Test clicking between dots
      final noDot = painter.getDotAt(const Offset(30, 30));
      expect(noDot, isNull);
    });

    test('getDotAt returns top-most dot when overlapping', () {
      // Create dots at same position (overlapping)
      const drawingState = DrawingState(dots: [
        Offset(10, 10), // First dot (bottom)
        Offset(10, 10), // Second dot (top)
      ]);
      const painter = DotPainter(drawingState);

      // Should return the last dot (top-most)
      final dot = painter.getDotAt(const Offset(10, 10));
      expect(dot, const Offset(10, 10));
    });

    test('getDotAt returns null for empty canvas', () {
      const drawingState = DrawingState(dots: []);
      const painter = DotPainter(drawingState);

      final dot = painter.getDotAt(const Offset(10, 10));
      expect(dot, isNull);
    });

    test('getDotsInArea returns dots within area', () {
      const drawingState = DrawingState(dots: [
        Offset(10, 10), // Inside area
        Offset(50, 50), // Inside area
        Offset(100, 100), // Outside area
      ]);
      const painter = DotPainter(drawingState);

      // Area that should contain first two dots
      final area = const Rect.fromLTWH(0, 0, 60, 60);
      final dotsInArea = painter.getDotsInArea(area);

      expect(dotsInArea.length, 2);
      expect(dotsInArea, contains(const Offset(10, 10)));
      expect(dotsInArea, contains(const Offset(50, 50)));
      expect(dotsInArea, isNot(contains(const Offset(100, 100))));
    });

    test('getDotsInArea returns empty list for empty canvas', () {
      const drawingState = DrawingState(dots: []);
      const painter = DotPainter(drawingState);

      final area = const Rect.fromLTWH(0, 0, 100, 100);
      final dotsInArea = painter.getDotsInArea(area);

      expect(dotsInArea, isEmpty);
    });

    test('getDotsInArea returns empty list when no dots in area', () {
      const drawingState = DrawingState(dots: [
        Offset(100, 100),
        Offset(200, 200),
      ]);
      const painter = DotPainter(drawingState);

      final area = const Rect.fromLTWH(0, 0, 50, 50);
      final dotsInArea = painter.getDotsInArea(area);

      expect(dotsInArea, isEmpty);
    });
  });
}
