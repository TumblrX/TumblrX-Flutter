import 'package:tumblrx/utilities/time_format_to_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('testing time format change', () {
    test('timestamp should be converted normally', () {
      expect(changeTimeFormat('1999-11-21T15:47:33.371Z'),
          '1999 November 21, 17:47');
    });
    test('invalid format test should return empty string', () {
      expect(changeTimeFormat('invalid format'), '');
    });
  });
}
