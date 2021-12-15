/*
Author: Passant Abdeljalil
Description: 
    The post footer widget that contains reactions count and icons, and 
    post options: share, comment, reblog, and like/unlike, [edit, delete]
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_footer/options_widget.dart';
import 'package:tumblrx/components/post/post_footer/reactions_widget.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/content.dart';

class PostFooter extends StatelessWidget {
  final int _postIndex;

  PostFooter({@required int postIndex}) : _postIndex = postIndex;

  /// callback on tap notes icon/number
  void _showNotesPage() {}

  @override
  Widget build(BuildContext context) {
    // get active blog name to check the action icons view mode
    String activeBlogTitle =
        Provider.of<User>(context, listen: false).getActiveBlogTitle();
    // get the post object to access its data
    Post _post = Provider.of<Content>(context).posts[_postIndex];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReactionsWidget(
            showNotesPage: _showNotesPage,
            likesCount: _post.likesCount,
            commentCount: _post.commentsCount,
            reblogsCount: _post.reblogsCount,
          ),
          OptionsWidget(
            showNotesPage: _showNotesPage,
            activeBlogTitle: activeBlogTitle,
            post: _post,
            postIndex: _postIndex,
          ),
        ],
      ),
    );
  }
}
