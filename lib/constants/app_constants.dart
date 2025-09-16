import 'package:flutter/material.dart';

/// Application-wide constants for DrillDraw
class AppConstants {
  // Drawing configuration
  static const double dotRadius = 8.0;
  static const double dotStrokeWidth = 2.0;
  static const Color dotFillColor = Colors.deepPurple;
  static const Color dotBorderColor = Colors.deepPurple;

  // Rectangle configuration
  static const double rectangleStrokeWidth = 2.0;
  static const Color rectangleFillColor =
      Color(0x4D2196F3); // Colors.blue.withOpacity(0.3)
  static const Color rectangleBorderColor = Colors.blue;
  static const Color rectangleSelectedColor = Colors.orange;
  static const double rectangleMinSize = 10.0;

  // UI configuration
  static const Color canvasBackgroundColor =
      Color(0xFFF5F5F5); // Colors.grey[100]
  static const String appTitle = 'DrillDraw';
  static const String canvasSemanticLabel =
      'Drawing canvas. Click to place shapes.';
  static const String canvasSemanticHint =
      'Interactive drawing area. Use mouse click or touch to place shapes.';

  // Accessibility
  static const String clearButtonLabel = 'Clear all shapes';
  static const String clearButtonTooltip =
      'Clear all shapes (Ctrl+C or Escape)';
  static const String instructionsText =
      'Click anywhere on the canvas to place shapes';
  static const String shapesPlacedText = 'Shapes placed: ';

  // Keyboard shortcuts
  static const String keyboardShortcutsHelp =
      'Keyboard shortcuts: Ctrl+C or Escape to clear all shapes';

  // Performance
  static const bool enableRepaintOptimization =
      false; // Disabled for immediate response
}
