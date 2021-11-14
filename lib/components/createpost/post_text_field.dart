import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/post.dart';

import 'additional_style_options.dart';

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
          Provider.of<Post>(context, listen: false).removeTextField(index);
        }
      },
      child: GestureDetector(
        onDoubleTap: () {
          showModalBottomSheet(
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
            String curValue = textEditingController.value.text;
            int len = curValue.length;
            if (len > 0 && curValue[len - 1] == '\n') {
              textEditingController.text =
                  textEditingController.value.text.substring(0, len - 1);
            }
            Provider.of<Post>(context, listen: false).addTextField(index);
          },
          controller: textEditingController,
          style: textStyle,
          focusNode: focus,
          onChanged: (value) {
            if (value.length > 0 && value[value.length - 1] == '\n') {
              textEditingController.text = textEditingController.value.text
                  .substring(0, value.length - 1);
              Provider.of<Post>(context, listen: false).addTextField(index);
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
