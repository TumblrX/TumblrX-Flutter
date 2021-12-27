import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_content.dart';
import 'package:tumblrx/components/post/post_footer/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/models/posts/post.dart';

class PostWidget extends StatelessWidget {
  final List _postContent;
  final List<String> _tags;
  final List<Post> _trail;
  final int _index;
  PostWidget(
      {Key key,
      @required List postContent,
      @required int index,
      List tags,
      List trail})
      : _postContent = postContent,
        _index = index,
        _tags = tags == null ? [] : tags,
        _trail = trail == null ? [] : trail,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //final int len = post.trail.length;
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(index: _index),
          Divider(),
          PostContentView(postContent: _postContent, tags: _tags),
          Divider(
            color: Colors.transparent,
          ),
          PostFooter(postIndex: _index),
        ],
      ),
    );
  }
}
