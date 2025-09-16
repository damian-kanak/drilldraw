/// Defines the different modes for drawing on the canvas
enum DrawingMode {
  /// Allows placing individual dots
  dot,

  /// Allows drawing rectangles
  rectangle,

  /// Allows selecting and manipulating existing shapes
  select,

  /// Allows drawing arrows between shapes
  arrow;

  /// Returns a user-friendly name for the drawing mode
  String get displayName {
    switch (this) {
      case DrawingMode.dot:
        return 'Dot';
      case DrawingMode.rectangle:
        return 'Rectangle';
      case DrawingMode.select:
        return 'Select';
      case DrawingMode.arrow:
        return 'Arrow';
    }
  }

  /// Returns true if the current mode allows creating new shapes
  bool get canCreateShapes {
    return this == DrawingMode.dot ||
        this == DrawingMode.rectangle ||
        this == DrawingMode.arrow;
  }

  /// Returns true if the current mode allows selecting existing shapes
  bool get canSelectShapes {
    return this == DrawingMode.select;
  }

  /// Returns the keyboard shortcut key for this mode
  String get keyboardShortcut {
    switch (this) {
      case DrawingMode.dot:
        return '1';
      case DrawingMode.rectangle:
        return '2';
      case DrawingMode.select:
        return '3';
      case DrawingMode.arrow:
        return '4';
    }
  }

  /// Returns a description/tooltip for this mode
  String get description {
    switch (this) {
      case DrawingMode.dot:
        return 'Place individual dots on the canvas';
      case DrawingMode.rectangle:
        return 'Draw rectangles by clicking and dragging';
      case DrawingMode.select:
        return 'Select and manipulate existing shapes';
      case DrawingMode.arrow:
        return 'Draw arrows between shapes';
    }
  }

  /// Returns the icon data for this mode
  String get iconName {
    switch (this) {
      case DrawingMode.dot:
        return 'radio_button_unchecked';
      case DrawingMode.rectangle:
        return 'crop_square';
      case DrawingMode.select:
        return 'open_with';
      case DrawingMode.arrow:
        return 'trending_flat';
    }
  }
}
