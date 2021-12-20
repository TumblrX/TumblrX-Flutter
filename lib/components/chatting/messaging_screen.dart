import 'package:flutter/material.dart';
import 'conversations_list.dart';

///Messaging Screen view
class MessagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.maps_ugc),
      ),
      body: ConversationsList(),
    );
  }
}
