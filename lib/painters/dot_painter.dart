import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/drawing_state.dart';

/// A custom painter that draws dots on the canvas
class DotPainter extends CustomPainter {
  final DrawingState drawingState;

  const DotPainter(this.drawingState);

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = AppConstants.dotFillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.deepPurple.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppConstants.dotStrokeWidth;

    // Paint for selected dots
    final selectedBorderPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          AppConstants.dotStrokeWidth * 1.5; // Thicker border for selection

    // Draw all dots
    for (final dot in drawingState.dotsFromShapes) {
      canvas.drawCircle(dot, AppConstants.dotRadius, dotPaint);

      // Draw selection highlight if selected
      if (drawingState.selectedDot == dot) {
        canvas.drawCircle(dot, AppConstants.dotRadius, selectedBorderPaint);
      } else {
        canvas.drawCircle(dot, AppConstants.dotRadius, borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(DotPainter oldDelegate) {
    // Repaint when dots list or selection changes
    return drawingState.dotsFromShapes !=
            oldDelegate.drawingState.dotsFromShapes ||
        drawingState.selectedDot != oldDelegate.drawingState.selectedDot;
  }

  /// Returns the top-most dot at a given point, or null if none found.
  Offset? getDotAt(Offset point) {
    // Iterate in reverse to get the top-most dot (last one added)
    for (int i = drawingState.dotsFromShapes.length - 1; i >= 0; i--) {
      final dot = drawingState.dotsFromShapes[i];
      final distance = (point - dot).distance;
      if (distance <= AppConstants.dotRadius) {
        return dot;
      }
    }
    return null;
  }

  /// Returns a list of dots that are within a given area.
  List<Offset> getDotsInArea(Rect area) {
    return drawingState.dotsFromShapes.where((dot) {
      final distance = (area.center - dot).distance;
      return distance <= AppConstants.dotRadius + area.width / 2;
    }).toList();
  }
}
