import 'package:intl/intl.dart';
import 'package:test/test.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/post.dart';

void main() {
  group("create post", () {
    test("creating post from json", () {
      Post post = Post.fromJson({
        "_id": "54df54sd787sfrwe1w",
        "postType": "text",
        "state": "published",
        "publishedOn": 1522129071,
        "content": [
          {
            "type": "text",
            "subtype": "normal",
            "text": "Hello there from my super unit test :)",
            "formatting": [],
          }
        ],
        "tags": [],
        "blogAttribution": {
          "_id": "45df4d21fe48e7sa12d14",
          "title": "Passant",
          "handle": "Passant",
          "avatar":
              "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png",
          "isAvatarCircle": true,
        },
      });
      expect(post.blogAvatar,
          "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png");
      expect(post.id, "54df54sd787sfrwe1w");
      expect(post.postType, "text");
      expect(
          post.publishedOn,
          DateFormat('yyyy-MM-dd hh:mm').parse(
              DateTime.fromMillisecondsSinceEpoch(1522129071 * 1000)
                  .toString()));
      expect(post.isFollowed, true);
      expect(post.isReblogged, false);
      expect(post.liked, false);
      expect(post.commentsCount, 0);
      expect(post.likesCount, 0);
      expect(post.reblogsCount, 0);

      // check content
      TextBlock textBlock = TextBlock.fromJson({
        "type": "text",
        "subtype": "normal",
        "text": "Hello there from my super unit test :)",
        "formatting": [],
      });

      expect(post.content.first.text, textBlock.text);
      expect(post.content.first.formattedText, textBlock.formattedText);
    });
    test("missing parameter _id", () {
      expect(
          () => Post.fromJson({
                "postType": "text",
                "state": "published",
                "publishedOn": 1522129071,
                "content": [
                  {
                    "type": "text",
                    "subtype": "normal",
                    "text": "Hello there from my super unit test :)",
                    "formatting": [],
                  }
                ],
                "tags": [],
                "blogAttribution": {
                  "_id": "45df4d21fe48e7sa12d14",
                  "title": "Passant",
                  "handle": "Passant",
                  "avatar":
                      "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png",
                  "isAvatarCircle": true,
                },
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required paramter "_id"')));
    });

    test("missing parameter postType", () {
      expect(
          () => Post.fromJson({
                "_id": "54df54sd787sfrwe1w",
                "state": "published",
                "publishedOn": 1522129071,
                "content": [
                  {
                    "type": "text",
                    "subtype": "normal",
                    "text": "Hello there from my super unit test :)",
                    "formatting": [],
                  }
                ],
                "tags": [],
                "blogAttribution": {
                  "_id": "45df4d21fe48e7sa12d14",
                  "title": "Passant",
                  "handle": "Passant",
                  "avatar":
                      "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png",
                  "isAvatarCircle": true,
                },
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required parameter "postType"')));
    });
    test("missing parameter state", () {
      expect(
          () => Post.fromJson({
                "_id": "54df54sd787sfrwe1w",
                "postType": "text",
                "publishedOn": 1522129071,
                "content": [
                  {
                    "type": "text",
                    "subtype": "normal",
                    "text": "Hello there from my super unit test :)",
                    "formatting": [],
                  }
                ],
                "tags": [],
                "blogAttribution": {
                  "_id": "45df4d21fe48e7sa12d14",
                  "title": "Passant",
                  "handle": "Passant",
                  "avatar":
                      "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png",
                  "isAvatarCircle": true,
                },
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required paramter "state"')));
    });
    test("missing parameter content", () {
      expect(
          () => Post.fromJson({
                "_id": "54df54sd787sfrwe1w",
                "postType": "text",
                "state": "published",
                "publishedOn": 1522129071,
                "tags": [],
                "blogAttribution": {
                  "_id": "45df4d21fe48e7sa12d14",
                  "title": "Passant",
                  "handle": "Passant",
                  "avatar":
                      "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png",
                  "isAvatarCircle": true,
                },
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required paramter "content"')));
    });
    test("missing parameter blogAttribution", () {
      expect(
          () => Post.fromJson({
                "_id": "54df54sd787sfrwe1w",
                "postType": "text",
                "state": "published",
                "publishedOn": 1522129071,
                "content": [
                  {
                    "type": "text",
                    "subtype": "normal",
                    "text": "Hello there from my super unit test :)",
                    "formatting": [],
                  }
                ],
                "tags": [],
              }),
          throwsA(predicate((e) =>
              e.message == 'missing required paramter "blogAttribution"')));
    });
  });
}
