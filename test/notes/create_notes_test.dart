import 'package:test/test.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/notes.dart';
import 'package:tumblrx/models/posts/text_block.dart';

void main() {
  group("create note", () {
    test("creating note from json", () {
      Notes note = Notes.fromJson({
        "type": "comment",
        "commentText": "My super comment :)",
        "blogId": "df4g6fd87gds5f5d1fds",
      });

      expect(note.commentText, "My super comment :)");
      expect(note.type, "comment");
      expect(note.blogData, "My super comment :)");
    });
    test("missing parameter type", () {
      expect(
          () => TextBlock.fromJson({
                "subtype": "normal",
                "text": "Hello there from my super unit test :)",
                "formatting": [],
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required parameter "type"')));
    });

    test("missing parameter text", () {
      expect(
          () => TextBlock.fromJson({
                "type": "text",
                "subtype": "normal",
                "formatting": [],
              }),
          throwsA(predicate(
              (e) => e.message == 'missing required parameter "text"')));
    });

    test("apply inline formatting", () {
      TextBlock textBlock = TextBlock.fromJson({
        "type": "text",
        "subtype": "normal",
        "text": "Hello there from my super unit test :)",
        "formatting": [
          {"start": 0, "end": 4, "type": "bold"},
          {"start": 0, "end": 4, "type": "italic"},
          {"start": 0, "end": 4, "type": "color", "hex": "#FF0000"},
        ],
      });
      expect(textBlock.formattedText,
          '<normal><bold><italic><color text="#FF0000">Hello</color></italic></bold> there from my super unit test :)</normal>');
    });
    test("overlapping inline text formatting ", () {
      TextBlock textBlock = TextBlock.fromJson({
        "type": "text",
        "subtype": "normal",
        "text": "Hello there from my super unit test :)",
        "formatting": [
          {"start": 6, "end": 10, "type": "italic"},
          {"start": 0, "end": 10, "type": "bold"},
        ],
      });
      logger.d(textBlock.formattedText);
      expect(textBlock.formattedText,
          '<normal><bold>Hello </bold><bold><italic>there</italic></bold> from my super unit test :)</normal>');
    });
  });
}
