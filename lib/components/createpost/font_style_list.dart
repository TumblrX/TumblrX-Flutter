import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/constants.dart';

import 'font_style_choice.dart';

class FontStyleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      actions: getChoicesList(),
      scrollable: true,
    );
  }

  List<Widget> getChoicesList() {
    List<Widget> fontStyleChoices = [];
    for (int i = 0; i < TextStyleType.values.length; i++) {
      fontStyleChoices.add(FontStyleChoice(type: TextStyleType.values[i]));
      if (i != TextStyleType.values.length - 1) {
        fontStyleChoices.add(
          Divider(
            thickness: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        );
      }
    }
    return fontStyleChoices;
  }
}
