import 'package:flutter/material.dart';

/// Application-wide constants for DrillDraw
class AppConstants {
  // Drawing configuration
  static const double dotRadius = 8.0;
  static const double dotStrokeWidth = 2.0;
  static const Color dotFillColor = Colors.deepPurple;
  static const Color dotBorderColor = Colors.deepPurple;
  
  // UI configuration
  static const Color canvasBackgroundColor = Color(0xFFF5F5F5); // Colors.grey[100]
  static const String appTitle = 'DrillDraw';
  static const String canvasSemanticLabel = 'Drawing canvas. Click to place dots.';
  static const String canvasSemanticHint = 'Interactive drawing area. Use mouse click or touch to place dots.';
  
  // Accessibility
  static const String clearButtonLabel = 'Clear all dots';
  static const String clearButtonTooltip = 'Clear all dots (Ctrl+C or Escape)';
  static const String instructionsText = 'Click anywhere on the canvas to place a dot';
  static const String dotsPlacedText = 'Dots placed: ';
  
  // Keyboard shortcuts
  static const String keyboardShortcutsHelp = 
      'Keyboard shortcuts: Ctrl+C or Escape to clear all dots';
  
  // Performance
  static const bool enableRepaintOptimization = false; // Disabled for immediate response
}
