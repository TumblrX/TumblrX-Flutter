import 'package:flutter/material.dart';
import 'package:tumblrx/screens/new_conversation_screen.dart';
import 'conversations_list.dart';

///Messaging Screen contains button to start a new conversation and conversations list
class MessagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewConversationScreen.id);
        },
        child: Icon(Icons.maps_ugc),
      ),
      body: ConversationsList(),
    );
  }
}
