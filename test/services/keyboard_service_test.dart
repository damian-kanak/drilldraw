import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/drawing_mode.dart';
import 'package:drilldraw/services/keyboard_service.dart';

void main() {
  group('KeyboardService Tests', () {
    test('handleKeyboardEvent calls onClearDots for Escape', () {
      bool clearCalled = false;

      final event = KeyDownEvent(
        logicalKey: LogicalKeyboardKey.escape,
        physicalKey: PhysicalKeyboardKey.escape,
        timeStamp: Duration.zero,
      );

      KeyboardService.handleKeyboardEvent(
        event,
        () => clearCalled = true,
        null,
      );

      expect(clearCalled, isTrue);
    });

    test('handleKeyboardEvent calls onModeChanged for digit keys', () {
      DrawingMode? selectedMode;

      // Test digit 1 (Dot mode)
      final event1 = KeyDownEvent(
        logicalKey: LogicalKeyboardKey.digit1,
        physicalKey: PhysicalKeyboardKey.digit1,
        character: '1',
        timeStamp: Duration.zero,
      );

      KeyboardService.handleKeyboardEvent(
        event1,
        () {},
        (mode) => selectedMode = mode,
      );

      expect(selectedMode, DrawingMode.dot);

      // Test digit 2 (Rectangle mode)
      selectedMode = null;
      final event2 = KeyDownEvent(
        logicalKey: LogicalKeyboardKey.digit2,
        physicalKey: PhysicalKeyboardKey.digit2,
        character: '2',
        timeStamp: Duration.zero,
      );

      KeyboardService.handleKeyboardEvent(
        event2,
        () {},
        (mode) => selectedMode = mode,
      );

      expect(selectedMode, DrawingMode.rectangle);

      // Test digit 3 (Select mode)
      selectedMode = null;
      final event3 = KeyDownEvent(
        logicalKey: LogicalKeyboardKey.digit3,
        physicalKey: PhysicalKeyboardKey.digit3,
        character: '3',
        timeStamp: Duration.zero,
      );

      KeyboardService.handleKeyboardEvent(
        event3,
        () {},
        (mode) => selectedMode = mode,
      );

      expect(selectedMode, DrawingMode.select);

      // Test digit 4 (Arrow mode)
      selectedMode = null;
      final event4 = KeyDownEvent(
        logicalKey: LogicalKeyboardKey.digit4,
        physicalKey: PhysicalKeyboardKey.digit4,
        character: '4',
        timeStamp: Duration.zero,
      );

      KeyboardService.handleKeyboardEvent(
        event4,
        () {},
        (mode) => selectedMode = mode,
      );

      expect(selectedMode, DrawingMode.arrow);
    });

    test('handleKeyboardEvent calls onDeleteSelectedShapes for Delete key', () {
      bool deleteCalled = false;

      final event = KeyDownEvent(
        logicalKey: LogicalKeyboardKey.delete,
        physicalKey: PhysicalKeyboardKey.delete,
        timeStamp: Duration.zero,
      );

      KeyboardService.handleKeyboardEvent(
        event,
        () {},
        null,
        onDeleteSelectedShapes: () => deleteCalled = true,
      );

      expect(deleteCalled, isTrue);
    });

    test('handleKeyboardEvent calls onDeleteSelectedShapes for Backspace key',
        () {
      bool deleteCalled = false;

      final event = KeyDownEvent(
        logicalKey: LogicalKeyboardKey.backspace,
        physicalKey: PhysicalKeyboardKey.backspace,
        timeStamp: Duration.zero,
      );

      KeyboardService.handleKeyboardEvent(
        event,
        () {},
        null,
        onDeleteSelectedShapes: () => deleteCalled = true,
      );

      expect(deleteCalled, isTrue);
    });

    test(
        'handleKeyboardEvent does not call onDeleteSelectedShapes when not provided',
        () {
      final event = KeyDownEvent(
        logicalKey: LogicalKeyboardKey.delete,
        physicalKey: PhysicalKeyboardKey.delete,
        timeStamp: Duration.zero,
      );

      // Should not throw an error
      expect(
        () => KeyboardService.handleKeyboardEvent(
          event,
          () {},
          null,
        ),
        returnsNormally,
      );
    });

    test('getKeyboardHelpText returns correct help text', () {
      final helpText = KeyboardService.getKeyboardHelpText();

      expect(helpText, contains('Ctrl+C'));
      expect(helpText, contains('Escape'));
      expect(helpText, contains('Delete/Backspace'));
      expect(helpText, contains('clear all shapes'));
      expect(helpText, contains('mode switching'));
    });
  });
}
