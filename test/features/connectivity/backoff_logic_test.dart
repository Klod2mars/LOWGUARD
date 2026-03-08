import 'dart:math';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Backoff Logic Tests', () {
    test('Exponential backoff calculation', () {
      final retries = [0, 1, 2, 3, 4, 5, 6];
      final results = retries.map((retry) => min(pow(2, retry).toInt(), 60)).toList();
      
      expect(results[0], 1);
      expect(results[1], 2);
      expect(results[2], 4);
      expect(results[3], 8);
      expect(results[4], 16);
      expect(results[5], 32);
      expect(results[6], 60); // Capped at 60
    });

    test('Jitter inclusion simulation', () {
      final random = Random();
      const baseSeconds = 1;
      final delay = Duration(seconds: baseSeconds) + Duration(milliseconds: random.nextInt(1000));
      
      expect(delay.inMilliseconds, greaterThanOrEqualTo(1000));
      expect(delay.inMilliseconds, lessThan(2000));
    });
  });
}
