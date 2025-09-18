import 'package:flutter/material.dart';

import 'constants/app_constants.dart';
import 'models/drawing_mode.dart';
import 'models/drawing_state.dart';
import 'models/rectangle.dart';
import 'painters/combined_painter.dart';
import 'services/keyboard_service.dart';
import 'utils/id_generator.dart';
import 'widgets/clear_button.dart';
import 'widgets/dot_canvas.dart';
import 'widgets/drawing_mode_toolbar.dart';
import 'widgets/info_panel.dart';

void main() {
  runApp(const DrillDrawApp());
}

class DrillDrawApp extends StatelessWidget {
  const DrillDrawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.dotFillColor),
        useMaterial3: true,
      ),
      home: const DrillDrawHomePage(),
    );
  }
}

class DrillDrawHomePage extends StatefulWidget {
  const DrillDrawHomePage({super.key});

  @override
  State<DrillDrawHomePage> createState() => _DrillDrawHomePageState();
}

class _DrillDrawHomePageState extends State<DrillDrawHomePage> {
  DrawingState _drawingState = const DrawingState();
  final GlobalKey _canvasKey = GlobalKey();

  // Rectangle creation state
  Offset? _rectangleStart;
  Rect? _currentDragPreview;

  void _addDot(Offset position) {
    setState(() {
      _drawingState = _drawingState.addDot(position);
    });
  }

  void _clearDots() {
    setState(() {
      _drawingState = _drawingState.clearAll();
    });
  }

  void _changeDrawingMode(DrawingMode mode) {
    setState(() {
      _drawingState = _drawingState.setDrawingMode(mode);
      // Clear any ongoing rectangle creation when switching modes
      _rectangleStart = null;
      _currentDragPreview = null;
      _drawingState = _drawingState.clearDragPreview();
    });
  }

  void _handleKeyboardEvent(KeyEvent event) {
    KeyboardService.handleKeyboardEvent(event, _clearDots, _changeDrawingMode);
  }

  // Rectangle creation methods
  void _startRectangleCreation(Offset position) {
    setState(() {
      _rectangleStart = position;
      _drawingState = _drawingState.copyWith(isDrawing: true);
    });
  }

  void _updateRectangleCreation(Offset position) {
    if (_rectangleStart == null) return;

    setState(() {
      _currentDragPreview = Rect.fromPoints(_rectangleStart!, position);
      _drawingState = _drawingState.setDragPreview(_currentDragPreview);
    });
  }

  void _endRectangleCreation(Offset position) {
    if (_rectangleStart == null) return;

    setState(() {
      final rect = Rect.fromPoints(_rectangleStart!, position);

      // Only create rectangle if it's large enough
      if (rect.width >= AppConstants.rectangleMinSize &&
          rect.height >= AppConstants.rectangleMinSize) {
        final rectangle = Rectangle(
          id: IdGenerator.generate(),
          bounds: rect,
          createdAt: DateTime.now(),
        );
        _drawingState = _drawingState.addRectangle(rectangle);
      }

      // Clear rectangle creation state
      _rectangleStart = null;
      _currentDragPreview = null;
      _drawingState = _drawingState.copyWith(
        isDrawing: false,
        clearDragPreview: true,
      );
    });
  }

  void _selectShape(Offset position) {
    setState(() {
      final combinedPainter = CombinedPainter(_drawingState);

      // Try to select a rectangle first (rectangles are on top)
      final rectangleAt = combinedPainter.getRectangleAt(position);
      if (rectangleAt != null) {
        _drawingState = _drawingState.selectRectangle(rectangleAt.id);
        return;
      }

      // If no rectangle, try to select a dot
      final dotAt = combinedPainter.getDotAt(position);
      if (dotAt != null) {
        _drawingState = _drawingState.selectDot(dotAt);
        return;
      }

      // Clear all selections if clicking on empty space
      _drawingState = _drawingState.clearAllSelections();
    });
  }

  void _startMoveOperation(Offset position) {
    setState(() {
      _drawingState = _drawingState.startMoveOperation(position);
    });
  }

  void _updateMoveOperation(Offset position) {
    setState(() {
      _drawingState = _drawingState.updateMoveOperation(position);
    });
  }

  void _endMoveOperation(Offset position) {
    setState(() {
      _drawingState = _drawingState.endMoveOperation();
    });
  }

  void _startResizeOperation(String handle, Offset position) {
    setState(() {
      _drawingState = _drawingState.startResizeOperation(handle, position);
    });
  }

  void _updateResizeOperation(Offset position) {
    setState(() {
      _drawingState = _drawingState.updateResizeOperation(position);
    });
  }

  void _endResizeOperation(Offset position) {
    setState(() {
      _drawingState = _drawingState.endResizeOperation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: _handleKeyboardEvent,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(AppConstants.appTitle),
          actions: [
            ClearButton(
              onPressed: _clearDots,
              isEnabled: _drawingState.isNotEmpty,
            ),
          ],
        ),
        body: Column(
          children: [
            // Drawing mode toolbar
            DrawingModeToolbar(
              currentMode: _drawingState.drawingMode,
              onModeChanged: _changeDrawingMode,
            ),
            // Info panel
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InfoPanel(drawingState: _drawingState),
            ),
            // Canvas area
            Expanded(
              child: DotCanvas(
                drawingState: _drawingState,
                onDotAdded: _addDot,
                onRectangleCreationStart: _startRectangleCreation,
                onRectangleCreationUpdate: _updateRectangleCreation,
                onRectangleCreationEnd: _endRectangleCreation,
                onShapeSelected: _selectShape,
                onMoveStart: _startMoveOperation,
                onMoveUpdate: _updateMoveOperation,
                onMoveEnd: _endMoveOperation,
                onResizeStart: _startResizeOperation,
                onResizeUpdate: _updateResizeOperation,
                onResizeEnd: _endResizeOperation,
                canvasKey: _canvasKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
