import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DrillDrawApp());
}

class DrillDrawApp extends StatelessWidget {
  const DrillDrawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DrillDraw',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  final List<Offset> dots = [];
  final GlobalKey _canvasKey = GlobalKey();
  final FocusNode _canvasFocusNode = FocusNode();

  void _addDot(Offset position) {
    setState(() {
      dots.add(position);
    });
  }

  void _clearDots() {
    setState(() {
      dots.clear();
    });
  }

  void _handleKeyboardEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      // Handle keyboard shortcuts
      if (event.logicalKey == LogicalKeyboardKey.keyC &&
          event.isControlPressed) {
        _clearDots();
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        _clearDots();
      }
    }
  }

  @override
  void dispose() {
    _canvasFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: _handleKeyboardEvent,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('DrillDraw'),
          actions: [
            Semantics(
              label: 'Clear all dots',
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _clearDots,
                tooltip: 'Clear all dots (Ctrl+C or Escape)',
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Info panel
            Semantics(
              container: true,
              label: 'Application status and instructions',
              child: Container(
                key: const ValueKey('info_panel'),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Column(
                  children: [
                    Semantics(
                      label: 'Instructions for using the application',
                      child: Text(
                        'Click anywhere on the canvas to place a dot',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Semantics(
                      label: 'Current number of dots placed',
                      liveRegion: true,
                      child: Text(
                        'Dots placed: ${dots.length}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Canvas area with RepaintBoundary for performance
            Expanded(
              child: RepaintBoundary(
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: Focus(
                    focusNode: _canvasFocusNode,
                    autofocus: true,
                    child: Semantics(
                      label:
                          'Drawing canvas. Click to place dots. ${dots.length} dots placed.',
                      hint:
                          'Interactive drawing area. Use mouse click or touch to place dots.',
                      child: GestureDetector(
                        key: const ValueKey('canvas_gesture_detector'),
                        onTapDown: (TapDownDetails details) {
                          final RenderBox renderBox = _canvasKey.currentContext!
                              .findRenderObject() as RenderBox;
                          final localPosition = renderBox.globalToLocal(
                            details.globalPosition,
                          );
                          _addDot(localPosition);
                        },
                        child: CustomPaint(
                          key: _canvasKey,
                          painter: DotPainter(dots),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DotPainter extends CustomPainter {
  final List<Offset> dots;

  const DotPainter(this.dots);

  @override
  void paint(Canvas canvas, Size size) {
    // Pre-create paint objects for better performance
    final dotPaint = Paint()
      ..color = Colors.deepPurple.shade700
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Draw all dots with optimized paint operations
    for (final dot in dots) {
      // Draw border first (larger circle)
      canvas.drawCircle(dot, 10.0, borderPaint);
      // Draw fill on top (smaller circle)
      canvas.drawCircle(dot, 8.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(DotPainter oldDelegate) {
    // More efficient comparison - check length first, then contents
    if (dots.length != oldDelegate.dots.length) {
      return true;
    }

    // Only do deep comparison if lengths match
    for (int i = 0; i < dots.length; i++) {
      if (dots[i] != oldDelegate.dots[i]) {
        return true;
      }
    }

    return false;
  }
}
