import 'package:flutter/material.dart';

enum PostOption { now, draft, private }
enum PostContentType { text, link, gif, image, video, music }

const TextStyle kNormalTextStyle = TextStyle();
const TextStyle kBiggerTextStyle = TextStyle(fontSize: 20.0);
const TextStyle kBiggestTextStyle = TextStyle(fontSize: 28.0);
const TextStyle kQuoteTextStyle =
    TextStyle(fontSize: 32.0, fontFamily: 'PTSerif');
const TextStyle kChatTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: 'SourceCodePro',
);
const TextStyle kLucilleTextStyle =
    TextStyle(fontSize: 36.0, fontFamily: 'GreatVibes');

enum TextStyleType { Normal, Bigger, Biggest, Quote, Chat, Lucille }

const Map<TextStyleType, TextStyle> kTextStyleMap = {
  TextStyleType.Normal: kNormalTextStyle,
  TextStyleType.Bigger: kBiggerTextStyle,
  TextStyleType.Biggest: kBiggestTextStyle,
  TextStyleType.Quote: kQuoteTextStyle,
  TextStyleType.Chat: kChatTextStyle,
  TextStyleType.Lucille: kLucilleTextStyle
};
