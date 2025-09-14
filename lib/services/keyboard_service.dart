import 'package:flutter/services.dart';

/// Service for handling keyboard events and shortcuts
class KeyboardService {
  /// Handle keyboard events for the drawing canvas
  static void handleKeyboardEvent(
    KeyEvent event,
    VoidCallback onClearDots,
  ) {
    if (event is KeyDownEvent) {
      // Handle keyboard shortcuts
      if (event.logicalKey == LogicalKeyboardKey.keyC &&
          HardwareKeyboard.instance.isControlPressed) {
        onClearDots();
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        onClearDots();
      }
    }
  }

  /// Get help text for available keyboard shortcuts
  static String getKeyboardHelpText() {
    return 'Keyboard shortcuts: Ctrl+C or Escape to clear all dots';
  }
}
