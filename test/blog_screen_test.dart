import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/show_image.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';

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
    
    
  });
}
