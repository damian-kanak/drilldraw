import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// A clear button widget with accessibility features
class ClearButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;

  const ClearButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppConstants.clearButtonLabel,
      button: true,
      enabled: isEnabled,
      child: IconButton(
        onPressed: isEnabled ? onPressed : null,
        icon: const Icon(Icons.clear),
        tooltip: AppConstants.clearButtonTooltip,
        style: IconButton.styleFrom(
          backgroundColor: isEnabled
              ? Theme.of(context).colorScheme.errorContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          foregroundColor: isEnabled
              ? Theme.of(context).colorScheme.onErrorContainer
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
