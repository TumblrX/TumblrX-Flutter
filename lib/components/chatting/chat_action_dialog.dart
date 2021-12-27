import 'package:flutter/material.dart';

///Alert Dialog widget that appears for different actions on chat Screen (Mark as spam for example)
class ChatActionDialog extends StatelessWidget {
  const ChatActionDialog({
    this.title,
    this.content,
    this.action,
    this.actionButton,
  });

  ///Dialog title
  final String title;

  ///Dialog content
  final String content;

  ///Callback function called on action
  final Function action;

  ///Action button text
  final String actionButton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              content,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Nevermind',
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(actionButton),
          onPressed: action,
        ),
      ],
    );
  }
}
