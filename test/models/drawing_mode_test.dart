import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_mode.dart';

void main() {
  group('DrawingMode Tests', () {
    test('DrawingMode displayName returns correct values', () {
      expect(DrawingMode.dot.displayName, 'Dot');
      expect(DrawingMode.rectangle.displayName, 'Rectangle');
      expect(DrawingMode.select.displayName, 'Select');
    });

    test('DrawingMode canCreateShapes returns correct values', () {
      expect(DrawingMode.dot.canCreateShapes, true);
      expect(DrawingMode.rectangle.canCreateShapes, true);
      expect(DrawingMode.select.canCreateShapes, false);
    });

    test('DrawingMode canSelectShapes returns correct values', () {
      expect(DrawingMode.dot.canSelectShapes, false);
      expect(DrawingMode.rectangle.canSelectShapes, false);
      expect(DrawingMode.select.canSelectShapes, true);
    });
  });
}
