import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/square_avatar.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/chat_screen.dart';

///Conversation Item in the conversations list
class ConversationItem extends StatelessWidget {
  ///avatar url for the conversation user
  final String avatarUrl;

  ///username for the conversation user
  final String username;

  ///Conversation id
  final String chatId;

  ///user id
  final String userId;

  ///last sent message
  final String lastMessage;

  ///if the sender pf the last message is me
  final bool lastMessageIsMe;

  ConversationItem(
      {this.chatId,
      this.userId,
      this.avatarUrl,
      this.username,
      this.lastMessage,
      this.lastMessageIsMe});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              userId: userId,
              chatId: chatId,
              receiverUsername: username,
              receiverAvatarUrl: avatarUrl,
              myAvatarUrl: Provider.of<User>(context).getPrimaryBlogAvatar(),
              myUsername: Provider.of<User>(context).username,
            ),
          ),
        );
      },
      leading: SquareAvatar(avatarUrl: avatarUrl),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${lastMessageIsMe ? Provider.of<User>(context, listen: false).username : username}: $lastMessage',
            maxLines: 2,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text('Active in the last 3 hours'),
      ),
    );
  }
}
