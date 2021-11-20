import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tumblrx/Components/blog_screen_constant.dart';
import 'package:tumblrx/Components/blog_screen_initial_screen/show_image.dart';

void main() {
  group('Blog screen test', () {
    test('length of returned item', () {
      String text = "125555555555555555555555555555";
      String textLength = Constant.toLengthFifteen(text);
      expect(textLength.length, 19);
    });
    test('Show image class', () {
      final imageObject = ShowImage('images/avatar.dart');

      String image = imageObject.img;
      expect(image, 'images/avatar.dart');
    });
  });
}
