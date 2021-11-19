import 'package:flutter/material.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/tags/styled_text_tag_action.dart';
import 'package:styled_text/tags/styled_text_tag_base.dart';
import 'package:tumblrx/utilities/constants.dart';

Map<String, StyledTextTagBase> formattingTags(
    {color = Colors.black, openLink, mentionCallback}) {
  return {
    'bold': StyledTextTag(style: kBiggerTextStyle),
    'link': StyledTextActionTag(
      (_, attrs) => openLink(attrs),
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
