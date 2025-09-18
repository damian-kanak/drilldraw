import 'package:flutter/material.dart';
import '../models/drawing_state.dart';
import '../models/rectangle.dart';
import 'dot_painter.dart';
import 'rectangle_painter.dart';

/// A combined custom painter that renders both dots and rectangles
class CombinedPainter extends CustomPainter {
  final DrawingState drawingState;

  const CombinedPainter(this.drawingState);

  @override
  void paint(Canvas canvas, Size size) {
    // Create painters for dots and rectangles
    final dotPainter = DotPainter(drawingState);
    final rectanglePainter = RectanglePainter(drawingState);

    // Render dots first (background layer)
    dotPainter.paint(canvas, size);

    // Render rectangles on top (foreground layer)
    rectanglePainter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CombinedPainter oldDelegate) {
    // Repaint when any part of the drawing state changes
    return drawingState.dots != oldDelegate.drawingState.dots ||
        drawingState.rectangles != oldDelegate.drawingState.rectangles ||
        drawingState.selectedDot != oldDelegate.drawingState.selectedDot ||
        drawingState.selectedRectangleId !=
            oldDelegate.drawingState.selectedRectangleId ||
        drawingState.isDrawing != oldDelegate.drawingState.isDrawing ||
        drawingState.dragPreview != oldDelegate.drawingState.dragPreview;
  }

  /// Helper method to get the rectangle at a specific point
  Rectangle? getRectangleAt(Offset point) {
    final rectanglePainter = RectanglePainter(drawingState);
    return rectanglePainter.getRectangleAt(point);
  }

  /// Helper method to get all rectangles that intersect with a given rectangle
  List<Rectangle> getRectanglesInArea(Rect area) {
    final rectanglePainter = RectanglePainter(drawingState);
    return rectanglePainter.getRectanglesInArea(area);
  }

  /// Helper method to get the dot at a specific point
  Offset? getDotAt(Offset point) {
    final dotPainter = DotPainter(drawingState);
    return dotPainter.getDotAt(point);
  }

  /// Helper method to get all dots within a given area
  List<Offset> getDotsInArea(Rect area) {
    final dotPainter = DotPainter(drawingState);
    return dotPainter.getDotsInArea(area);
  }

  /// Helper method to get the resize handle at a specific point
  String? getResizeHandleAt(Offset point) {
    final rectanglePainter = RectanglePainter(drawingState);
    return rectanglePainter.getResizeHandleAt(point);
  }
}
