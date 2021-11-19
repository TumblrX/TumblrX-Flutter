import 'package:flutter/material.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/tags/styled_text_tag_action.dart';
import 'package:styled_text/tags/styled_text_tag_base.dart';
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
    'bigger': StyledTextTag(style: kBiggestTextStyle),
    'quote': StyledTextTag(style: kQuoteTextStyle),
    'chat': StyledTextTag(style: kChatTextStyle),
    'lucille': StyledTextTag(style: kLucilleTextStyle),
    'color': StyledTextTag(style: TextStyle(color: color)),
    'mention': StyledTextActionTag((_, attrs) => mentionCallback()),
  };
}
