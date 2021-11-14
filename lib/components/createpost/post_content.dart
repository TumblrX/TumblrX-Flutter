import 'package:flutter/material.dart';
import 'package:tumblrx/components/createpost/post_text_field.dart';
import 'package:tumblrx/models/text_field_data.dart';

class PostContent extends StatelessWidget {
  final List<TextFieldData> textFieldData;

  PostContent({this.textFieldData});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getPostContent(),
    );
  }

  List<Widget> getPostContent() {
    List<Widget> postContent = [];
    for (int i = 0; i < textFieldData.length; i++) {
      postContent.add(
        PostTextField(
          index: i,
          focus: textFieldData[i].focusNode,
          textStyle: textFieldData[i].textStyle,
          textEditingController: textFieldData[i].textEditingController,
        ),
      );
    }
    return postContent;
  }
}
