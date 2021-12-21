import 'package:flutter/material.dart';
import 'package:tumblrx/components/chatting/message_bubble.dart';

///Widget that shows the content of the chat
class ChatContent extends StatelessWidget {
  ChatContent(
      {this.myAvatarUrl,
      this.myUsername,
      this.receiverAvatarUrl,
      this.receiverUsername});

  ///receiver blog Username
  final String receiverUsername;

  ///receiver avatar Url
  final String receiverAvatarUrl;

  ///sender avatar Url
  final String myAvatarUrl;

  ///sender blog Username
  final String myUsername;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          CircleAvatar(
            radius: 18.0,
            backgroundImage: NetworkImage(
              receiverAvatarUrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              receiverUsername,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MessageBubble(
            text: 'hellooo',
            senderAvatar: receiverAvatarUrl,
            isMe: false,
            sender: receiverUsername,
            isPreviousSame: false,
          ),
          MessageBubble(
            text: 'hellooo',
            senderAvatar: receiverAvatarUrl,
            isMe: false,
            sender: receiverUsername,
            isPreviousSame: true,
          ),
          MessageBubble(
            text: 'heyyyyyyyyyyy how are you',
            senderAvatar: myAvatarUrl,
            isMe: true,
            sender: myUsername,
            isPreviousSame: false,
          ),
          MessageBubble(
            text: 'heyyyyyyyyyyy how are you',
            senderAvatar: myAvatarUrl,
            isMe: true,
            sender: myUsername,
            isPreviousSame: true,
          ),
          MessageBubble(
            text: 'hellooo',
            senderAvatar: receiverAvatarUrl,
            isMe: false,
            sender: receiverUsername,
            isPreviousSame: false,
          ),
          MessageBubble(
            text: 'heyyyyyyyyyyy how are you',
            senderAvatar: myAvatarUrl,
            isMe: true,
            sender: myUsername,
            isPreviousSame: false,
          ),
        ],
      ),
    );
  }
}
