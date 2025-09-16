import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/utils/id_generator.dart';

void main() {
  group('IdGenerator Tests', () {
    test('generate produces unique IDs', () {
      final ids = <String>{};
      for (int i = 0; i < 1000; i++) {
        ids.add(IdGenerator.generate());
      }
      expect(ids.length, 1000);
    });

    test('generate produces valid UUID v4 format', () {
      final id = IdGenerator.generate();
      // Regex for UUID v4: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
      // where y is 8, 9, A, or B
      final uuidV4Regex = RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$');
      expect(uuidV4Regex.hasMatch(id), true);
    });
  });
}
