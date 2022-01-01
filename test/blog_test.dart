import 'package:flutter_test/flutter_test.dart';
import 'package:tumblrx/models/user/blog.dart';

void main() {
  group('test blog', () {
    Blog blog = new Blog();
    test('test get title', () {
      blog.setBlogtitle('hello');
      expect('hello', blog.title);
    });
    test('test blog description', () {
      blog.setBlogDescription('i am happy ');
      expect('i am happy ', blog.description);
    });
    test('background color', () {
      blog.setBlogBackGroundColor('#000000');
      expect('#000000', blog.backGroundColor);
    });
    test('id blog', () {
      blog.setBlogId('1234569520');
      expect('1234569520', blog.id);
    });
    test('test show avatar', () {
      blog.setShowAvatar(true);
      expect(true, blog.showAvatar);
    });
  });
}
