import 'package:test/test.dart';
import 'package:tumblrx/models/posts/block_poster.dart';

void main() {
  group("Creating poster block", () {
    test("missind required parameter type", () {
      expect(
          () => Poster.fromJson({'url': "https://google.com"}),
          throwsA(predicate(
              (e) => e.message == "missing required paramter 'type'")));
    });
    test("missind required parameter url", () {
      expect(
          () => Poster.fromJson({'type': "poster"}),
          throwsA(predicate(
              (e) => e.message == "missing required paramter 'url'")));
    });
    test("invalid parameter url", () {
      expect(() => Poster.fromJson({'type': "poster", "url": "http"}),
          throwsA(predicate((e) => e.message == "invalid url")));
    });
  });
}
