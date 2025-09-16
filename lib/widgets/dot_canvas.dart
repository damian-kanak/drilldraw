import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/drawing_state.dart';
import '../painters/combined_painter.dart';

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
              '${AppConstants.canvasSemanticLabel} ${drawingState.totalShapeCount} shapes placed.',
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
              painter: CombinedPainter(drawingState),
              size: Size.infinite,
            ),
          ),
        ),
      ),
    );
  }
}
