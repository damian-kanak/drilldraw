import 'package:flutter/material.dart';
import '../models/drawing_mode.dart';

/// A button widget for selecting drawing modes
class DrawingModeButton extends StatelessWidget {
  final DrawingMode mode;
  final bool isSelected;
  final VoidCallback onPressed;

  const DrawingModeButton({
    super.key,
    required this.mode,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Tooltip(
      message: '${mode.displayName} Mode (${mode.keyboardShortcut})\n'
          '${mode.description}',
      preferBelow: false,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? colorScheme.primary : colorScheme.surface,
          foregroundColor:
              isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          side: BorderSide(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2.0 : 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIconData(mode.iconName),
              size: 20.0,
            ),
            const SizedBox(height: 4.0),
            Text(
              mode.displayName,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              mode.keyboardShortcut,
              style: TextStyle(
                fontSize: 10.0,
                color: isSelected
                    ? colorScheme.onPrimary.withValues(alpha: 0.7)
                    : colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Converts icon name string to IconData
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'radio_button_unchecked':
        return Icons.radio_button_unchecked;
      case 'crop_square':
        return Icons.crop_square;
      case 'open_with':
        return Icons.open_with;
      case 'trending_flat':
        return Icons.trending_flat;
      default:
        return Icons.help_outline;
    }
  }
}
