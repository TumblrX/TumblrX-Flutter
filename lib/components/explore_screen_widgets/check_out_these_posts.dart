/*
  Description:
      this file creates a class that extends stateless widget to view
      posts inside explore screen
      list of posts to be viewed are passed to the constructor

 */

import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_blocks/image_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/text_block_widget.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/utilities/constants.dart';

class TryOutThesePosts extends StatelessWidget {
  final List<Post> _posts;
  TryOutThesePosts({Key key, @required List<Post> posts})
      : _posts = posts,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    int childrenCount = 0;
    // pick only posts that contains either text blocks or image block
    for (var post in _posts) {
      // pick only 9 posts to show
      if (childrenCount == 9) continue;
      // pick one block for each post
      bool pickedBlock = false;

      for (var block in post.content) {
        // get only posts with text/image blocks
        if (block.runtimeType == TextBlock || block.runtimeType == ImageBlock) {
          Widget child;
          // render blocks if they are text/image
          switch (block.runtimeType) {
            case TextBlock:
              child = TextBlockWidget(
                  text: block.formattedText, sharableText: block.text);
              break;
            case ImageBlock:
              child = ImageBlockWidget(media: block.media);
              break;
            default:
              break;
          }
          // check if child is set from previous check, or a block from this
          // post is already picked, skip
          if (child != null && !pickedBlock) {
            pickedBlock = true;
            childrenCount++;
            children.add(
              Material(
                color: Colors.white.withOpacity(0),
                child: InkWell(
                  enableFeedback: false,
                  onTap: () {
                    // Navigator.of(context).pushNamed('recommendations',
                    //    arguments: {'posts': _posts});
                  },
                  child: GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: .5),
                      ),
                      padding: EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width * .3,
                      child: child,
                    ),
                  ),
                ),
              ),
            );
          }
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        children.length > 0
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Try these posts',
                  style: kBiggerTextStyle.copyWith(color: Colors.white),
                ),
              )
            : Container(),
        GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          crossAxisCount: 3,
          children: children,
        ),
      ],
    );
  }
}
