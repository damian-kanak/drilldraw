import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'models/drawing_state.dart';
import 'models/drawing_mode.dart';
import 'services/keyboard_service.dart';
import 'widgets/clear_button.dart';
import 'widgets/dot_canvas.dart';
import 'widgets/info_panel.dart';
import 'widgets/drawing_mode_toolbar.dart';

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
    });
  }

  void _handleKeyboardEvent(KeyEvent event) {
    KeyboardService.handleKeyboardEvent(event, _clearDots, _changeDrawingMode);
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
                canvasKey: _canvasKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
