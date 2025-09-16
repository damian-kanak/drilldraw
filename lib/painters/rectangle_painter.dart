import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/drawing_state.dart';
import '../models/rectangle.dart';

/// A custom painter that renders rectangles on the canvas
class RectanglePainter extends CustomPainter {
  final DrawingState drawingState;

  const RectanglePainter(this.drawingState);

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for rectangle fill
    final fillPaint = Paint()
      ..color = AppConstants.rectangleFillColor
      ..style = PaintingStyle.fill;

    // Paint for rectangle border
    final borderPaint = Paint()
      ..color = AppConstants.rectangleBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppConstants.rectangleStrokeWidth;

    // Paint for selected rectangle border
    final selectedBorderPaint = Paint()
      ..color = AppConstants.rectangleSelectedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppConstants.rectangleStrokeWidth * 2;

    // Draw all rectangles
    for (final rectangle in drawingState.rectangles) {
      final rect = rectangle.bounds;

      // Skip rectangles that are too small or invalid
      if (rect.width < AppConstants.rectangleMinSize ||
          rect.height < AppConstants.rectangleMinSize) {
        continue;
      }

      // Draw rectangle fill
      canvas.drawRect(rect, fillPaint);

      // Draw rectangle border (thicker if selected)
      if (rectangle.isSelected ||
          rectangle.id == drawingState.selectedRectangleId) {
        canvas.drawRect(rect, selectedBorderPaint);
      } else {
        canvas.drawRect(rect, borderPaint);
      }
    }

    // Draw drag preview if currently drawing
    if (drawingState.isDrawing && drawingState.dragPreview != null) {
      _drawDragPreview(canvas, drawingState.dragPreview!);
    }
  }

  /// Draws a preview rectangle while the user is dragging to create a new rectangle
  void _drawDragPreview(Canvas canvas, Rect dragPreview) {
    // Skip if preview is too small
    if (dragPreview.width < AppConstants.rectangleMinSize ||
        dragPreview.height < AppConstants.rectangleMinSize) {
      return;
    }

    // Paint for drag preview fill (semi-transparent)
    final previewFillPaint = Paint()
      ..color = AppConstants.rectangleFillColor.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    // Paint for drag preview border (dashed effect)
    final previewBorderPaint = Paint()
      ..color = AppConstants.rectangleBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppConstants.rectangleStrokeWidth;

    // Draw preview rectangle
    canvas.drawRect(dragPreview, previewFillPaint);
    canvas.drawRect(dragPreview, previewBorderPaint);
  }

  @override
  bool shouldRepaint(RectanglePainter oldDelegate) {
    // Repaint when rectangles change, selection changes, or drawing state changes
    return drawingState.rectangles != oldDelegate.drawingState.rectangles ||
        drawingState.selectedRectangleId !=
            oldDelegate.drawingState.selectedRectangleId ||
        drawingState.isDrawing != oldDelegate.drawingState.isDrawing ||
        drawingState.dragPreview != oldDelegate.drawingState.dragPreview;
  }

  /// Helper method to get the rectangle at a specific point
  Rectangle? getRectangleAt(Offset point) {
    // Check rectangles in reverse order (top-most first)
    for (int i = drawingState.rectangles.length - 1; i >= 0; i--) {
      final rectangle = drawingState.rectangles[i];
      if (rectangle.containsPoint(point)) {
        return rectangle;
      }
    }
    return null;
  }

  /// Helper method to get all rectangles that intersect with a given rectangle
  List<Rectangle> getRectanglesInArea(Rect area) {
    return drawingState.rectangles
        .where((rectangle) => rectangle.bounds.overlaps(area))
        .toList();
  }
}
