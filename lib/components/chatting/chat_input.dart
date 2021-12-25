import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/messaging.dart';

///Widget that inputs chat messages
class ChatInput extends StatelessWidget {
  ///user id
  final String userId;

  ///Text Field controller to keep track of entered text
  final TextEditingController _textEditingController = TextEditingController();

  ///to keep track of focus on text field
  final FocusNode _focusNode = FocusNode();

  ChatInput({this.userId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              child: Icon(
                Icons.gif,
                size: 30.0,
                color: Colors.lightBlue,
              ),
              onTap: () {},
            ),
            SizedBox(
              width: 7.0,
            ),
            InkWell(
              child: Icon(
                Icons.camera_alt,
                size: 30.0,
                color: Colors.lightBlue,
              ),
              onTap: () {},
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _textEditingController,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Say your thing',
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (_textEditingController.text.trim().length > 0)
                  Provider.of<Messaging>(context, listen: false).sendMessage(
                      userId, _textEditingController.text, context);
                _textEditingController.text = '';
                _focusNode.requestFocus();
              },
              icon: Icon(
                Icons.send,
                color: Colors.lightBlue,
              ),
            )
          ],
        ),
      ],
    );
  }
}
