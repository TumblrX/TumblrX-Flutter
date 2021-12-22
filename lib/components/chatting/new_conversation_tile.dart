import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/square_avatar.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/chat_screen.dart';
import 'package:tumblrx/services/messaging.dart';

class NewConversationTile extends StatelessWidget {
  final String userId;
  final String username;
  final String userAvatar;

  NewConversationTile({this.userId, this.username, this.userAvatar});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SquareAvatar(avatarUrl: userAvatar),
      title: Text(
        username,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () {
        String chatId =
            Provider.of<Messaging>(context, listen: false).getChatId(userId);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              userId: userId,
              chatId: chatId,
              receiverUsername: username,
              receiverAvatarUrl: userAvatar,
              myAvatarUrl: Provider.of<User>(context).getPrimaryBlogAvatar(),
              myUsername: Provider.of<User>(context).username,
            ),
          ),
        );
      },
    );
  }
}
