import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/square_avatar.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/chat_screen.dart';
import 'package:tumblrx/utilities/time_format_to_view.dart';

///Conversation Item in the conversations list shows the avatar and username of the user.
///It also shows the last message sent, and the time of it.
///On click on this item it opens the chat screen with this user
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

  ///Time of the last sent message
  final String lastMessageTime;

  ConversationItem(
      {this.chatId,
      this.userId,
      this.avatarUrl,
      this.username,
      this.lastMessage,
      this.lastMessageIsMe,
      this.lastMessageTime});

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
        child: Text(changeTimeFormat(lastMessageTime)),
      ),
    );
  }
}
