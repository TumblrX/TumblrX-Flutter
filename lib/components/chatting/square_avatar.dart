import 'package:flutter/material.dart';
import 'package:tumblrx/services/api_provider.dart';

///Square avatar shape for chatting users
class SquareAvatar extends StatelessWidget {
  SquareAvatar({
    this.avatarUrl,
  });

  ///avatar url
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        avatarUrl,
        height: 40.0,
        width: 40.0,
        errorBuilder: (context, error, stackTrace) {
          return Image.network(
              'https://assets.tumblr.com/images/default_avatar/cube_open_128.png',
              height: 40.0,
              width: 40.0,
              fit: BoxFit.fill);
        },
        fit: BoxFit.fill,
      ),
    );
  }
}
