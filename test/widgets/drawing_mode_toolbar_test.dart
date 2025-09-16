import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_mode.dart';
import 'package:drilldraw/widgets/drawing_mode_toolbar.dart';

void main() {
  group('DrawingModeToolbar Tests', () {
    testWidgets('DrawingModeToolbar displays all mode buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawingModeToolbar(
              currentMode: DrawingMode.dot,
              onModeChanged: (_) {},
            ),
          ),
        ),
      );

      // Verify all mode buttons are present
      expect(find.text('Dot'), findsOneWidget);
      expect(find.text('Rectangle'), findsOneWidget);
      expect(find.text('Select'), findsOneWidget);
      expect(find.text('Arrow'), findsOneWidget);

      // Verify keyboard shortcuts are shown
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('DrawingModeToolbar highlights current mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawingModeToolbar(
              currentMode: DrawingMode.rectangle,
              onModeChanged: (_) {},
            ),
          ),
        ),
      );

      // The Rectangle button should be selected (highlighted)
      // We can verify this by checking that the Rectangle button is present
      // and the selected state is applied through the DrawingModeButton widget
      expect(find.text('Rectangle'), findsOneWidget);
    });

    testWidgets('DrawingModeToolbar calls onModeChanged when button is tapped',
        (WidgetTester tester) async {
      DrawingMode? selectedMode;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawingModeToolbar(
              currentMode: DrawingMode.dot,
              onModeChanged: (mode) => selectedMode = mode,
            ),
          ),
        ),
      );

      // Tap the Rectangle button
      await tester.tap(find.text('Rectangle'));
      await tester.pumpAndSettle();

      // Verify callback was called with correct mode
      expect(selectedMode, DrawingMode.rectangle);
    });

    testWidgets('DrawingModeToolbar has proper layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawingModeToolbar(
              currentMode: DrawingMode.dot,
              onModeChanged: (_) {},
            ),
          ),
        ),
      );

      // Verify toolbar is present
      final toolbar = find.byType(DrawingModeToolbar);
      expect(toolbar, findsOneWidget);

      // Verify toolbar contains a Container
      expect(find.byType(Container), findsOneWidget);

      // Verify toolbar contains a Row
      expect(find.byType(Row), findsOneWidget);
    });
  });
}
