import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/dot_shape.dart';
import '../../lib/models/shape.dart';

void main() {
  group('DotShape Tests', () {
    late DotShape dotShape;

    setUp(() {
      dotShape = DotShape(
        id: 'dot-1',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 10.0,
      );
    });

    test('should have correct properties', () {
      expect(dotShape.id, 'dot-1');
      expect(dotShape.position, const Offset(100, 200));
      expect(dotShape.isSelected, false);
      expect(dotShape.hitTestRadius, 10.0);
    });

    test('should calculate bounds correctly', () {
      final expectedBounds = Rect.fromCircle(
        center: const Offset(100, 200),
        radius: 10.0,
      );
      expect(dotShape.bounds, expectedBounds);
    });

    test('should implement hitTest correctly', () {
      // Point at center - should hit
      expect(dotShape.hitTest(const Offset(100, 200)), isTrue);

      // Point within radius - should hit
      expect(dotShape.hitTest(const Offset(105, 200)), isTrue);
      expect(dotShape.hitTest(const Offset(100, 205)), isTrue);
      expect(
          dotShape.hitTest(const Offset(107, 207)), isTrue); // ~9.9px distance

      // Point exactly at radius - should hit
      expect(dotShape.hitTest(const Offset(110, 200)), isTrue);
      expect(dotShape.hitTest(const Offset(100, 210)), isTrue);

      // Point just outside radius - should not hit
      expect(dotShape.hitTest(const Offset(110.1, 200)), isFalse);
      expect(dotShape.hitTest(const Offset(100, 210.1)), isFalse);
      expect(dotShape.hitTest(const Offset(108, 208)),
          isFalse); // ~11.3px distance

      // Point far away - should not hit
      expect(dotShape.hitTest(const Offset(200, 300)), isFalse);
    });

    test('should implement copyWith correctly', () {
      final updatedShape = dotShape.copyWith(
        isSelected: true,
        position: const Offset(150, 250),
        hitTestRadius: 15.0,
      );

      expect(updatedShape.id, dotShape.id);
      expect(updatedShape.position, const Offset(150, 250));
      expect(updatedShape.isSelected, true);
      expect(updatedShape.hitTestRadius, 15.0);

      // Original unchanged
      expect(dotShape.position, const Offset(100, 200));
      expect(dotShape.isSelected, false);
      expect(dotShape.hitTestRadius, 10.0);
    });

    test('should implement copyWith with partial updates', () {
      final updatedShape = dotShape.copyWith(isSelected: true);

      expect(updatedShape.id, dotShape.id);
      expect(updatedShape.position, dotShape.position);
      expect(updatedShape.isSelected, true);
      expect(updatedShape.hitTestRadius, dotShape.hitTestRadius);
    });

    test('should implement equality correctly', () {
      final sameShape = DotShape(
        id: 'dot-1',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 10.0,
      );

      final differentId = DotShape(
        id: 'dot-2',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 10.0,
      );

      final differentPosition = DotShape(
        id: 'dot-1',
        position: const Offset(150, 250),
        isSelected: false,
        hitTestRadius: 10.0,
      );

      expect(dotShape, equals(sameShape));
      expect(dotShape, isNot(equals(differentId)));
      expect(dotShape, isNot(equals(differentPosition)));
    });

    test('should implement hashCode correctly', () {
      final sameShape = DotShape(
        id: 'dot-1',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 10.0,
      );

      final differentShape = DotShape(
        id: 'dot-2',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 10.0,
      );

      expect(dotShape.hashCode, equals(sameShape.hashCode));
      expect(dotShape.hashCode, isNot(equals(differentShape.hashCode)));
    });

    test('should implement toString correctly', () {
      final expectedString =
          'DotShape{id: dot-1, position: Offset(100.0, 200.0), isSelected: false, hitTestRadius: 10.0}';
      expect(dotShape.toString(), expectedString);
    });

    test('should be immutable', () {
      final originalId = dotShape.id;
      final originalPosition = dotShape.position;
      final originalIsSelected = dotShape.isSelected;
      final originalHitTestRadius = dotShape.hitTestRadius;

      // Attempting to modify should not affect original
      final updatedShape = dotShape.copyWith(
        isSelected: true,
        position: const Offset(150, 250),
      );

      expect(dotShape.id, originalId);
      expect(dotShape.position, originalPosition);
      expect(dotShape.isSelected, originalIsSelected);
      expect(dotShape.hitTestRadius, originalHitTestRadius);

      expect(updatedShape.id, originalId);
      expect(updatedShape.position, const Offset(150, 250));
      expect(updatedShape.isSelected, true);
      expect(updatedShape.hitTestRadius, originalHitTestRadius);
    });
  });

  group('DotShape Edge Cases', () {
    test('should handle zero radius', () {
      final zeroRadiusDot = DotShape(
        id: 'zero-dot',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 0.0,
      );

      // Only exact center should hit
      expect(zeroRadiusDot.hitTest(const Offset(100, 200)), isTrue);
      expect(zeroRadiusDot.hitTest(const Offset(100.1, 200)), isFalse);
      expect(zeroRadiusDot.hitTest(const Offset(100, 200.1)), isFalse);
    });

    test('should handle negative coordinates', () {
      final negativeDot = DotShape(
        id: 'negative-dot',
        position: const Offset(-100, -200),
        isSelected: false,
        hitTestRadius: 10.0,
      );

      expect(negativeDot.hitTest(const Offset(-100, -200)), isTrue);
      expect(negativeDot.hitTest(const Offset(-90, -200)), isTrue);
      expect(negativeDot.hitTest(const Offset(-110, -200)), isTrue);
      expect(negativeDot.hitTest(const Offset(-100, -190)), isTrue);
      expect(negativeDot.hitTest(const Offset(-100, -210)), isTrue);
      expect(negativeDot.hitTest(const Offset(-89, -200)), isFalse);
      expect(negativeDot.hitTest(const Offset(-111, -200)), isFalse);
    });

    test('should handle large hit test radius', () {
      final largeRadiusDot = DotShape(
        id: 'large-dot',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 100.0,
      );

      expect(largeRadiusDot.hitTest(const Offset(200, 200)), isTrue);
      expect(largeRadiusDot.hitTest(const Offset(100, 300)), isTrue);
      expect(largeRadiusDot.hitTest(const Offset(0, 200)), isTrue);
      expect(largeRadiusDot.hitTest(const Offset(100, 100)), isTrue);
      expect(largeRadiusDot.hitTest(const Offset(201, 200)), isFalse);
      expect(largeRadiusDot.hitTest(const Offset(100, 301)), isFalse);
    });

    test('should handle different hit test radii', () {
      final smallDot = DotShape(
        id: 'small-dot',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 5.0,
      );

      final largeDot = DotShape(
        id: 'large-dot',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 20.0,
      );

      final testPoint = const Offset(110, 200);

      expect(smallDot.hitTest(testPoint), isFalse); // 10px distance, radius 5px
      expect(largeDot.hitTest(testPoint), isTrue); // 10px distance, radius 20px

      final farPoint = const Offset(130, 200);
      expect(smallDot.hitTest(farPoint), isFalse); // 30px distance, radius 5px
      expect(largeDot.hitTest(farPoint), isFalse); // 30px distance, radius 20px
    });
  });

  group('DotShape Shape Interface Compliance', () {
    test('should implement all Shape interface methods', () {
      final dotShape = DotShape(
        id: 'test-dot',
        position: const Offset(100, 200),
        isSelected: false,
        hitTestRadius: 10.0,
      );

      // Test that it implements Shape interface
      expect(dotShape, isA<Shape>());

      // Test interface properties
      expect(dotShape.id, isA<String>());
      expect(dotShape.isSelected, isA<bool>());
      expect(dotShape.bounds, isA<Rect>());

      // Test interface methods
      expect(dotShape.hitTest(const Offset(100, 200)), isTrue);
      expect(dotShape.copyWith(isSelected: true), isA<Shape>());
    });

    test('should work with Shape collections', () {
      final shapes = <Shape>[
        DotShape(
          id: 'dot-1',
          position: const Offset(100, 200),
          isSelected: false,
          hitTestRadius: 10.0,
        ),
        DotShape(
          id: 'dot-2',
          position: const Offset(150, 250),
          isSelected: true,
          hitTestRadius: 15.0,
        ),
      ];

      expect(shapes.length, 2);
      expect(shapes[0].id, 'dot-1');
      expect(shapes[1].id, 'dot-2');
      expect(shapes[0].isSelected, false);
      expect(shapes[1].isSelected, true);
    });
  });
}
