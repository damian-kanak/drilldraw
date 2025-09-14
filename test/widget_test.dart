// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drilldraw/main.dart';

void main() {
  testWidgets('DrillDraw app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DrillDrawApp());

    // Verify that the app loads with correct title
    expect(find.text('DrillDraw'), findsOneWidget);
    expect(find.text('Click anywhere on the canvas to place a dot'), findsOneWidget);
    expect(find.text('Dots placed: 0'), findsOneWidget);

    // Verify clear button is present
    expect(find.byIcon(Icons.clear), findsOneWidget);
  });
}
