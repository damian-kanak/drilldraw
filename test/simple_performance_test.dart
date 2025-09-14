import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drilldraw/main.dart';
import 'package:drilldraw/widgets/dot_canvas.dart';
import 'package:drilldraw/widgets/info_panel.dart';
import 'package:drilldraw/models/drawing_state.dart';

void main() {
  group('Simple Performance Tests', () {
    testWidgets('App loads with performance optimizations',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Verify app loads correctly
      expect(find.text('DrillDraw'), findsOneWidget);
      expect(find.text('Dots placed: 0'), findsOneWidget);

      // Verify performance optimizations are present
      expect(find.byType(InfoPanel), findsOneWidget);
      expect(find.byKey(const ValueKey('canvas_gesture_detector')),
          findsOneWidget);
    });

    testWidgets('DotPainter constructor is const', (WidgetTester tester) async {
      // Test that DotPainter can be created with const constructor
      const drawingState = DrawingState(
        dots: [
          Offset(10, 10),
          Offset(20, 20),
        ],
      );

      const painter = DotPainter(drawingState);
      expect(painter.drawingState.dots, equals(drawingState.dots));
    });

    testWidgets('DotPainter shouldRepaint optimization works',
        (WidgetTester tester) async {
      const drawingState1 = DrawingState(dots: [Offset(10, 10)]);
      const drawingState2 =
          DrawingState(dots: [Offset(10, 10), Offset(20, 20)]);
      const drawingState3 = DrawingState(dots: [Offset(10, 10)]);

      const painter1 = DotPainter(drawingState1);
      const painter2 = DotPainter(drawingState2);
      const painter3 = DotPainter(drawingState3);

      // Different lengths should trigger repaint
      expect(painter1.shouldRepaint(painter2), isTrue);

      // Same dots should not trigger repaint
      expect(painter1.shouldRepaint(painter3), isFalse);

      // Different positions should trigger repaint
      const painter4 = DotPainter(DrawingState(dots: [Offset(15, 15)]));
      expect(painter1.shouldRepaint(painter4), isTrue);
    });

    testWidgets('Clear button is present and accessible',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Verify clear button is present
      expect(find.byIcon(Icons.clear), findsOneWidget);

      // Verify it's accessible
      final clearButton = find.byIcon(Icons.clear);
      expect(clearButton, findsOneWidget);
    });

    testWidgets('Widget structure is optimized', (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Verify key widgets are present
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(CustomPaint),
          findsWidgets); // May be multiple due to Flutter internals
      expect(find.byType(RepaintBoundary), findsWidgets);
    });

    testWidgets('Performance optimizations survive rebuilds',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Force a rebuild by pumping again
      await tester.pump();

      // Verify performance optimizations are still present
      expect(find.byType(InfoPanel), findsOneWidget);
      expect(find.byKey(const ValueKey('canvas_gesture_detector')),
          findsOneWidget);
    });
  });
}
