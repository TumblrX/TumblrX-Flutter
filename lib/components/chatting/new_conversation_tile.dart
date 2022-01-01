import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/square_avatar.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/chat_screen.dart';

///Widget that appears in new conversation screen for each user suggested
class NewConversationTile extends StatelessWidget {
  ///The user id of the conversation
  final String userId;

  ///username of the target conversation
  final String username;

  ///Avatar url of the target user conversation
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
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              userId: userId,
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
