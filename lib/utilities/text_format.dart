import 'package:flutter/material.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/tags/styled_text_tag_action.dart';
import 'package:styled_text/tags/styled_text_tag_base.dart';
import 'package:styled_text/tags/styled_text_tag_custom.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void _openLink(String url) async {
  url = Uri.encodeFull(url);
  if (await canLaunch(url)) await launch(url);
}

Map<String, StyledTextTagBase> formattingTags(
    {color = Colors.black, mentionCallback}) {
  return {
    'bold': StyledTextTag(style: kBiggerTextStyle),
    'italic': StyledTextTag(style: TextStyle(fontStyle: FontStyle.italic)),
    'link': StyledTextActionTag(
      (_, attrs) => _openLink(attrs['href']),
      style: TextStyle(decoration: TextDecoration.underline),
    ),
    'normal': StyledTextTag(style: kNormalTextStyle),
    'strikethrough':
        StyledTextTag(style: TextStyle(decoration: TextDecoration.lineThrough)),
    'heading1': StyledTextTag(style: kBiggerTextStyle),
    'heading2': StyledTextTag(style: kBiggestTextStyle),
    'quote': StyledTextTag(style: kQuoteTextStyle),
    'chat': StyledTextTag(style: kChatTextStyle),
    'quirky': StyledTextTag(style: kLucilleTextStyle),
    'color': StyledTextCustomTag(
      baseStyle: TextStyle(),
      parse: (baseStyle, attributes) {
        if (attributes.containsKey('text') &&
            attributes['text'].substring(0, 1) == '#' &&
            attributes['text'].length >= 6) {
          final String hexColor = attributes['text'].substring(1);
          final String alphaChannel =
              (hexColor.length == 8 ? hexColor.substring(6, 8) : 'FF');
          final Color color =
              Color(int.parse('0x$alphaChannel' + hexColor.substring(0, 6)));
          return baseStyle.copyWith(color: color);
        }
        return baseStyle;
      },
    ),
    'mention': StyledTextActionTag((_, attrs) => mentionCallback()),
  };
}
