/// Defines the different modes for drawing on the canvas
enum DrawingMode {
  /// Allows placing individual dots
  dot,

  /// Allows drawing rectangles
  rectangle,

  /// Allows selecting and manipulating existing shapes
  select;

  /// Returns a user-friendly name for the drawing mode
  String get displayName {
    switch (this) {
      case DrawingMode.dot:
        return 'Dot';
      case DrawingMode.rectangle:
        return 'Rectangle';
      case DrawingMode.select:
        return 'Select';
    }
  }

  /// Returns true if the current mode allows creating new shapes
  bool get canCreateShapes {
    return this == DrawingMode.dot || this == DrawingMode.rectangle;
  }

  /// Returns true if the current mode allows selecting existing shapes
  bool get canSelectShapes {
    return this == DrawingMode.select;
  }
}
