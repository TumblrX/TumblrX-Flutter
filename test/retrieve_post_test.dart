import 'package:test/test.dart';
import 'package:tumblrx/models/post.dart';

void main() {
  group("test handling response of get posts", () {
    test("missing blog_name", () {
      expect(
          () => Post.fromJson({
                "id": 3507845453,
                "liked": false,
                "id_string": "3507845453",
                "post_url": "https://citriccomics.tumblr.com/post/3507845453",
                "type": "text",
                "date": "2011-02-25 20:27:00",
                "timestamp": 1298665620,
                "state": "published",
                "format": "html",
                "reblog_key": "b0baQtsl",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "note_count": 14,
                "content": [
                  {
                    "type": "text",
                    "text": "some bold and italic text",
                    "formatting": [
                      {"start": 5, "end": 9, "type": "bold"},
                      {"start": 14, "end": 20, "type": "italic"}
                    ]
                  },
                  {
                    "type": "image",
                    "media": [
                      {
                        "type": "image/jpeg",
                        "url":
                            "http://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_1280.jpg",
                        "width": 1280,
                        "height": 500
                      }
                    ]
                  }
                ]
              }),
          throwsA(predicate(
              (e) => e.message == "missing required paramter blog_name")));
    });

    test("missing id", () {
      expect(
          () => Post.fromJson({
                "blog_name": "citriccomics",
                "liked": false,
                "id_string": "3507845453",
                "post_url": "https://citriccomics.tumblr.com/post/3507845453",
                "type": "text",
                "date": "2011-02-25 20:27:00",
                "timestamp": 1298665620,
                "state": "published",
                "format": "html",
                "reblog_key": "b0baQtsl",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "note_count": 14,
                "content": [
                  {
                    "type": "text",
                    "text": "some bold and italic text",
                    "formatting": [
                      {"start": 5, "end": 9, "type": "bold"},
                      {"start": 14, "end": 20, "type": "italic"}
                    ]
                  },
                  {
                    "type": "image",
                    "media": [
                      {
                        "type": "image/jpeg",
                        "url":
                            "http://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_1280.jpg",
                        "width": 1280,
                        "height": 500
                      }
                    ]
                  }
                ]
              }),
          throwsA(
              predicate((e) => e.message == "missing required paramter id")));
    });

    test("missing date", () {
      expect(
          () => Post.fromJson({
                "blog_name": "citriccomics",
                "id": 3507845453,
                "liked": false,
                "id_string": "3507845453",
                "post_url": "https://citriccomics.tumblr.com/post/3507845453",
                "type": "text",
                "timestamp": 1298665620,
                "state": "published",
                "format": "html",
                "reblog_key": "b0baQtsl",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "note_count": 14,
                "content": [
                  {
                    "type": "text",
                    "text": "some bold and italic text",
                    "formatting": [
                      {"start": 5, "end": 9, "type": "bold"},
                      {"start": 14, "end": 20, "type": "italic"}
                    ]
                  },
                  {
                    "type": "image",
                    "media": [
                      {
                        "type": "image/jpeg",
                        "url":
                            "http://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_1280.jpg",
                        "width": 1280,
                        "height": 500
                      }
                    ]
                  }
                ]
              }),
          throwsA(
              predicate((e) => e.message == "missing required paramter date")));
    });

    test("missing reblog_key", () {
      expect(
          () => Post.fromJson({
                "blog_name": "citriccomics",
                "id": 3507845453,
                "liked": false,
                "date": "2011-02-25 20:27:00",
                "id_string": "3507845453",
                "post_url": "https://citriccomics.tumblr.com/post/3507845453",
                "type": "text",
                "timestamp": 1298665620,
                "state": "published",
                "format": "html",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "note_count": 14,
                "content": [
                  {
                    "type": "text",
                    "text": "some bold and italic text",
                    "formatting": [
                      {"start": 5, "end": 9, "type": "bold"},
                      {"start": 14, "end": 20, "type": "italic"}
                    ]
                  },
                  {
                    "type": "image",
                    "media": [
                      {
                        "type": "image/jpeg",
                        "url":
                            "http://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_1280.jpg",
                        "width": 1280,
                        "height": 500
                      }
                    ]
                  }
                ]
              }),
          throwsA(predicate(
              (e) => e.message == "missing required paramter reblog_key")));
    });

    test("missing liked", () {
      expect(
          () => Post.fromJson({
                "blog_name": "citriccomics",
                "id": 3507845453,
                "reblog_key": "b0baQtsl",
                "date": "2011-02-25 20:27:00",
                "id_string": "3507845453",
                "post_url": "https://citriccomics.tumblr.com/post/3507845453",
                "type": "text",
                "timestamp": 1298665620,
                "state": "published",
                "format": "html",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "note_count": 14,
                "content": [
                  {
                    "type": "text",
                    "text": "some bold and italic text",
                    "formatting": [
                      {"start": 5, "end": 9, "type": "bold"},
                      {"start": 14, "end": 20, "type": "italic"}
                    ]
                  },
                  {
                    "type": "image",
                    "media": [
                      {
                        "type": "image/jpeg",
                        "url":
                            "http://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_1280.jpg",
                        "width": 1280,
                        "height": 500
                      }
                    ]
                  }
                ]
              }),
          throwsA(predicate(
              (e) => e.message == "missing required paramter liked")));
    });

    test("missing state", () {
      expect(
          () => Post.fromJson({
                "blog_name": "citriccomics",
                "id": 3507845453,
                "liked": false,
                "reblog_key": "b0baQtsl",
                "date": "2011-02-25 20:27:00",
                "id_string": "3507845453",
                "post_url": "https://citriccomics.tumblr.com/post/3507845453",
                "type": "text",
                "timestamp": 1298665620,
                // "state": "published",
                "format": "html",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "note_count": 14,
                "content": [
                  {
                    "type": "text",
                    "text": "some bold and italic text",
                    "formatting": [
                      {"start": 5, "end": 9, "type": "bold"},
                      {"start": 14, "end": 20, "type": "italic"}
                    ]
                  },
                  {
                    "type": "image",
                    "media": [
                      {
                        "type": "image/jpeg",
                        "url":
                            "http://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_1280.jpg",
                        "width": 1280,
                        "height": 500
                      }
                    ]
                  }
                ]
              }),
          throwsA(predicate(
              (e) => e.message == "missing required paramter state")));
    });

    test("missing content", () {
      expect(
          () => Post.fromJson({
                "blog_name": "citriccomics",
                "id": 3507845453,
                "liked": false,
                "reblog_key": "b0baQtsl",
                "date": "2011-02-25 20:27:00",
                "id_string": "3507845453",
                "post_url": "https://citriccomics.tumblr.com/post/3507845453",
                "type": "text",
                "timestamp": 1298665620,
                "state": "published",
                "format": "html",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "note_count": 14
              }),
          throwsA(predicate(
              (e) => e.message == "missing required paramter content")));
    });
  });
}
