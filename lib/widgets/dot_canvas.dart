import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/drawing_state.dart';
import '../models/drawing_mode.dart';
import '../painters/combined_painter.dart';

/// A canvas widget that displays and handles drawing interactions
class DotCanvas extends StatelessWidget {
  final DrawingState drawingState;
  final Function(Offset) onDotAdded;
  final Function(Offset) onRectangleCreationStart;
  final Function(Offset) onRectangleCreationUpdate;
  final Function(Offset) onRectangleCreationEnd;
  final Function(Offset) onShapeSelected;
  final GlobalKey canvasKey;

  const DotCanvas({
    super.key,
    required this.drawingState,
    required this.onDotAdded,
    required this.onRectangleCreationStart,
    required this.onRectangleCreationUpdate,
    required this.onRectangleCreationEnd,
    required this.onShapeSelected,
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

              // Handle different drawing modes
              switch (drawingState.drawingMode) {
                case DrawingMode.dot:
                  onDotAdded(localPosition);
                  break;
                case DrawingMode.rectangle:
                  onRectangleCreationStart(localPosition);
                  break;
                case DrawingMode.select:
                  onShapeSelected(localPosition);
                  break;
                case DrawingMode.arrow:
                  // TODO: Implement arrow creation
                  break;
              }
            },
            onPanStart: (DragStartDetails details) {
              if (drawingState.drawingMode == DrawingMode.rectangle) {
                final RenderBox renderBox =
                    canvasKey.currentContext!.findRenderObject() as RenderBox;
                final localPosition = renderBox.globalToLocal(
                  details.globalPosition,
                );
                onRectangleCreationStart(localPosition);
              }
            },
            onPanUpdate: (DragUpdateDetails details) {
              if (drawingState.drawingMode == DrawingMode.rectangle) {
                final RenderBox renderBox =
                    canvasKey.currentContext!.findRenderObject() as RenderBox;
                final localPosition = renderBox.globalToLocal(
                  details.globalPosition,
                );
                onRectangleCreationUpdate(localPosition);
              }
            },
            onPanEnd: (DragEndDetails details) {
              if (drawingState.drawingMode == DrawingMode.rectangle) {
                final RenderBox renderBox =
                    canvasKey.currentContext!.findRenderObject() as RenderBox;
                final localPosition = renderBox.globalToLocal(
                  details.globalPosition,
                );
                onRectangleCreationEnd(localPosition);
              }
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
