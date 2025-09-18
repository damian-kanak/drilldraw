import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/drawing_state.dart';
import '../services/keyboard_service.dart';

/// Information panel that displays instructions and dot count
class InfoPanel extends StatelessWidget {
  final DrawingState drawingState;

  const InfoPanel({
    super.key,
    required this.drawingState,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '${AppConstants.instructionsText}. '
          '${AppConstants.shapesPlacedText}${drawingState.totalShapeCount}',
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Mode: ${drawingState.drawingMode.displayName}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                Text(
                  '(${drawingState.drawingMode.keyboardShortcut})',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              '${AppConstants.shapesPlacedText}${drawingState.totalShapeCount}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            if (drawingState.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                KeyboardService.getKeyboardHelpText(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
