import 'package:flutter/material.dart';

///Widget that inputs chat messages
class ChatInput extends StatelessWidget {
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
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Say your thing',
                ),
                onChanged: (value) {},
              ),
            ),
            IconButton(
              onPressed: () {},
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
