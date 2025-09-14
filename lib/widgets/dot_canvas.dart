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

    // Draw all dots
    for (final dot in drawingState.dots) {
      canvas.drawCircle(dot, AppConstants.dotRadius, dotPaint);
      canvas.drawCircle(dot, AppConstants.dotRadius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(DotPainter oldDelegate) {
    // Always repaint when dots list changes
    return drawingState.dots != oldDelegate.drawingState.dots;
  }
}

/// A canvas widget that displays and handles dot drawing interactions
class DotCanvas extends StatelessWidget {
  final DrawingState drawingState;
  final Function(Offset) onDotAdded;
  final GlobalKey canvasKey;

  const DotCanvas({
    super.key,
    required this.drawingState,
    required this.onDotAdded,
    required this.canvasKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppConstants.canvasBackgroundColor,
      child: Focus(
        autofocus: true,
        child: Semantics(
          label:
              '${AppConstants.canvasSemanticLabel} ${drawingState.dotCount} dots placed.',
          hint: AppConstants.canvasSemanticHint,
          child: GestureDetector(
            key: const ValueKey('canvas_gesture_detector'),
            onTapDown: (TapDownDetails details) {
              final RenderBox renderBox =
                  canvasKey.currentContext!.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(
                details.globalPosition,
              );
              onDotAdded(localPosition);
            },
            child: CustomPaint(
              key: canvasKey,
              painter: DotPainter(drawingState),
              size: Size.infinite,
            ),
          ),
        ),
      ),
    );
  }
}
