import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/messaging.dart';

///Widget that inputs chat messages
class ChatInput extends StatelessWidget {
  ///Conversation id
  final String id;

  ChatInput({this.id});

  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
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
              onTap: () {
                Provider.of<Messaging>(context, listen: false)
                    .receiveMessage(id, _textEditingController.text);
                _textEditingController.text = '';
              },
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
                  Provider.of<Messaging>(context, listen: false)
                      .sendMessage(id, _textEditingController.text);
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
