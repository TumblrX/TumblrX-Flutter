/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for text block content in addition
    to inline class 'InlineFormatting' to handle inline formatting for
    the block content.
*/

import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:tumblrx/models/posts/post_block.dart';
import 'package:tumblrx/utilities/text_format.dart';

class TextBlock extends PostBlock {
  /// Subtype of the text: 'heading1', 'quote', 'heading2', 'chat',
  /// 'ordered-list-item', 'unordered-list-item'
  String _subtype;

  /// Text Block content
  String _text;

  //String _formattedText;

  ///Text block constructor that takes the [_subtype], [_text] and [_formatting]
  TextBlock(String type, this._subtype, this._text, this._formatting)
      : super.withType(type);

  /// Integer to nest the block
  //int _indentLevel = 0;

  /// List of Inline formatting applied on the text
  List<InlineFormatting> _formatting = [];

  /// Constructs a new instance usin parsed json data
  TextBlock.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type') && json['type'].toString().trim().isNotEmpty)
      super.type = json['type'];
    else
      throw Exception('missing required parameter "type"');

    if (json.containsKey('text'))
      this._text = json['text'];
    else
      throw Exception('missing required parameter "text"');

    if (json.containsKey('subtype')) this._subtype = json['subtype'];

    if (json.containsKey('formatting') && json['formatting'] != null) {
      List<Map<String, dynamic>> formatting =
          List<Map<String, dynamic>>.from(json['formatting']);

      try {
        List<InlineFormatting> parsedFormats =
            formatting.map((e) => new InlineFormatting.fromJson(e)).toList();
        parsedFormats.sort((a, b) {
          // case 0: both are applied on the same substring
          if (a.start == b.start && a.end == b.end) return 0;
          // case 1: a is applied on a substring that is after b's
          if (a.start > b.start) return -1;
          if (a.start < b.start) return 1;

          if (a.start == b.start) {
            // case 2: a should be the inner format [e.g [<b><a>text</a>restOfText</b>]
            if (a.end < b.end) return -1;

            // case 3: b should be the inner format [e.g [<a><b>text</b>restOfText</a>]
            return 1;
          }
          return 0;
        });
        this._formatting.addAll(parsedFormats);

        _text = this.formatText();
      } catch (err) {
        print('error in formatting $err');
      }
    }
  }

  /// Returns a JSON version of the object
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = 'text';
    data['subtype'] = _subtype;
    data['text'] = _text;
    data['formatting'] = _formatting;
    return data;
  }

  /// Apply inline formatting on the text if any
  String formatText() {
    for (var format in _formatting) {
      _text = format.applyFormat(_text);
    }
    return _text;
  }

  /// API for text block object to render it
  @override
  Widget showBlock() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StyledText(
        text: _text,
        tags: formattingTags(),
      ),
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

  @override
  String toString() {
    return 'start: $start, end: $end, type: $type';
  }

  void setHexColor(String hexValue) {
    hex = hexValue;
  }

  InlineFormatting.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson.containsKey('start'))
      this.start = parsedJson['start'];
    else
      throw Exception('missing required parameter "start"');
    if (parsedJson.containsKey('end'))
      this.end = parsedJson['end'];
    else
      throw Exception('missing required parameter "end"');
    if (parsedJson.containsKey('type'))
      this.type = parsedJson['type'];
    else
      throw Exception('missing required parameter "type"');

    if (parsedJson.containsKey('url')) this.url = parsedJson['url'];
    if (parsedJson.containsKey('hex')) this.hex = parsedJson['hex'];

    if (parsedJson.containsKey('blog_url'))
      this.blogUrl = parsedJson['blog_url'];
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

    String originalText = text.substring(start, end);
    String formattedText;
    switch (type) {
      case 'bold':
        formattedText = "<bold>$originalText</bold>";
        break;
      case 'italic':
        formattedText = "<italic>$originalText</italic>";
        break;
      case 'strikethrough':
        formattedText = "<strikethrough>$originalText</strikethrough>";
        break;
      case 'link':
        formattedText = "<link href=${this.url}>$originalText</link>";
        break;
      case 'color':
        print(this.hex);
        formattedText = '<color text="${this.hex}">$originalText</color>';
        break;
      case 'mention': // "uuid": , "name": , "url":
        formattedText = "<mention href=${this.blogUrl}>$originalText</mention>";
        break;
      default:
        formattedText = originalText;
    }
    return text.replaceAll(originalText, formattedText);
  }
}
