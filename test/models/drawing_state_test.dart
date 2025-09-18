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

    test('DrawingState selectDot works correctly', () {
      final dot1 = const Offset(10, 10);
      final dot2 = const Offset(20, 20);
      final state = DrawingState(dots: [dot1, dot2]);

      final selectedState = state.selectDot(dot1);
      expect(selectedState.selectedDot, dot1);
      expect(selectedState.selectedRectangleId, isNull);
    });

    test('DrawingState clearDotSelection works correctly', () {
      final dot1 = const Offset(10, 10);
      final state = DrawingState(dots: [dot1], selectedDot: dot1);

      final clearedState = state.clearDotSelection();
      expect(clearedState.selectedDot, isNull);
    });

    test('DrawingState clearAllSelections works correctly', () {
      final dot1 = const Offset(10, 10);
      final rect1 = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(10, 10, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );
      final state = DrawingState(
        dots: [dot1],
        rectangles: [rect1],
        selectedDot: dot1,
        selectedRectangleId: 'rect1',
      );

      final clearedState = state.clearAllSelections();
      expect(clearedState.selectedDot, isNull);
      expect(clearedState.selectedRectangleId, isNull);
      expect(clearedState.rectangles.first.isSelected, false);
    });

    test('DrawingState hasSelectedDots getter returns correct value', () {
      final dot1 = const Offset(10, 10);
      final stateWithSelection = DrawingState(selectedDot: dot1);
      final stateWithoutSelection = const DrawingState();

      expect(stateWithSelection.hasSelectedDots, true);
      expect(stateWithoutSelection.hasSelectedDots, false);
    });

    test('DrawingState hasSelectedShapes getter returns correct value', () {
      final dot1 = const Offset(10, 10);
      final rect1 = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(10, 10, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );

      final stateWithDotSelection = DrawingState(selectedDot: dot1);
      final stateWithRectSelection = DrawingState(
        rectangles: [rect1.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
      );
      final stateWithoutSelection = const DrawingState();

      expect(stateWithDotSelection.hasSelectedShapes, true);
      expect(stateWithRectSelection.hasSelectedShapes, true);
      expect(stateWithoutSelection.hasSelectedShapes, false);
    });

    test('DrawingState selection methods clear other selections', () {
      final dot1 = const Offset(10, 10);
      final rect1 = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(10, 10, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );

      // Start with rectangle selected
      final stateWithRectSelection = DrawingState(
        rectangles: [rect1],
        selectedRectangleId: 'rect1',
      );

      // Select dot - should clear rectangle selection
      final stateWithDotSelection = stateWithRectSelection.selectDot(dot1);
      expect(stateWithDotSelection.selectedDot, dot1);
      expect(stateWithDotSelection.selectedRectangleId, isNull);

      // Select rectangle - should clear dot selection
      final stateWithRectSelectionAgain =
          stateWithDotSelection.selectRectangle('rect1');
      expect(stateWithRectSelectionAgain.selectedDot, isNull);
      expect(stateWithRectSelectionAgain.selectedRectangleId, 'rect1');
    });

    test('DrawingState prevents selecting dot while rectangle is selected', () {
      final dot1 = const Offset(10, 10);
      final rect1 = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(10, 10, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );

      // Start with rectangle selected
      final stateWithRectSelection = DrawingState(
        rectangles: [rect1.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
      );

      // Verify rectangle is selected
      expect(stateWithRectSelection.hasSelectedRectangles, true);
      expect(stateWithRectSelection.hasSelectedDots, false);
      expect(stateWithRectSelection.hasSelectedShapes, true);

      // Try to select dot while rectangle is selected
      final stateWithBothSelected = stateWithRectSelection.selectDot(dot1);

      // Should clear rectangle selection and select dot instead
      expect(stateWithBothSelected.selectedDot, dot1);
      expect(stateWithBothSelected.selectedRectangleId, isNull);
      expect(stateWithBothSelected.hasSelectedDots, true);
      expect(stateWithBothSelected.hasSelectedRectangles, false);
      expect(stateWithBothSelected.hasSelectedShapes, true);
    });
  });

  group('Move Operations', () {
    test('startMoveOperation sets isMoving and moveStartPosition', () {
      const startPosition = Offset(10, 10);
      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(0, 0, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );

      final state = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
      );

      final moveState = state.startMoveOperation(startPosition);

      expect(moveState.isMoving, true);
      expect(moveState.moveStartPosition, startPosition);
    });

    test('startMoveOperation does nothing if no rectangle selected', () {
      const startPosition = Offset(10, 10);
      final state = const DrawingState();

      final moveState = state.startMoveOperation(startPosition);

      expect(moveState, equals(state));
    });

    test('updateMoveOperation moves selected rectangle', () {
      const startPosition = Offset(10, 10);
      const currentPosition = Offset(30, 30);
      const expectedDelta = Offset(20, 20);

      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(0, 0, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );

      final initialState = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
        isMoving: true,
        moveStartPosition: startPosition,
      );

      final updatedState = initialState.updateMoveOperation(currentPosition);

      expect(updatedState.rectangles.first.bounds,
          const Rect.fromLTWH(20, 20, 50, 50));
      expect(updatedState.moveStartPosition, currentPosition);
    });

    test('updateMoveOperation does nothing if not moving', () {
      const currentPosition = Offset(30, 30);
      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(0, 0, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );

      final state = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
        isMoving: false,
      );

      final updatedState = state.updateMoveOperation(currentPosition);

      expect(updatedState, equals(state));
    });

    test('endMoveOperation clears move state', () {
      const startPosition = Offset(10, 10);
      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(0, 0, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );

      final moveState = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
        isMoving: true,
        moveStartPosition: startPosition,
      );

      final endState = moveState.endMoveOperation();

      expect(endState.isMoving, false);
      expect(endState.moveStartPosition, isNull);
    });

    test('complete move operation workflow', () {
      const startPosition = Offset(10, 10);
      const midPosition = Offset(25, 25);
      const endPosition = Offset(40, 40);

      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(0, 0, 50, 50),
        createdAt: DateTime(2025, 1, 1),
      );

      // Start move operation
      final initialState = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
      );

      final startState = initialState.startMoveOperation(startPosition);
      expect(startState.isMoving, true);
      expect(startState.moveStartPosition, startPosition);

      // Update move operation
      final midState = startState.updateMoveOperation(midPosition);
      expect(midState.rectangles.first.bounds,
          const Rect.fromLTWH(15, 15, 50, 50));
      expect(midState.moveStartPosition, midPosition);

      // Final update
      final finalState = midState.updateMoveOperation(endPosition);
      expect(finalState.rectangles.first.bounds,
          const Rect.fromLTWH(30, 30, 50, 50));
      expect(finalState.moveStartPosition, endPosition);

      // End move operation
      final endState = finalState.endMoveOperation();
      expect(endState.isMoving, false);
      expect(endState.moveStartPosition, isNull);
      expect(endState.rectangles.first.bounds,
          const Rect.fromLTWH(30, 30, 50, 50)); // Position should remain
    });
  });

  group('Resize Operations', () {
    test('startResizeOperation sets resize state correctly', () {
      const handle = 'topLeft';
      const startPosition = Offset(10, 10);
      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(50, 50, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final state = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
      );

      final resizeState = state.startResizeOperation(handle, startPosition);

      expect(resizeState.isResizing, true);
      expect(resizeState.resizeHandle, handle);
      expect(resizeState.resizeStartPosition, startPosition);
      expect(resizeState.resizeStartBounds, rect.bounds);
    });

    test('startResizeOperation does nothing if no rectangle selected', () {
      const handle = 'topLeft';
      const startPosition = Offset(10, 10);
      final state = const DrawingState();

      final resizeState = state.startResizeOperation(handle, startPosition);

      expect(resizeState, equals(state));
    });

    test('updateResizeOperation resizes selected rectangle', () {
      const handle = 'bottomRight';
      const startPosition = Offset(100, 100);
      const currentPosition = Offset(150, 150);

      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(50, 50, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final initialState = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
        isResizing: true,
        resizeHandle: handle,
        resizeStartPosition: startPosition,
        resizeStartBounds: rect.bounds,
      );

      final updatedState = initialState.updateResizeOperation(currentPosition);

      // Rectangle should be resized from 100x100 to 150x150
      expect(updatedState.rectangles.first.bounds,
          const Rect.fromLTWH(50, 50, 150, 150));
    });

    test('updateResizeOperation does nothing if not resizing', () {
      const currentPosition = Offset(150, 150);
      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(50, 50, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final state = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
        isResizing: false,
      );

      final updatedState = state.updateResizeOperation(currentPosition);

      expect(updatedState, equals(state));
    });

    test('endResizeOperation clears resize state', () {
      const handle = 'topLeft';
      const startPosition = Offset(10, 10);
      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(50, 50, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final resizeState = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
        isResizing: true,
        resizeHandle: handle,
        resizeStartPosition: startPosition,
        resizeStartBounds: rect.bounds,
      );

      final endState = resizeState.endResizeOperation();

      expect(endState.isResizing, false);
      expect(endState.resizeHandle, isNull);
      expect(endState.resizeStartPosition, isNull);
      expect(endState.resizeStartBounds, isNull);
    });

    test('resize handles work correctly', () {
      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(50, 50, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final state = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
      );

      // Test topLeft resize
      final topLeftState =
          state.startResizeOperation('topLeft', const Offset(50, 50));
      final topLeftResized =
          topLeftState.updateResizeOperation(const Offset(40, 40));
      expect(topLeftResized.rectangles.first.bounds,
          const Rect.fromLTWH(40, 40, 110, 110));

      // Test bottomRight resize
      final bottomRightState = topLeftResized.startResizeOperation(
          'bottomRight', const Offset(150, 150));
      final bottomRightResized =
          bottomRightState.updateResizeOperation(const Offset(160, 160));
      expect(bottomRightResized.rectangles.first.bounds,
          const Rect.fromLTWH(40, 40, 120, 120));
    });

    test('resize enforces minimum size', () {
      const handle = 'bottomRight';
      const startPosition = Offset(150, 150);
      const currentPosition = Offset(40, 40); // Would make rectangle too small

      final rect = Rectangle(
        id: 'rect1',
        bounds: const Rect.fromLTWH(50, 50, 100, 100),
        createdAt: DateTime(2025, 1, 1),
      );

      final initialState = DrawingState(
        rectangles: [rect.copyWith(isSelected: true)],
        selectedRectangleId: 'rect1',
        isResizing: true,
        resizeHandle: handle,
        resizeStartPosition: startPosition,
        resizeStartBounds: rect.bounds,
      );

      final updatedState = initialState.updateResizeOperation(currentPosition);

      // Rectangle should maintain minimum size of 10x10
      expect(updatedState.rectangles.first.bounds.width,
          greaterThanOrEqualTo(10.0));
      expect(updatedState.rectangles.first.bounds.height,
          greaterThanOrEqualTo(10.0));
    });
  });
}
