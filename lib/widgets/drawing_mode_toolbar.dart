import 'package:flutter/material.dart';
import '../models/drawing_mode.dart';
import 'drawing_mode_button.dart';

/// A toolbar widget for selecting drawing modes
class DrawingModeToolbar extends StatelessWidget {
  final DrawingMode currentMode;
  final Function(DrawingMode) onModeChanged;

  const DrawingModeToolbar({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: DrawingMode.values.map((mode) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: DrawingModeButton(
              mode: mode,
              isSelected: mode == currentMode,
              onPressed: () => onModeChanged(mode),
            ),
          );
        }).toList(),
      ),
    );
  }
}
