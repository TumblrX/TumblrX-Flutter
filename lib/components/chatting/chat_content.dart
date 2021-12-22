import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/message_bubble.dart';
import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/services/messaging.dart';

///Widget that shows the content of the chat
class ChatContent extends StatelessWidget {
  ChatContent(
      {this.userId,
      this.chatId,
      this.myAvatarUrl,
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

  ///Conversation id
  final String chatId;

  ///user Id
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
          Divider(
            thickness: 1.5,
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<Messaging>(context, listen: false)
                  .getChatContent(context, chatId, userId),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.connectionState == ConnectionState.done) {
                  return ListView(
                    reverse: true,
                    children: getMessages(context),
                  );
                } else {
                  return Center(
                    child: SpinKitDoubleBounce(
                      color: Colors.lightBlue,
                      size: 50.0,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getMessages(BuildContext context) {
    List<Widget> messagesList = [];

    for (int i = 0;
        i < Provider.of<Messaging>(context).getChatMessages(chatId).length;
        i++) {
      ChatMessage chatMessage =
          Provider.of<Messaging>(context).getChatMessages(chatId)[i];
      bool isPreviousSame = false;
      if (i != 0 &&
          Provider.of<Messaging>(context).getChatMessages(chatId)[i - 1].isMe ==
              Provider.of<Messaging>(context).getChatMessages(chatId)[i].isMe) {
        isPreviousSame = true;
      }
      messagesList.add(MessageBubble(
        text: chatMessage.text,
        senderAvatar: chatMessage.isMe ? myAvatarUrl : receiverAvatarUrl,
        isMe: chatMessage.isMe,
        sender: chatMessage.isMe ? myUsername : receiverUsername,
        isPreviousSame: isPreviousSame,
      ));
    }
    return messagesList.reversed.toList();
  }
}
