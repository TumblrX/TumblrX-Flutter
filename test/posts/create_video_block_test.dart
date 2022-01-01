import 'package:test/test.dart';
import 'package:tumblrx/models/posts/video_block.dart';

void main() {
  group("create video block", () {
    test("creating video block with normal constructor", () {
      VideoBlock videoBlock = VideoBlock(
        type: "video",
        media: "video",
        provider: "youtube",
        url: "https://www.youtube.com/watch?v=s_3ak-4u43E",
      );

      expect(videoBlock.type, "video");
      expect(videoBlock.url, "https://www.youtube.com/watch?v=s_3ak-4u43E");
      expect(videoBlock.provider, "youtube");
    });
    test("creating video block from json", () {
      VideoBlock videoBlock = VideoBlock.fromJson({
        "type": "video",
        "media": "video",
        "provider": "youtube",
        "url": "https://www.youtube.com/watch?v=s_3ak-4u43E",
      });

      expect(videoBlock.type, "video");
      expect(videoBlock.url, "https://www.youtube.com/watch?v=s_3ak-4u43E");
      expect(videoBlock.provider, "youtube");
    });
  });
}
