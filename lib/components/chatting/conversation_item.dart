import 'package:flutter/material.dart';
import 'package:tumblrx/screens/chat_screen.dart';

///Conversation Item in the conversations list
class ConversationItem extends StatelessWidget {
  ///avatar url for the conversation user
  final String avatarUrl;

  ///username for the conversation user
  final String username;

  ConversationItem({this.avatarUrl, this.username});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiverUsername: username,
              receiverAvatarUrl: avatarUrl,
            ),
          ),
        );
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          avatarUrl,
          height: 40.0,
          width: 40.0,
          fit: BoxFit.fill,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('ammar: heyyyy'),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text('Active in the last 3 hours'),
      ),
    );
  }
}
