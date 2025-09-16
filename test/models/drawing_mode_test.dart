import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_mode.dart';

void main() {
  group('DrawingMode Tests', () {
    test('DrawingMode displayName returns correct values', () {
      expect(DrawingMode.dot.displayName, 'Dot');
      expect(DrawingMode.rectangle.displayName, 'Rectangle');
      expect(DrawingMode.select.displayName, 'Select');
      expect(DrawingMode.arrow.displayName, 'Arrow');
    });

    test('DrawingMode canCreateShapes returns correct values', () {
      expect(DrawingMode.dot.canCreateShapes, true);
      expect(DrawingMode.rectangle.canCreateShapes, true);
      expect(DrawingMode.select.canCreateShapes, false);
      expect(DrawingMode.arrow.canCreateShapes, true);
    });

    test('DrawingMode canSelectShapes returns correct values', () {
      expect(DrawingMode.dot.canSelectShapes, false);
      expect(DrawingMode.rectangle.canSelectShapes, false);
      expect(DrawingMode.select.canSelectShapes, true);
      expect(DrawingMode.arrow.canSelectShapes, false);
    });

    test('DrawingMode keyboardShortcut returns correct values', () {
      expect(DrawingMode.dot.keyboardShortcut, '1');
      expect(DrawingMode.rectangle.keyboardShortcut, '2');
      expect(DrawingMode.select.keyboardShortcut, '3');
      expect(DrawingMode.arrow.keyboardShortcut, '4');
    });

    test('DrawingMode description returns correct values', () {
      expect(
          DrawingMode.dot.description, 'Place individual dots on the canvas');
      expect(DrawingMode.rectangle.description,
          'Draw rectangles by clicking and dragging');
      expect(DrawingMode.select.description,
          'Select and manipulate existing shapes');
      expect(DrawingMode.arrow.description, 'Draw arrows between shapes');
    });

    test('DrawingMode iconName returns correct values', () {
      expect(DrawingMode.dot.iconName, 'radio_button_unchecked');
      expect(DrawingMode.rectangle.iconName, 'crop_square');
      expect(DrawingMode.select.iconName, 'open_with');
      expect(DrawingMode.arrow.iconName, 'trending_flat');
    });
  });
}
