import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_mode.dart';
import 'package:drilldraw/models/drawing_state.dart';
import 'package:drilldraw/models/rectangle.dart';

void main() {
  group('DrawingState Tests', () {
    late DrawingState initialState;
    late Rectangle testRectangle;

    setUp(() {
      initialState = const DrawingState();
      testRectangle = Rectangle(
        id: 'test_rect_1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        createdAt: DateTime(2023, 1, 1),
      );
    });

    test('Initial DrawingState is empty and in dot mode', () {
      expect(initialState.dots, isEmpty);
      expect(initialState.rectangles, isEmpty);
      expect(initialState.selectedDot, isNull);
      expect(initialState.selectedRectangleId, isNull);
      expect(initialState.drawingMode, DrawingMode.dot);
      expect(initialState.isDrawing, false);
      expect(initialState.isEmpty, true);
      expect(initialState.isNotEmpty, false);
      expect(initialState.dotCount, 0);
      expect(initialState.rectangleCount, 0);
      expect(initialState.totalShapeCount, 0);
    });

    test('DrawingState copyWith works correctly', () {
      final newState = initialState.copyWith(
        dots: [const Offset(1, 1)],
        drawingMode: DrawingMode.rectangle,
        isDrawing: true,
      );

      expect(newState.dots, [const Offset(1, 1)]);
      expect(newState.drawingMode, DrawingMode.rectangle);
      expect(newState.isDrawing, true);
      expect(newState.rectangles, isEmpty); // Unchanged
    });

    test('DrawingState addDot works correctly', () {
      final stateWithDot = initialState.addDot(const Offset(10, 10));
      expect(stateWithDot.dots, contains(const Offset(10, 10)));
      expect(stateWithDot.dotCount, 1);
      expect(stateWithDot.isNotEmpty, true);
    });

    test('DrawingState addRectangle works correctly', () {
      final stateWithRect = initialState.addRectangle(testRectangle);
      expect(stateWithRect.rectangles, contains(testRectangle));
      expect(stateWithRect.rectangleCount, 1);
      expect(stateWithRect.isNotEmpty, true);
    });

    test('DrawingState removeRectangle works correctly', () {
      final stateWithRect = initialState.addRectangle(testRectangle);
      final stateWithoutRect = stateWithRect.removeRectangle(testRectangle.id);
      expect(stateWithoutRect.rectangles, isEmpty);
      expect(stateWithoutRect.rectangleCount, 0);
    });

    test('DrawingState selectRectangle works correctly', () {
      final stateWithRect = initialState.addRectangle(testRectangle);
      final selectedState = stateWithRect.selectRectangle('test_rect_1');

      expect(selectedState.rectangles.first.isSelected, true);
      expect(selectedState.selectedRectangleId, 'test_rect_1');
      expect(selectedState.selectedRectangle,
          testRectangle.copyWith(isSelected: true));
      expect(selectedState.hasSelectedRectangles, true);
    });

    test('DrawingState clearRectangleSelection works correctly', () {
      final stateWithSelectedRect = initialState
          .addRectangle(testRectangle)
          .selectRectangle('test_rect_1');
      final deselectedState = stateWithSelectedRect.clearRectangleSelection();

      expect(deselectedState.selectedRectangleId, null);
      expect(deselectedState.hasSelectedRectangles, false);
      // selectedRectangle should return null when no rectangle is selected
      expect(deselectedState.selectedRectangle, null);
    });

    test('DrawingState updateRectangle works correctly', () {
      final stateWithRect = initialState.addRectangle(testRectangle);
      final updatedRect = testRectangle.copyWith(
        bounds: const Rect.fromLTWH(20, 30, 150, 75),
      );
      final stateWithUpdatedRect =
          stateWithRect.updateRectangle(testRectangle.id, updatedRect);

      expect(stateWithUpdatedRect.rectangles.first.bounds, updatedRect.bounds);
    });

    test('DrawingState clearRectangles works correctly', () {
      final stateWithRect = initialState.addRectangle(testRectangle);
      final clearedState = stateWithRect.clearRectangles();
      expect(clearedState.rectangles, isEmpty);
      expect(clearedState.rectangleCount, 0);
      expect(clearedState.selectedRectangleId, null);
    });

    test('DrawingState clearAll works correctly', () {
      final stateWithShapes = initialState
          .addDot(const Offset(10, 10))
          .addRectangle(testRectangle)
          .selectRectangle(testRectangle.id);
      final clearedState = stateWithShapes.clearAll();

      expect(clearedState.dots, isEmpty);
      expect(clearedState.rectangles, isEmpty);
      expect(clearedState.selectedDot, null);
      expect(clearedState.selectedRectangleId, null);
      expect(clearedState.isEmpty, true);
    });

    test('DrawingState setDrawingMode works correctly', () {
      final stateInRectangleMode =
          initialState.setDrawingMode(DrawingMode.rectangle);
      expect(stateInRectangleMode.drawingMode, DrawingMode.rectangle);
      expect(stateInRectangleMode.selectedDot, null);
      expect(stateInRectangleMode.selectedRectangleId, null);
    });

    test('DrawingState getters for counts and emptiness', () {
      final stateWithDot = initialState.addDot(const Offset(1, 1));
      final stateWithRect = stateWithDot.addRectangle(testRectangle);

      expect(stateWithRect.dotCount, 1);
      expect(stateWithRect.rectangleCount, 1);
      expect(stateWithRect.totalShapeCount, 2);
      expect(stateWithRect.isEmpty, false);
      expect(stateWithRect.isNotEmpty, true);
    });

    test('DrawingState selectedRectangle getter returns correct rectangle', () {
      final stateWithRect = initialState.addRectangle(testRectangle);
      final selectedState = stateWithRect.selectRectangle(testRectangle.id);
      expect(selectedState.selectedRectangle,
          testRectangle.copyWith(isSelected: true));
    });

    test('DrawingState selectedRectangle getter returns null if no selection',
        () {
      final stateWithRect = initialState.addRectangle(testRectangle);
      expect(stateWithRect.selectedRectangle, null);
    });

    test('DrawingState hasSelectedRectangles getter', () {
      final stateWithRect = initialState.addRectangle(testRectangle);
      expect(stateWithRect.hasSelectedRectangles, false);

      final selectedState = stateWithRect.selectRectangle(testRectangle.id);
      expect(selectedState.hasSelectedRectangles, true);
    });

    test('DrawingState selectedRectangles getter', () {
      final rect1 = Rectangle(
        id: '1',
        bounds: const Rect.fromLTWH(0, 0, 10, 10),
        createdAt: DateTime(2023, 1, 1),
      );
      final rect2 = Rectangle(
        id: '2',
        bounds: const Rect.fromLTWH(20, 20, 10, 10),
        isSelected: true,
        createdAt: DateTime(2023, 1, 1),
      );
      final rect3 = Rectangle(
        id: '3',
        bounds: const Rect.fromLTWH(40, 40, 10, 10),
        createdAt: DateTime(2023, 1, 1),
      );

      final state = initialState.copyWith(rectangles: [rect1, rect2, rect3]);
      expect(state.selectedRectangles, [rect2]);

      final stateWithMultipleSelected = state.copyWith(
        rectangles: [
          rect1.copyWith(isSelected: true),
          rect2.copyWith(isSelected: true),
          rect3,
        ],
      );
      expect(stateWithMultipleSelected.selectedRectangles,
          [rect1.copyWith(isSelected: true), rect2.copyWith(isSelected: true)]);
    });
  });
}
