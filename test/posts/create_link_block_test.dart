import 'package:test/test.dart';
import 'package:tumblrx/models/posts/link_block.dart';

void main() {
  group("create link block", () {
    test("creating link block with normal constructor", () {
      LinkBlock linkBlock = LinkBlock(
        description: "video from youtube",
        title: "youtube",
        url: "https://www.youtube.com/watch?v=s_3ak-4u43E",
      );
      expect(linkBlock.url, "https://www.youtube.com/watch?v=s_3ak-4u43E");
      expect(linkBlock.description, "video from youtube");
    });
    test("creating link block from json", () {
      LinkBlock linkBlock = LinkBlock.fromJson({
        "type": "link",
        "url": "https://www.youtube.com/watch?v=s_3ak-4u43E",
        "title": "video",
        "description": "video from youtube",
      });

      expect(linkBlock.url, "https://www.youtube.com/watch?v=s_3ak-4u43E");
      expect(linkBlock.description, "video from youtube");
    });

    test("missing type parameter", () {
      expect(
          () => LinkBlock.fromJson({
                "url": "https://www.youtube.com/watch?v=s_3ak-4u43E",
                "title": "video",
                "description": "video from youtube",
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required parameter "type"')));
    });

    test("missing url parameter", () {
      expect(
          () => LinkBlock.fromJson({
                "type": "link",
                "title": "video",
                "description": "video from youtube",
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required parameter "url"')));
    });
  });
}
