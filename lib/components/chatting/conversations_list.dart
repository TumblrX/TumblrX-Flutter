import 'package:flutter/material.dart';
import 'package:tumblrx/services/api_provider.dart';

import 'conversation_item.dart';

///Conversations List View Widget
class ConversationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        color: Colors.grey,
        tiles: [
          ConversationItem(
            avatarUrl: ApiHttpRepository.api +
                "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg",
            username: 'ammmmmmmaaaarov',
          ),
        ],
      ).toList(),
    );
  }
}
