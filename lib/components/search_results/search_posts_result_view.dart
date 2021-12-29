import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_widget.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';

class PostView extends StatelessWidget {
  final List<Post> _posts;
  PostView({Key key, @required List<Post> posts})
      : _posts = posts,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _posts.length,
      // controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        Post post = _posts[index];
        try {
          return PostWidget(
            post: post,
          );
        } catch (err) {
          logger.e(err);
          return Container(
            child: Center(
              child: Icon(Icons.error),
            ),
          );
        }
      },
      separatorBuilder: (context, index) =>
          const Divider(height: 20.0, color: Colors.transparent),
    );
  }
}
