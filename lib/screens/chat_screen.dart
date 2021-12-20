import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/utilities/constants.dart';

///Chatting Screen Widget
class ChatScreen extends StatelessWidget {
  ///receiver blog Username
  final String receiverUsername;

  ///receiver avatar Url
  final String receiverAvatarUrl;

  ChatScreen({this.receiverUsername, this.receiverAvatarUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          constraints: !kIsWeb
              ? BoxConstraints()
              : BoxConstraints(
                  maxWidth: 750.0,
                  minWidth: MediaQuery.of(context).size.width < 750
                      ? MediaQuery.of(context).size.width * 0.9
                      : 750.0,
                ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                '${Provider.of<User>(context).getActiveBlogName()} + $receiverUsername',
                overflow: TextOverflow.fade,
              ),
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text('Delete conversation'),
                            value: 'delete',
                          ),
                          PopupMenuItem(
                            child: Text('Mark as spam'),
                            value: 'spam',
                          ),
                          PopupMenuItem(
                            child: Text('Block'),
                            value: 'block',
                          ),
                        ],
                    onSelected: (choice) {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
