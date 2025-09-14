import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/drawing_state.dart';

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
      label:
          '${AppConstants.instructionsText}. ${AppConstants.dotsPlacedText}${drawingState.dotCount}',
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
            Text(
              AppConstants.instructionsText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              '${AppConstants.dotsPlacedText}${drawingState.dotCount}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            if (drawingState.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                AppConstants.keyboardShortcutsHelp,
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
