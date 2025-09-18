import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/drawing_mode.dart';
import '../models/drawing_state.dart';
import '../painters/combined_painter.dart';

/// A canvas widget that displays and handles drawing interactions
class DotCanvas extends StatelessWidget {
  final DrawingState drawingState;
  final Function(Offset) onDotAdded;
  final Function(Offset) onRectangleCreationStart;
  final Function(Offset) onRectangleCreationUpdate;
  final Function(Offset) onRectangleCreationEnd;
  final Function(Offset) onShapeSelected;
  final Function(Offset) onMoveStart;
  final Function(Offset) onMoveUpdate;
  final Function(Offset) onMoveEnd;
  final Function(String, Offset) onResizeStart;
  final Function(Offset) onResizeUpdate;
  final Function(Offset) onResizeEnd;
  final GlobalKey canvasKey;

  const DotCanvas({
    super.key,
    required this.drawingState,
    required this.onDotAdded,
    required this.onRectangleCreationStart,
    required this.onRectangleCreationUpdate,
    required this.onRectangleCreationEnd,
    required this.onShapeSelected,
    required this.onMoveStart,
    required this.onMoveUpdate,
    required this.onMoveEnd,
    required this.onResizeStart,
    required this.onResizeUpdate,
    required this.onResizeEnd,
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
          label: '${AppConstants.canvasSemanticLabel} '
              '${drawingState.totalShapeCount} shapes placed.',
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
                  // For rectangle, onTapDown can initiate a single-click
                  // rectangle or start a drag
                  onRectangleCreationStart(localPosition);
                  break;
                case DrawingMode.select:
                  // Check for resize handle first
                  final combinedPainter = CombinedPainter(drawingState);
                  final resizeHandle =
                      combinedPainter.getResizeHandleAt(localPosition);
                  if (resizeHandle != null) {
                    onResizeStart(resizeHandle, localPosition);
                  } else {
                    onShapeSelected(localPosition);
                  }
                  break;
                case DrawingMode.arrow:
                  // TODO: Implement arrow creation
                  break;
              }
            },
            onPanStart: (DragStartDetails details) {
              final RenderBox renderBox =
                  canvasKey.currentContext!.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(
                details.globalPosition,
              );

              switch (drawingState.drawingMode) {
                case DrawingMode.rectangle:
                  onRectangleCreationStart(localPosition);
                  break;
                case DrawingMode.select:
                  // Check if we're starting to resize
                  if (drawingState.isResizing) {
                    // Resize operation already started in onTapDown
                    break;
                  }
                  // Check if we're starting to move a selected rectangle
                  if (drawingState.hasSelectedRectangles &&
                      !drawingState.isMoving) {
                    onMoveStart(localPosition);
                  }
                  break;
                default:
                  break;
              }
            },
            onPanUpdate: (DragUpdateDetails details) {
              final RenderBox renderBox =
                  canvasKey.currentContext!.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(
                details.globalPosition,
              );

              switch (drawingState.drawingMode) {
                case DrawingMode.rectangle:
                  onRectangleCreationUpdate(localPosition);
                  break;
                case DrawingMode.select:
                  // Update resize operation if we're currently resizing
                  if (drawingState.isResizing) {
                    onResizeUpdate(localPosition);
                  }
                  // Update move operation if we're currently moving
                  else if (drawingState.isMoving) {
                    onMoveUpdate(localPosition);
                  }
                  break;
                default:
                  break;
              }
            },
            onPanEnd: (DragEndDetails details) {
              final RenderBox renderBox =
                  canvasKey.currentContext!.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(
                details.globalPosition,
              );

              switch (drawingState.drawingMode) {
                case DrawingMode.rectangle:
                  onRectangleCreationEnd(localPosition);
                  break;
                case DrawingMode.select:
                  // End resize operation if we're currently resizing
                  if (drawingState.isResizing) {
                    onResizeEnd(localPosition);
                  }
                  // End move operation if we're currently moving
                  else if (drawingState.isMoving) {
                    onMoveEnd(localPosition);
                  }
                  break;
                default:
                  break;
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
