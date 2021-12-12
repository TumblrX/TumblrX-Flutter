import 'package:test/test.dart';
import 'package:tumblrx/models/posts/image_block.dart';

void main() {
  group("create image block", () {
    test("missing parameter type", () {
      expect(
          () => ImageBlock.fromJson({
                'media': {
                  "type": "image/jpeg",
                  "url": "https://www.youtube.com"
                }
              }),
          throwsA(predicate(
              (e) => e.message == 'missing reuiqred parameter "type"')));
    });

    test("missing parameter media", () {
      expect(
          () => ImageBlock.fromJson({'type': "image"}),
          throwsA(predicate(
              (e) => e.message == 'missing required paramter "media"')));
    });
  });
}
