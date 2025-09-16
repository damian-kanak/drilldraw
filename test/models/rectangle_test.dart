import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drilldraw/models/rectangle.dart';

void main() {
  group('Rectangle Tests', () {
    final testRectangle = Rectangle(
      id: 'test_rect_1',
      bounds: const Rect.fromLTWH(10, 20, 100, 50),
      isSelected: false,
      createdAt: DateTime(2023, 1, 1),
    );

    test('Rectangle initialization', () {
      expect(testRectangle.id, 'test_rect_1');
      expect(testRectangle.bounds, const Rect.fromLTWH(10, 20, 100, 50));
      expect(testRectangle.isSelected, false);
      expect(testRectangle.createdAt, DateTime(2023, 1, 1));
    });

    test('Rectangle copyWith creates new instance with updated values', () {
      final updatedRectangle = testRectangle.copyWith(
        bounds: const Rect.fromLTWH(0, 0, 200, 100),
        isSelected: true,
      );

      expect(updatedRectangle.id, testRectangle.id);
      expect(updatedRectangle.bounds, const Rect.fromLTWH(0, 0, 200, 100));
      expect(updatedRectangle.isSelected, true);
      expect(updatedRectangle.createdAt, testRectangle.createdAt);
      expect(
          updatedRectangle, isNot(testRectangle)); // Should be a new instance
    });

    test('Rectangle copyWith without changes returns same instance', () {
      final sameRectangle = testRectangle.copyWith();
      expect(sameRectangle,
          testRectangle); // Should return the same instance for efficiency
    });

    test('Rectangle area calculation', () {
      expect(testRectangle.area, 5000); // 100 * 50
    });

    test('Rectangle containsPoint works correctly', () {
      expect(testRectangle.containsPoint(const Offset(60, 45)), true); // center
      expect(
          testRectangle.containsPoint(const Offset(10, 20)), true); // top-left
      expect(testRectangle.containsPoint(const Offset(109, 69)),
          true); // bottom-right (inside)
      expect(
          testRectangle.containsPoint(const Offset(5, 10)), false); // outside
      expect(
          testRectangle.containsPoint(const Offset(120, 80)), false); // outside
    });

    test('Rectangle intersects works correctly', () {
      final other1 = Rectangle(
        id: 'test_rect_2',
        bounds: const Rect.fromLTWH(50, 40, 100, 50),
        createdAt: DateTime(2023, 1, 1),
      ); // overlaps
      final other2 = Rectangle(
        id: 'test_rect_3',
        bounds: const Rect.fromLTWH(200, 200, 50, 50),
        createdAt: DateTime(2023, 1, 1),
      ); // no overlap

      expect(testRectangle.intersects(other1), true);
      expect(testRectangle.intersects(other2), false);
    });

    test('Rectangle equality and hashcode', () {
      final same = Rectangle(
        id: 'test_rect_1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: false,
        createdAt: DateTime(2023, 1, 1),
      );
      final different = Rectangle(
        id: 'test_rect_1',
        bounds: const Rect.fromLTWH(10, 20, 100, 50),
        isSelected: true, // different selection
        createdAt: DateTime(2023, 1, 1),
      );

      expect(testRectangle, same);
      expect(testRectangle, isNot(different));
      expect(testRectangle.hashCode, same.hashCode);
    });

    test('Rectangle toString includes key information', () {
      final str = testRectangle.toString();
      expect(str, contains('test_rect_1'));
      expect(str, contains('Rect.fromLTRB(10.0, 20.0, 110.0, 70.0)'));
      expect(str, contains('selected: false'));
      expect(str, contains('createdAt: 2023-01-01'));
    });
  });
}
