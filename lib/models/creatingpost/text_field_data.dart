import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/constants.dart';

///Model that keeps the styling of each text field while creating post
class TextFieldData {
  ///Controller that contains the value of the text in the text field
  TextEditingController textEditingController;

  ///Focus node that keeps track of the focus of the text field
  FocusNode focusNode;

  ///Text Style widget that holds the styling of the text
  TextStyle textStyle;

  ///if the text is bold
  bool isBold;

  ///if the text is italic
  bool isItalic;

  ///if the text is linethrough(strikethrough)
  bool isLineThrough;

  ///Color of the text
  Color color;

  ///Text style type enum
  TextStyleType textStyleType;

  ///Model constructor assigns initial values
  TextFieldData(TextStyleType textType) {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    isBold = false;
    isItalic = false;
    isLineThrough = false;
    color = Colors.black;
    textStyleType = textType;
    updateTextStyle();
  }

  ///Function that sets the text style type
  void setTextStyleType(type) {
    textStyleType = type;
    updateTextStyle();
  }

  ///Function that updates the text style if there are changes
  void updateTextStyle() {
    textStyle = kTextStyleMap[textStyleType].copyWith(
      color: color,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  ///Adds text to the text controller
  void addText(String text) {
    textEditingController.text = text;
  }
}
