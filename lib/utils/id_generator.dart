import 'package:uuid/uuid.dart';

/// A utility class for generating unique identifiers
class IdGenerator {
  static const Uuid _uuid = Uuid();

  /// Generates a new unique ID (UUID v4)
  static String generate() {
    return _uuid.v4();
  }
}
