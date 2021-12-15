import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/constants.dart';

class TextFieldData {
  TextEditingController textEditingController;
  FocusNode focusNode;
  TextStyle textStyle;
  bool isBold;
  bool isItalic;
  bool isLineThrough;
  Color color;
  TextStyleType textStyleType;

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

  void setTextStyleType(type) {
    textStyleType = type;
    updateTextStyle();
  }

  void updateTextStyle() {
    textStyle = kTextStyleMap[textStyleType].copyWith(
      color: color,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  void addText(String text) {
    textEditingController.text = text;
  }
}
