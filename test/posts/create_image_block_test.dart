import 'package:test/test.dart';
import 'package:tumblrx/models/posts/image_block.dart';

void main() {
  group("create image block", () {
    test("creating image block with normal constructor", () {
      ImageBlock imageBlock = ImageBlock(
        type: "image",
        media: "image/jpeg",
        url:
            "https://i.pinimg.com/236x/f2/e0/3e/f2e03e62272219b903af8c8e5e1ab7e9.jpg",
        width: 100,
        height: 100,
      );

      expect(imageBlock.type, "image");
      expect(imageBlock.media, "image/jpeg");
      expect(imageBlock.url,
          "https://i.pinimg.com/236x/f2/e0/3e/f2e03e62272219b903af8c8e5e1ab7e9.jpg");
      expect(imageBlock.width, 100);
      expect(imageBlock.height, 100);
    });
    test("creating image blockfrom json", () {
      ImageBlock imageBlock = ImageBlock.fromJson({
        "type": "image",
        "media": "image/jpeg",
        "url":
            "https://i.pinimg.com/236x/f2/e0/3e/f2e03e62272219b903af8c8e5e1ab7e9.jpg",
        "width": 100.0,
        "height": 100.0,
      });

      expect(imageBlock.type, "image");
      expect(imageBlock.media, "image/jpeg");
      expect(imageBlock.url,
          "https://i.pinimg.com/236x/f2/e0/3e/f2e03e62272219b903af8c8e5e1ab7e9.jpg");
      expect(imageBlock.width, 100);
      expect(imageBlock.height, 100);
    });
    test("missing parameter type", () {
      expect(
          () => ImageBlock.fromJson(
              {'media': "image/jpeg", "url": "https://www.youtube.com"}),
          throwsA(predicate(
              (e) => e.message == 'missing reuiqred parameter "type"')));
    });

    test("missing parameter url", () {
      expect(
          () => ImageBlock.fromJson({'media': "image/jpeg", "type": "image"}),
          throwsA(predicate(
              (e) => e.message == 'missing required paramter "url"')));
    });
    test("empty url", () {
      expect(
          () => ImageBlock.fromJson(
              {'media': "image/jpeg", "type": "image", "url": ""}),
          throwsA(predicate(
              (e) => e.message == 'missing required paramter "url"')));
    });

    test("set non positive image width with default value", () {
      ImageBlock imageBlock = ImageBlock.fromJson({
        "type": "image",
        "media": "image/jpeg",
        "url":
            "https://i.pinimg.com/236x/f2/e0/3e/f2e03e62272219b903af8c8e5e1ab7e9.jpg",
        "width": -100.0,
        "height": 100.0,
      });
      expect(imageBlock.width, 512);
    });

    test("convert image object to json", () {
      ImageBlock imageBlock = ImageBlock.fromJson({
        "type": "image",
        "media": "image/jpeg",
        "url":
            "https://i.pinimg.com/236x/f2/e0/3e/f2e03e62272219b903af8c8e5e1ab7e9.jpg",
        "width": -100.0,
        "height": 100.0,
      });
      Map<String, dynamic> json = imageBlock.toJson();
      expect(json['width'], 512);
      expect(json['height'], 100);
      expect(json['type'], "image");
      expect(json['media'], "image/jpeg");
      expect(json['url'],
          "https://i.pinimg.com/236x/f2/e0/3e/f2e03e62272219b903af8c8e5e1ab7e9.jpg");
    });
  });
}
