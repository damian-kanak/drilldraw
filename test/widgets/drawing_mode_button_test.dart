import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_mode.dart';
import 'package:drilldraw/widgets/drawing_mode_button.dart';

void main() {
  group('DrawingModeButton Tests', () {
    testWidgets('DrawingModeButton displays correct content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawingModeButton(
              mode: DrawingMode.dot,
              isSelected: false,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Verify button content
      expect(find.text('Dot'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);
    });

    testWidgets('DrawingModeButton shows selected state correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawingModeButton(
              mode: DrawingMode.rectangle,
              isSelected: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Verify selected button content
      expect(find.text('Rectangle'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.byIcon(Icons.crop_square), findsOneWidget);
    });

    testWidgets('DrawingModeButton responds to taps',
        (WidgetTester tester) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawingModeButton(
              mode: DrawingMode.select,
              isSelected: false,
              onPressed: () => buttonPressed = true,
            ),
          ),
        ),
      );

      // Tap the button
      await tester.tap(find.byType(DrawingModeButton));
      await tester.pumpAndSettle();

      // Verify callback was called
      expect(buttonPressed, isTrue);
    });

    testWidgets('DrawingModeButton has tooltip widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawingModeButton(
              mode: DrawingMode.arrow,
              isSelected: false,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Verify tooltip widget is present (even if not visible)
      expect(find.byType(Tooltip), findsOneWidget);
    });

    testWidgets('DrawingModeButton displays correct icons for all modes',
        (WidgetTester tester) async {
      final modes = DrawingMode.values;
      final expectedIcons = [
        Icons.radio_button_unchecked,
        Icons.crop_square,
        Icons.open_with,
        Icons.trending_flat,
      ];

      for (int i = 0; i < modes.length; i++) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DrawingModeButton(
                mode: modes[i],
                isSelected: false,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byIcon(expectedIcons[i]), findsOneWidget);
      }
    });
  });
}
