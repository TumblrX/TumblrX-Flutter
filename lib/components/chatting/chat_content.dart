import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/message_bubble.dart';
import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/messaging.dart';
import 'package:tumblrx/utilities/time_format_to_view.dart';

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
              receiverAvatarUrl.startsWith('http')
                  ? receiverAvatarUrl
                  : ApiHttpRepository.api + receiverAvatarUrl,
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
                  .getChatContent(userId),
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

  ///returns the list of chat messages
  List<Widget> getMessages(BuildContext context) {
    List<Widget> messagesList = [];

    for (int i = 0;
        i < Provider.of<Messaging>(context).getChatMessages(userId).length;
        i++) {
      ChatMessage chatMessage =
          Provider.of<Messaging>(context).getChatMessages(userId)[i];
      bool isPreviousSame = false;
      bool isPreviousTimeBig = true;
      if (i != 0) {
        if (Provider.of<Messaging>(context)
                .getChatMessages(userId)[i - 1]
                .isMe ==
            Provider.of<Messaging>(context).getChatMessages(userId)[i].isMe)
          isPreviousSame = true;
        isPreviousTimeBig = isDifferenceBiggerThanHalfAnHour(
            Provider.of<Messaging>(context)
                .getChatMessages(userId)[i - 1]
                .messageTime,
            Provider.of<Messaging>(context)
                .getChatMessages(userId)[i]
                .messageTime);
      }

      messagesList.add(MessageBubble(
        text: chatMessage.text,
        senderAvatar: chatMessage.isMe ? myAvatarUrl : receiverAvatarUrl,
        isMe: chatMessage.isMe,
        sender: chatMessage.isMe ? myUsername : receiverUsername,
        isPreviousSame: isPreviousSame,
        messageTime: chatMessage.messageTime,
        isPreviousTimeBig: isPreviousTimeBig,
      ));
    }
    return messagesList.reversed.toList();
  }
}
