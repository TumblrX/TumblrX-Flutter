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

//welcome screen title tumblrx
const KWelcomeScreenTitle = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 60.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

//for welcome screen signup login
const KWelcomeScreenButton = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
// for age check page button
const KTextButton = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 20.0,
  color: Colors.cyan,
  fontWeight: FontWeight.bold,
);

//for age check page
const KHintTextForTextField = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 15.0,
  color: Color(0xff8C8C8C),
  fontWeight: FontWeight.bold,
);

//for the age check page
const KTextFieldDecoration = const InputDecoration(
  border: UnderlineInputBorder(),
  labelText: 'How old are you?',
  labelStyle: KHintTextForTextField,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  ),
);
// bold text
const KHeadLines = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.bold);
// bigger font size
const KHeadLines1 = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 30.0,
    color: Colors.white,
    fontWeight: FontWeight.bold);
//smaller text for pick tags screen
const KPickTagsInfoText = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold);

final List<String> reactionIcons = [
  "assets/icon/message.png",
  "assets/icon/repeat.png",
  "assets/icon/love.png"
];
