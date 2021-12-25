import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/components/chatting/new_conversation_tile.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/utilities/constants.dart';

///Shows suggested users for new conversation
class NewConversationScreen extends StatelessWidget {
  static String id = 'new_conversation_screen';
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
              title: Text(
                'To...',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ListView(
              children: ListTile.divideTiles(
                context: context,
                color: Colors.grey,
                tiles: [
                  NewConversationTile(
                    username: 'Taher2Bahsa',
                    userId: '61b26488c3616702bdca4d48',
                    userAvatar: ApiHttpRepository.api +
                        "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg",
                  ),
                  NewConversationTile(
                    username: 'Gamal',
                    userId: '61b47bd2bd13dd22af73bd86',
                    userAvatar: ApiHttpRepository.api +
                        "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg",
                  ),
                  NewConversationTile(
                    username: 'Example',
                    userId: '61b72b2fcf6c2aaab9a1e406',
                    userAvatar: ApiHttpRepository.api +
                        "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg",
                  ),
                ],
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
