/*
Author: Passant Abdelgalil
Description: 
    The post header widget that contains blog name, follow button,
    and options icon
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/services/content.dart';

class PostHeader extends StatelessWidget {
  /// blog object of the post
  final int _index;
  final bool _showOptionsIcon;
  PostHeader({@required int index, bool showOptionsIcon = true})
      : _index = index,
        _showOptionsIcon = showOptionsIcon;

  /// navigate to the blog screen to view blog info
  void _showBlog(BuildContext context) {
    Navigator.of(context).pushNamed('blog_screen');
  }

  /// callback to open a dialog with blog options
  void _showBlogOptions() {}

  Widget _errorAvatar() => CircleAvatar(
        child: Icon(Icons.error),
      );

  Widget _emptyContainer() => Container(
        width: 0,
        height: 0,
      );
  @override
  Widget build(BuildContext context) {
    // constants to size widgets
    final double avatarSize = 40;
    final double postHeaderHeight = 60;
    Post post = Provider.of<Content>(context).posts[_index];

    final bool isRebloged = post.reblogKey == null || post.reblogKey.isEmpty;
    final bool showFollowButton = true;
    return SizedBox(
      height: postHeaderHeight,
      child: post.blogTitle == null
          ? Center(
              child: Icon(
                Icons.error,
              ),
            )
          : TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.only(left: 15.0)),
              ),
              onPressed: () => _showBlog(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    width: avatarSize,
                    height: avatarSize,
                    imageUrl: post.blogAvatar,
                    placeholder: (context, url) => SizedBox(
                      width: avatarSize,
                      height: avatarSize,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => _errorAvatar(),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                          child: Column(
                            children: [
                              Text(
                                post.blogTitle,
                                style: TextStyle(color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              isRebloged
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.repeat_outlined,
                                        ),
                                        Flexible(
                                          child: Text(
                                            post.reblogKey,
                                            style:
                                                TextStyle(color: Colors.grey),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                  : _emptyContainer(),
                            ],
                          ),
                        ),
                        showFollowButton
                            ? TextButton(
                                onPressed: () => post.followBlog(),
                                child: Text(
                                  'Follow',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              )
                            : _emptyContainer(),
                      ],
                    ),
                  ),
                  _showOptionsIcon
                      ? IconButton(
                          onPressed: _showBlogOptions,
                          icon: Icon(Icons.more_horiz),
                        )
                      : _emptyContainer(),
                ],
              ),
            ),
    );
  }
}
