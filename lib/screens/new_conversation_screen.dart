import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/new_conversation_tile.dart';
import 'package:tumblrx/services/messaging.dart';
import 'package:tumblrx/utilities/constants.dart';

///Shows suggested users for new conversation
class NewConversationScreen extends StatelessWidget {
  static String id = 'new_conversation_screen';

  final TextEditingController _textEditingController = TextEditingController();
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
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              title: TextField(
                controller: _textEditingController,
                onChanged: (value) {
                  Provider.of<Messaging>(context, listen: false)
                      .searchSuggestedConversations(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'To...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            body: ListView(
              children: ListTile.divideTiles(
                context: context,
                color: Colors.grey,
                tiles: getNewConversationTiles(context),
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> getNewConversationTiles(BuildContext context) {
  List<Widget> conversationTiles = [];

  for (Map<String, String> conversation
      in Provider.of<Messaging>(context).suggestedConversations) {
    conversationTiles.add(NewConversationTile(
      userId: conversation['userId'],
      userAvatar: conversation['userAvatar'],
      username: conversation['username'],
    ));
  }

  return conversationTiles;
}
