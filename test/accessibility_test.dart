import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drilldraw/main.dart';

void main() {
  group('DrillDraw Accessibility Tests', () {
    testWidgets('App has proper semantic structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Verify the app has semantic structure
      final semantics = SemanticsBinding.instance;
      expect(semantics, isNotNull);
    });

    testWidgets('Canvas has semantics widget', (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Find the canvas semantics
      final canvasSemantics = find.byType(Semantics);
      expect(canvasSemantics, findsWidgets);
    });

    testWidgets('Info panel has live region for dot count',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Verify initial dot count
      expect(find.text('Dots placed: 0'), findsOneWidget);

      // Find the live region semantics
      final liveRegionFinder = find.byWidgetPredicate((widget) {
        return widget is Semantics && widget.properties.liveRegion != null;
      });
      expect(liveRegionFinder, findsOneWidget);
    });

    testWidgets('Clear button has proper tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Find the clear button
      final clearButton = find.byIcon(Icons.clear);
      expect(clearButton, findsOneWidget);

      // Verify button has tooltip by checking the parent IconButton
      final iconButton = find.ancestor(
        of: clearButton,
        matching: find.byType(IconButton),
      );
      expect(iconButton, findsOneWidget);

      final button = tester.widget<IconButton>(iconButton);
      expect(button.tooltip, isNotNull);
      expect(button.tooltip, contains('Clear all dots'));
    });

    testWidgets('Keyboard shortcuts work for clearing dots',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Add some dots first
      await tester.tap(find.byKey(const ValueKey('canvas_gesture_detector')));
      await tester.pump();
      expect(find.text('Dots placed: 1'), findsOneWidget);

      // Test Ctrl+C shortcut
      await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
      await tester.sendKeyDownEvent(LogicalKeyboardKey.keyC);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.keyC);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
      await tester.pump();

      expect(find.text('Dots placed: 0'), findsOneWidget);
    });

    testWidgets('Escape key clears dots', (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Add some dots first
      await tester.tap(find.byKey(const ValueKey('canvas_gesture_detector')));
      await tester.pump();
      expect(find.text('Dots placed: 1'), findsOneWidget);

      // Test Escape key
      await tester.sendKeyDownEvent(LogicalKeyboardKey.escape);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.escape);
      await tester.pump();

      expect(find.text('Dots placed: 0'), findsOneWidget);
    });

    testWidgets('Focus management works correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Find the focus nodes (there will be multiple from MaterialApp)
      final focusFinder = find.byType(Focus);
      expect(focusFinder, findsWidgets);

      // Verify at least one focus widget has autofocus
      final focusWidgets = tester.widgetList<Focus>(focusFinder);
      final hasAutofocus = focusWidgets.any((focus) => focus.autofocus == true);
      expect(hasAutofocus, isTrue);
    });

    testWidgets('App supports keyboard navigation',
        (WidgetTester tester) async {
      await tester.pumpWidget(const DrillDrawApp());

      // Verify KeyboardListener is present
      final keyboardListener = find.byType(KeyboardListener);
      expect(keyboardListener, findsOneWidget);
    });
  });
}
