import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/chat_action_dialog.dart';
import 'package:tumblrx/components/chatting/chat_content.dart';
import 'package:tumblrx/components/chatting/chat_input.dart';
import 'package:tumblrx/services/messaging.dart';
import 'package:tumblrx/utilities/constants.dart';

///Chatting Screen Widget
class ChatScreen extends StatelessWidget {
  ChatScreen(
      {this.chatId,
      this.userId,
      this.myAvatarUrl,
      this.myUsername,
      this.receiverAvatarUrl,
      this.receiverUsername});

  ///Conversation id
  final String chatId;

  ///User Id
  final String userId;

  ///receiver blog Username
  final String receiverUsername;

  ///receiver avatar Url
  final String receiverAvatarUrl;

  ///sender avatar Url
  final String myAvatarUrl;

  ///sender blog Username
  final String myUsername;

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
                '$receiverUsername + $myUsername',
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
                  onSelected: (choice) {
                    if (choice == 'delete') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChatActionDialog(
                            title: 'Delete conversation',
                            content: 'Permanently delete this conversation?',
                            actionButton: 'Approve',
                            action: () =>
                                Provider.of<Messaging>(context, listen: false)
                                    .deleteConversation(context, userId),
                          );
                        },
                      );
                    } else if (choice == 'spam') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChatActionDialog(
                            title: 'Mark as spam?',
                            content:
                                '$receiverUsername will be blocked and reported. and any trace of this conversation will disappear from your inbox.',
                            actionButton: 'Mark it spam',
                            action: () =>
                                Provider.of<Messaging>(context, listen: false)
                                    .deleteConversation(
                                        context, userId), //to be changed
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChatActionDialog(
                            title:
                                'Are you sure you want to block $receiverUsername?',
                            content:
                                '$receiverUsername will be blocked and reported. and any trace of this conversation will disappear from your inbox.',
                            actionButton: 'Block',
                            action: () =>
                                Provider.of<Messaging>(context, listen: false)
                                    .deleteConversation(
                                        context, userId), //to be changed
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChatContent(
                    userId: userId,
                    chatId: chatId,
                    receiverAvatarUrl: receiverAvatarUrl,
                    receiverUsername: receiverUsername,
                    myUsername: myUsername,
                    myAvatarUrl: myAvatarUrl,
                  ),
                  Divider(),
                  ChatInput(
                    userId: userId,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
