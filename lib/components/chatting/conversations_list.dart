import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/chatting/conversation.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/messaging.dart';

import 'conversation_item.dart';

///Conversations List View Widget
class ConversationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        color: Colors.grey,
        tiles: getConversationList(context),
      ).toList(),
    );
  }

  List<ConversationItem> getConversationList(BuildContext context) {
    List<ConversationItem> conversationList = [];
    for (Conversation conversation
        in Provider.of<Messaging>(context).conversations) {
      conversationList.add(ConversationItem(
        id: conversation.id,
        avatarUrl: conversation.avatarUrl,
        username: conversation.username,
      ));
    }
    return conversationList;
  }
}
