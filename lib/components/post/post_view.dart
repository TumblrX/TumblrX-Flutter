import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_footer.dart';

class PostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Post Content',
            style: TextStyle(height: 10.0),
          ),
          Divider(),
          PostFooter(),
        ],
      ),
    );
  }
}
