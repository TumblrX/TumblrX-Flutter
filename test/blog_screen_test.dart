import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/show_image.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

void main() {
  group('Blog screen test', () {
    test('length of returned item', () {
      String text = "11111111111111111111111111111111111111111111";
      String textLength = BlogScreenConstant.toLengthFifteen(text);
      expect(textLength.length, 18);
    });
    test('Show image class', () {
      final imageObject = ShowImage('images/avatar.dart');

      String image = imageObject.img;
      expect(image, 'images/avatar.dart');
    });

    test('test color to hex', () {
      Color x = hexToColor('#000000');
      expect(x, Color(0xff000000));
    });
    test('test hex to color', () {
      String x = colorToHexString(Color(0xff000000));
      expect(x, '#000000');
    });
  });
}
