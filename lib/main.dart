import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('DrillDraw'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearDots,
            tooltip: 'Clear all dots',
          ),
        ],
      ),
      body: Column(
        children: [
          // Info panel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              children: [
                Text(
                  'Click anywhere on the canvas to place a dot',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Dots placed: ${dots.length}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          // Canvas area
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey[100],
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  final RenderBox renderBox =
                      _canvasKey.currentContext!.findRenderObject()
                          as RenderBox;
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
        ],
      ),
    );
  }
}

class DotPainter extends CustomPainter {
  final List<Offset> dots;

  DotPainter(this.dots);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill;

    for (final dot in dots) {
      canvas.drawCircle(dot, 8.0, paint);

      // Add a white border for better visibility
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(dot, 8.0, borderPaint);
    }
  }

  @override
  bool shouldRepaint(DotPainter oldDelegate) {
    return dots != oldDelegate.dots;
  }
}
