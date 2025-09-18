import 'package:flutter/services.dart';
import '../models/drawing_mode.dart';

/// Service for handling keyboard events and shortcuts
class KeyboardService {
  /// Handle keyboard events for the drawing canvas
  static void handleKeyboardEvent(
    KeyEvent event,
    VoidCallback onClearDots,
    Function(DrawingMode)? onModeChanged, {
    VoidCallback? onDeleteSelectedShapes,
  }) {
    if (event is KeyDownEvent) {
      // Handle keyboard shortcuts
      if (event.logicalKey == LogicalKeyboardKey.keyC &&
          HardwareKeyboard.instance.isControlPressed) {
        onClearDots();
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        onClearDots();
      } else if (event.logicalKey == LogicalKeyboardKey.delete ||
          event.logicalKey == LogicalKeyboardKey.backspace) {
        // Handle Delete/Backspace key for selected shapes
        onDeleteSelectedShapes?.call();
      } else if (onModeChanged != null) {
        // Handle mode switching shortcuts
        DrawingMode? targetMode;
        if (event.logicalKey == LogicalKeyboardKey.digit1) {
          targetMode = DrawingMode.dot;
        } else if (event.logicalKey == LogicalKeyboardKey.digit2) {
          targetMode = DrawingMode.rectangle;
        } else if (event.logicalKey == LogicalKeyboardKey.digit3) {
          targetMode = DrawingMode.select;
        } else if (event.logicalKey == LogicalKeyboardKey.digit4) {
          targetMode = DrawingMode.arrow;
        }

        if (targetMode != null) {
          onModeChanged(targetMode);
        }
      }
    }
  }

  /// Get help text for available keyboard shortcuts
  static String getKeyboardHelpText() {
    return 'Keyboard shortcuts: Ctrl+C or Escape to clear all shapes, '
        'Delete/Backspace to delete selected shapes, '
        '1-4 for mode switching';
  }
}
