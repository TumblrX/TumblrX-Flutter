/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for text block content in addition
    to inline class 'InlineFormatting' to handle inline formatting for
    the block content.
*/

import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:tumblrx/utilities/text_format.dart';

class TextBlock {
  /// Subtype of the text: 'heading1', 'quote', 'heading2', 'chat',
  /// 'ordered-list-item', 'unordered-list-item'
  String _subtype;

  /// Text Block content
  String _text;

  ///Text block constructor that takes the [_subtype], [_text] and [_formatting]
  TextBlock(this._subtype, this._text, this._formatting);

  /// Integer to nest the block
  //int _indentLevel = 0;

  /// List of Inline formatting applied on the text
  List<InlineFormatting> _formatting = [];

  /// Constructs a new instance usin parsed json data
  TextBlock.fromJson(Map<String, dynamic> parsedJson) {
    this._text = parsedJson['text'];
    if (parsedJson.containsKey('subtype'))
      this._subtype = parsedJson['subtype'];
    if (parsedJson.containsKey('formatting') &&
        parsedJson['formatting'] != null) {
      List<Map<String, dynamic>> formatting =
          List<Map<String, dynamic>>.from(parsedJson['formatting']);

      this._formatting.addAll(
          formatting.map((e) => new InlineFormatting.fromJson(e)).toList());
    }
  }

  /// Returns a JSON version of the object
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

  void setHexColor(String hexValue) {
    hex = hexValue;
  }

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
      case 'italic':
        formattedText = "<italic>$originalText</italic> ";
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
