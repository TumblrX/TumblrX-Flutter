import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';

import 'additional_style_options.dart';

///Text Field Editor where the style can be updated.
///Pressing Enter or newline will add Additional TextField while Backspace will delete it.
class PostTextField extends StatelessWidget {
  final int index;
  final TextEditingController textEditingController;
  final TextStyle textStyle;
  final FocusNode focus;
  PostTextField(
      {this.index, this.textEditingController, this.textStyle, this.focus});

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.backspace) &&
            index != 0 &&
            focus.hasFocus &&
            textEditingController.value.text.length == 0) {
          Provider.of<CreatingPost>(context, listen: false)
              .removeTextField(index);
        }
        if (event.isKeyPressed(LogicalKeyboardKey.enter) &&
            event.isKeyPressed(LogicalKeyboardKey.shift)) {
          print('next line');
        }
      },
      child: GestureDetector(
        onDoubleTap: () {
          showModalBottomSheet(
            constraints:
                BoxConstraints(maxWidth: kIsWeb ? 500.0 : double.infinity),
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: AdditionalStyleOptions(
                index: index,
              ),
            ),
          );
        },
        child: TextField(
          textInputAction: TextInputAction.next,
          onSubmitted: (value) {
            Provider.of<CreatingPost>(context, listen: false)
                .addTextField(index);
          },
          controller: textEditingController,
          style: textStyle,
          focusNode: focus,
          onChanged: (value) {
            if (value.length > 0)
              Provider.of<CreatingPost>(context, listen: false).setIsEnabled();
            else {
              Provider.of<CreatingPost>(context, listen: false)
                  .checkPostEnable();
            }
            if (value.length > 0 && value[value.length - 1] == '\n') {
              textEditingController.text = textEditingController.value.text
                  .substring(0, value.length - 1);
              Provider.of<CreatingPost>(context, listen: false)
                  .addTextField(index);
            }
          },
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: index == 0 ? "Add something, if you'd like" : '',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
