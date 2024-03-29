import 'package:flutter/material.dart';

///Options of the post (Now, Draft, Private)
enum PostOption { published, draft, private }

///Types of post content elements
enum PostContentType { text, link, gif, image, video, music }

///Normal Text Style
const TextStyle kNormalTextStyle = TextStyle();

///Bigger Test Style Type
const TextStyle kBiggerTextStyle = TextStyle(fontSize: 20.0);

///Biggest Test Style Type
const TextStyle kBiggestTextStyle = TextStyle(fontSize: 28.0);

///Quote Test Style Type
const TextStyle kQuoteTextStyle =
    TextStyle(fontSize: 32.0, fontFamily: 'PTSerif');

///Chat Test Style Type
const TextStyle kChatTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: 'SourceCodePro',
);

///Lucille Test Style Type
const TextStyle kLucilleTextStyle =
    TextStyle(fontSize: 36.0, fontFamily: 'GreatVibes');

///Text Style Types
enum TextStyleType { Normal, Bigger, Biggest, Quote, Chat, Lucille }

///Mapping Style Types to its Style
const Map<TextStyleType, TextStyle> kTextStyleMap = {
  TextStyleType.Normal: kNormalTextStyle,
  TextStyleType.Bigger: kBiggerTextStyle,
  TextStyleType.Biggest: kBiggestTextStyle,
  TextStyleType.Quote: kQuoteTextStyle,
  TextStyleType.Chat: kChatTextStyle,
  TextStyleType.Lucille: kLucilleTextStyle
};

///Mapping Style Types from back-end from to creating post form
const Map<String, TextStyleType> kTextSubtypeMap = {
  'heading1': TextStyleType.Bigger,
  'heading2': TextStyleType.Biggest,
  'quote': TextStyleType.Quote,
  'chat': TextStyleType.Chat,
  'quirky': TextStyleType.Lucille
};

///Main color in the project
const kPrimaryColor = Color(0xFF001935);

///welcome screen title tumblrx
const KWelcomeScreenTitle = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 60.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

///for welcome screen signup login
const KWelcomeScreenButton = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

/// for age check page button
const KTextButton = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

///for age check page
const KHintTextForTextField = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 15.0,
  color: Color(0xff8C8C8C),
  fontWeight: FontWeight.bold,
);

/// bold text
const KHeadLines = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.bold);

/// bigger font size
const KHeadLines1 = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 30.0,
    color: Colors.white,
    fontWeight: FontWeight.bold);

///smaller text for pick tags screen
const KPickTagsInfoText = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 20.0,
    color: Colors.grey,
    fontWeight: FontWeight.bold);

///small text info
const KTextInfo = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 15.0,
  color: Color(0xff8C8C8C),
  fontWeight: FontWeight.bold,
);

///Fixes the subtype of text and map it from mobile view to general database view
Map<String, dynamic> kMapTextStyleToBackend(Map<String, dynamic> textBlock) {
  String subtype = textBlock['subtype'];
  if (subtype == 'normal') {
    textBlock.remove('subtype');
  } else if (subtype == 'bigger') {
    textBlock['subtype'] = 'heading1';
  } else if (subtype == 'biggest') {
    textBlock['subtype'] = 'heading2';
  } else if (subtype == 'lucille') {
    textBlock['subtype'] = 'quirky';
  }
  return textBlock;
}

void Function(BuildContext context, String message, Color color)
    showSnackBarMessage = (BuildContext context, String message, Color color) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: color,
        ));
