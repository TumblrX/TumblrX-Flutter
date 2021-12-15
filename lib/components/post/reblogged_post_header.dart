import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RebloggedPostHeader extends StatelessWidget {
  RebloggedPostHeader({
    this.blogAvatar,
    this.blogTitle,
  });

  final String blogAvatar;
  final String blogTitle;
  final double avatarSize = 40;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            width: avatarSize,
            height: avatarSize,
            imageUrl: blogAvatar,
            placeholder: (context, url) => SizedBox(
              width: avatarSize,
              height: avatarSize,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              child: Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                  child: Text(
                    blogTitle,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
