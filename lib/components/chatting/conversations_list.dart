import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/chatting/conversation.dart';
import 'package:tumblrx/services/messaging.dart';

import 'conversation_item.dart';

///Conversations List View Widget
class ConversationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Messaging>(context, listen: false)
          .getConversationsList(context),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.done) {
          return ListView(
            children: ListTile.divideTiles(
              context: context,
              color: Colors.grey,
              tiles: getConversationList(context),
            ).toList(),
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
    );
  }

  ///returns list of conversations
  List<ConversationItem> getConversationList(BuildContext context) {
    List<ConversationItem> conversationList = [];
    for (Conversation conversation
        in Provider.of<Messaging>(context).conversations) {
      conversationList.add(ConversationItem(
        userId: conversation.userId,
        chatId: conversation.chatId,
        avatarUrl: conversation.avatarUrl,
        username: conversation.username,
        lastMessage: conversation.lastMessage,
        lastMessageIsMe: conversation.lastMessageIsMe,
        lastMessageTime: conversation.lastMessageTime,
      ));
    }
    return conversationList;
  }
}
