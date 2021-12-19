/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for text block content in addition
    to inline class 'InlineFormatting' to handle inline formatting for
    the block content.
*/

import 'dart:collection';

import 'package:tumblrx/models/posts/inline_formatting.dart';

import 'dart:math';

class TextBlock {
  /// Subtype of the text: 'heading1', 'quote', 'heading2', 'chat',
  /// 'ordered-list-item', 'unordered-list-item'
  String _subtype;

  String _type;

  /// Text Block content
  String _text;

  String _formattedText;

  List<InlineFormatting> _renderingFormatting = [];

  ///Text block constructor that takes the [_subtype], [_text] and [_formatting]
  TextBlock(
      {String type,
      String subtype,
      String text,
      List<InlineFormatting> formatting})
      : _type = type,
        _subtype = subtype,
        _text = text,
        _formatting = formatting;

  /// Integer to nest the block
  //int _indentLevel = 0;

  /// List of Inline formatting applied on the text
  List<InlineFormatting> _formatting = [];

  String get formattedText => this._formattedText;
  String get text => this._text;

  /// Constructs a new instance usin parsed json data
  TextBlock.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type') && json['type'].toString().trim().isNotEmpty)
      this._type = json['type'];
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = _type;
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
    if (_subtype != null && _subtype.isNotEmpty) {
      _formattedText = '<$_subtype>$_formattedText</$_subtype>';
    }
    return _formattedText;
  }

  List<InlineFormatting> prepareFormattingList(
      List<InlineFormatting> parsedFormats) {
    if (parsedFormats.isEmpty) return parsedFormats;
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
}
