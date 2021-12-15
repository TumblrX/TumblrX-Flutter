import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_footer/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/components/post/tags_widget.dart';

class PostWidget extends StatelessWidget {
  final List _postContent;
  final List<String> _tags;
  final int _index;
  PostWidget(
      {Key key,
      @required List postContent,
      @required List tags,
      @required int index})
      : _postContent = postContent,
        _tags = tags,
        _index = index,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(index: _index),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                _postContent.map<Widget>((block) => block.showBlock()).toList(),
          ),
          Divider(
            color: Colors.transparent,
          ),
          TagsWidget(_tags),
          Divider(
            color: Colors.transparent,
          ),
          PostFooter(postIndex: _index),
        ],
      ),
    );
  }
}
