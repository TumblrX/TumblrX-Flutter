import 'package:test/test.dart';
import 'package:tumblrx/models/posts/post.dart';

void main() {
  group("test handling response of get posts", () {
    test("missing blogAttribution", () {
      expect(
          () => Post.fromJson({
                "_id": "3507845453",
                "postType": "text",
                "date": "2011-02-25 20:27:00",
                "publishedOn": 1298665620,
                "state": "published",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "likesCount": 14,
                "commentsCount": 14,
                "reblogsCount": 14,
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
          throwsA(predicate((e) =>
              e.message == 'missing required paramter "blogAttribution"')));
    });

    test("missing _id", () {
      expect(
          () => Post.fromJson({
                "postType": "text",
                "date": "2011-02-25 20:27:00",
                "publishedOn": 1298665620,
                "state": "published",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "likesCount": 14,
                "commentsCount": 14,
                "reblogsCount": 14,
                "blogAttribution": {
                  "_id": "32154687sad54",
                  "title": "untitled",
                  "handle": "ammar",
                  "avatar": "none",
                  "isAvatarCircle": true
                },
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
              (e) => e.message == 'missing required paramter "_id"')));
    });

    test("missing publishedOn", () {
      expect(
          () => Post.fromJson({
                "_id": "2154878432",
                "postType": "text",
                "date": "2011-02-25 20:27:00",
                "state": "published",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "likesCount": 14,
                "commentsCount": 14,
                "reblogsCount": 14,
                "blogAttribution": {
                  "_id": "32154687sad54",
                  "title": "untitled",
                  "handle": "ammar",
                  "avatar": "none",
                  "isAvatarCircle": true
                },
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
              (e) => e.message == 'missing required paramter "publishedOn"')));
    });
    test("missing postType", () {
      expect(
          () => Post.fromJson({
                "_id": "3507845453",
                "publishedOn": 1298665620,
                "state": "published",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "likesCount": 14,
                "commentsCount": 14,
                "reblogsCount": 14,
                "blogAttribution": {
                  "_id": "32154687sad54",
                  "title": "untitled",
                  "handle": "ammar",
                  "avatar": "none",
                  "isAvatarCircle": true
                },
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
              (e) => e.message == 'missing required parameter "postType"')));
    });

    test("missing state", () {
      expect(
          () => Post.fromJson({
                "_id": "3507845453",
                "postType": "text",
                "date": "2011-02-25 20:27:00",
                "publishedOn": 1298665620,
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "likesCount": 14,
                "commentsCount": 14,
                "reblogsCount": 14,
                "blogAttribution": {
                  "_id": "32154687sad54",
                  "title": "untitled",
                  "handle": "ammar",
                  "avatar": "none",
                  "isAvatarCircle": true
                },
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
              (e) => e.message == 'missing required paramter "state"')));
    });

    test("missing content", () {
      expect(
          () => Post.fromJson({
                "_id": "3507845453",
                "postType": "text",
                "date": "2011-02-25 20:27:00",
                "publishedOn": 1298665620,
                "state": "published",
                "tags": ["tumblrize", "milky dog", "mini comic"],
                "likesCount": 14,
                "commentsCount": 14,
                "reblogsCount": 14,
                "blogAttribution": {
                  "_id": "32154687sad54",
                  "title": "untitled",
                  "handle": "ammar",
                  "avatar": "none",
                  "isAvatarCircle": true
                },
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required paramter "content"')));
    });
  });
}
