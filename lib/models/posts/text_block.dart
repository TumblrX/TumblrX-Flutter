/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for text block content in addition
    to inline class 'InlineFormatting' to handle inline formatting for
    the block content.
*/

import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:tumblrx/models/posts/post_block.dart';
import 'package:tumblrx/utilities/text_format.dart';

import 'dart:math';

class TextBlock extends PostBlock {
  /// Subtype of the text: 'heading1', 'quote', 'heading2', 'chat',
  /// 'ordered-list-item', 'unordered-list-item'
  String _subtype;

  /// Text Block content
  String _text;

  String _formattedText;

  List<InlineFormatting> _renderingFormatting = [];

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

    if (json.containsKey('text')) {
      this._text = json['text'];
      this._formattedText = json['text'];
    } else
      throw Exception('missing required parameter "text"');

    if (json.containsKey('subtype')) this._subtype = json['subtype'];

    if (json.containsKey('formatting') && json['formatting'] != null) {
      List<Map<String, dynamic>> formatting =
          List<Map<String, dynamic>>.from(json['formatting']);

      try {
        List<InlineFormatting> parsedFormats =
            formatting.map((e) => new InlineFormatting.fromJson(e)).toList();

        // sort list of formatting as a preprocessing step for rendering
        parsedFormats.sort((a, b) => a.compareTo(b));

        // store parsed formatting list
        this._formatting.addAll(parsedFormats);

        // prepare formatting intervals for viewing later
        _renderingFormatting = this.prepareFormattingList(parsedFormats);

        _formattedText = this.formatText();
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
    InlineFormatting prevFormat;
    int leftPadding, rightPadding = 0;
    int len = _renderingFormatting.length;
    if (len > 0) {
      List result = _renderingFormatting[len - 1].applyFormat(_formattedText);
      _formattedText = result[0];
      leftPadding = result[1];
      rightPadding = result[2];
      prevFormat = _renderingFormatting[len - 1];
    }
    for (int i = len - 2; i >= 0; i--) {
      InlineFormatting format = _renderingFormatting[i];

      if (format.start == prevFormat.start && format.end == prevFormat.end) {
        format.end += leftPadding + rightPadding;
      }
      List result = format.applyFormat(_formattedText);
      _formattedText = result[0];
      leftPadding = result[1];
      rightPadding = result[2];
      prevFormat = format;
    }
    return _formattedText;
  }

  List<InlineFormatting> prepareFormattingList(
      List<InlineFormatting> parsedFormats) {
    // variable to store the final result
    List<InlineFormatting> processedFormattingList = [];

    // insert first format
    processedFormattingList.add(parsedFormats[0]);

    for (int i = 1; i < parsedFormats.length; i++) {
      // previous inserted format
      InlineFormatting prevFormat = parsedFormats[i - 1];

      // current format
      InlineFormatting currentFormat = parsedFormats[i];

      // check for overlapping formats
      if (currentFormat.start < prevFormat.end) {
        // remove the last element to avoid redunduncy
        if (processedFormattingList.isNotEmpty)
          processedFormattingList.removeLast();

        // first interval with format = previous format
        if (prevFormat.start != currentFormat.start)
          processedFormattingList.add(InlineFormatting(
            start: prevFormat.start,
            end: currentFormat.start - 1,
            type: prevFormat.type,
            blogUrl: prevFormat.blogUrl,
            hex: prevFormat.hex,
            url: prevFormat.url,
          ));
        // second interval (overlapping area) with format = previous format
        processedFormattingList.add(InlineFormatting(
          start: currentFormat.start,
          end: min(prevFormat.end, currentFormat.end),
          type: prevFormat.type,
          blogUrl: prevFormat.blogUrl,
          hex: prevFormat.hex,
          url: prevFormat.url,
        ));
        // second interval (overlappig area) with format = current format
        processedFormattingList.add(InlineFormatting(
          start: currentFormat.start,
          end: min(prevFormat.end, currentFormat.end),
          type: currentFormat.type,
          blogUrl: currentFormat.blogUrl,
          hex: currentFormat.hex,
          url: currentFormat.url,
        ));
        // third interval with format = current format
        if (prevFormat.end != currentFormat.end)
          processedFormattingList.add(InlineFormatting(
            start: min(currentFormat.end, prevFormat.end) + 1,
            end: max(prevFormat.end, currentFormat.end),
            type: currentFormat.type,
            blogUrl: currentFormat.blogUrl,
            hex: currentFormat.hex,
            url: currentFormat.url,
          ));
      }
      // if no overlapping, insert the current format as it is
      else
        processedFormattingList.add(currentFormat);
    }
    // remove duplicates by constructing a sorted set with SplayTreeSet
    processedFormattingList = SplayTreeSet<InlineFormatting>.from(
        processedFormattingList, (a, b) => a.compareTo(b)).toList();

    // return final list of formattings
    return processedFormattingList;
  }

  /// API for text block object to render it
  @override
  Widget showBlock() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StyledText(
        text: _formattedText,
        tags: formattingTags(),
      ),
    );
  }
}

class InlineFormatting implements Comparable<InlineFormatting> {
  int start;
  int end;
  String type;
  String url;
  String hex;
  String blogUrl;

  InlineFormatting(
      {this.start, this.end, this.type, this.url, this.blogUrl, this.hex});

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

  List applyFormat(String text) {
    int start = this.start;
    int end = this.end + 1;

    int leftPadding, rightPadding = 0;
    String originalText = text.substring(start, end);
    String formattedText;
    switch (type) {
      case 'bold':
        formattedText = "<bold>$originalText</bold>";
        leftPadding = 6;
        rightPadding = 7;
        break;
      case 'italic':
        formattedText = "<italic>$originalText</italic>";
        leftPadding = 8;
        rightPadding = 9;
        break;
      case 'strikethrough':
        formattedText = "<strikethrough>$originalText</strikethrough>";
        leftPadding = 15;
        rightPadding = 16;
        break;
      case 'link':
        formattedText = "<link href=${this.url}>$originalText</link>";
        leftPadding = 11 + this.url.length;
        rightPadding = 7;
        break;
      case 'color':
        formattedText = '<color text="${this.hex}">$originalText</color>';
        leftPadding = 12 + this.hex.length;
        rightPadding = 8;
        break;
      case 'mention': // "uuid": , "name": , "url":
        formattedText = "<mention href=${this.blogUrl}>$originalText</mention>";
        leftPadding = 14 + this.blogUrl.length;
        rightPadding = 10;
        break;
      default:
        formattedText = originalText;
    }
    return [
      text.replaceAll(originalText, formattedText),
      leftPadding,
      rightPadding
    ];
  }

  @override
  int compareTo(InlineFormatting other) {
// case 0: both are applied on the same substring
    if (this.start == other.start &&
        this.end == other.end &&
        this.type == other.type) return 0;
    // case 1: a is applied on a substring that is after b's
    if (this.start < other.start) return -1;
    if (this.start > other.start) return 1;

    if (this.start == other.start) {
      // case 2: a should be the inner format [e.g [<b><a>text</a>restOfText</b>]
      if (this.end > other.end) return 1;

      // case 3: b should be the inner format [e.g [<a><b>text</b>restOfText</a>]
      return -1;
    }
    return 0;
  }
}
