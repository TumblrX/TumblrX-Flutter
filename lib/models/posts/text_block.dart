import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:tumblrx/utilities/text_format.dart';

class TextBlock {
  String _subtype;
  String _text;
  List<InlineFormatting> _formatting = [];

  TextBlock.fromJson(Map<String, dynamic> parsedJson) {
    this._text = parsedJson['text'];
    if (parsedJson.containsKey('subtype'))
      this._subtype = parsedJson['subtype'];
    if (parsedJson.containsKey('formatting') &&
        parsedJson['formatting'] != null) {
      this
          ._formatting
          .add(new InlineFormatting.fromJson(parsedJson['formatting']));
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['subtype'] = _subtype;
    data['text'] = _text;
    data['formatting'] = _formatting;
    return data;
  }

  String formatText() {
    for (var format in _formatting) {
      _text = format.applyFormat(_text);
    }
    return _text;
  }

  Widget showBlock() {
    _text = this.formatText();
    return StyledText(
      text: _text,
      tags: formattingTags(),
    );
  }
}

class InlineFormatting {
  int start;
  int end;
  String type;
  String url;
  String hex;
  String blogUrl;

  InlineFormatting({this.start, this.end, this.type});

  InlineFormatting.fromJson(Map<String, dynamic> parsedJson) {
    start = parsedJson['start'];
    end = parsedJson['end'];
    type = parsedJson['type'];
    if (parsedJson.containsKey('url')) url = parsedJson['url'];
    if (parsedJson.containsKey('hex')) url = parsedJson['hex'];

    if (parsedJson.containsKey('blog_url')) blogUrl = parsedJson['blog_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['start'] = start;
    data['end'] = end;
    data['type'] = type;
    if (hex != null) data['hex'] = hex;
    if (url != null) data['url'] = url;
    if (blogUrl != null) data['blog_url'] = blogUrl;

    return data;
  }

  String applyFormat(String text) {
    int start = this.start;
    int end = this.end + 1;

    String originalText = (end >= text.length
        ? text.substring(start)
        : text.substring(start, end));
    String formattedText;
    switch (type) {
      case 'bold':
        formattedText = "<bold>$originalText</bold> ";
        break;
      case 'strikethrough':
        formattedText = " <strikethrough>$originalText</strikethrough> ";
        break;
      case 'link':
        formattedText = " <link href=${this.url}>$originalText</link> ";
        break;
      case 'color':
        formattedText = " <color text=\"${this.hex}\">$originalText</color> ";
        break;
      case 'mention': // "uuid": , "name": , "url":
        formattedText =
            " <mention href=${this.blogUrl}>$originalText</mention> ";
        break;
      default:
        formattedText = originalText;
    }
    return text.replaceAll(originalText, formattedText);
  }
}
