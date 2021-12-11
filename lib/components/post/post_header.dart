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
  PostHeader(this._index);

  String blogTitle;
  String blogAvatar;

  /// navigate to the blog screen to view blog info
  void _showBlog(BuildContext context) {
    Navigator.of(context)
        .pushNamed('blog_screen', arguments: {'blogTitle': blogTitle});
  }

  /// callback function to request following the post blog
  void _followBlog() {}

  /// callback to open a dialog with blog options
  void _showBlogOptions() {}

  Widget _errorAvatar() => CircleAvatar(
        child: Icon(Icons.error),
      );

  @override
  Widget build(BuildContext context) {
    // constants to size widgets
    final double avatarSize = 40;
    final double postHeaderHeight = 60;
    Post post = Provider.of<Content>(context).posts[_index];
    blogTitle = post.blogTitle;
    blogAvatar = post.blogAvatar;
    return SizedBox(
      height: postHeaderHeight,
      child: blogTitle == null
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
                    imageUrl: blogAvatar,
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
                          child: Text(
                            blogTitle,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // TODO: displayed only if not one of blog's followers
                        TextButton(
                          onPressed: _followBlog,
                          child: Text(
                            'Follow',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _showBlogOptions,
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ),
    );
  }
}
