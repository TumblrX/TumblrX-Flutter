import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tumblrx/models/text_field_data.dart';
import 'package:tumblrx/utilities/constants.dart';

void main() {
  group('Text Field Data', () {
    test(
        'Text Type should start at Normal, Color at black, and other styles at false',
        () {
      expect(TextFieldData(TextStyleType.Normal).textStyleType,
          TextStyleType.Normal);
      expect(TextFieldData(TextStyleType.Normal).color, Colors.black);
      expect(TextFieldData(TextStyleType.Normal).isBold, false);
      expect(TextFieldData(TextStyleType.Normal).isItalic, false);
      expect(TextFieldData(TextStyleType.Normal).isLineThrough, false);
    });
    test(
        'Text Type should start at Normal, Color at black, and other styles at false',
        () {
      final textFieldData = TextFieldData(TextStyleType.Normal);
      textFieldData.setTextStyleType(TextStyleType.Chat);
      expect(textFieldData.textStyleType, TextStyleType.Chat);
    });
  });
}
