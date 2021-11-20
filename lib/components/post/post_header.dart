/*
Author: Passant Abdelgalil
Description: 
    The post header widget that contains blog name, follow button,
    and options icon
*/

import 'package:flutter/material.dart';
import 'package:tumblrx/models/user/blog.dart';

class PostHeader extends StatelessWidget {
  /// blog object of the post
  final Blog blogData;
  PostHeader(this.blogData);

  /// navigate to the blog screen to view blog info
  void _showBlog(BuildContext context) {
    Navigator.of(context)
        .pushNamed('blog_screen', arguments: blogData.toJson());
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
    final double avatarWidth = 40;
    final double postHeaderHeight = 60;
    return SizedBox(
      height: postHeaderHeight,
      child: blogData == null
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
                  FutureBuilder(
                      future: blogData.getBlogAvatar(),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) return _errorAvatar();
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return CircleAvatar(
                              maxRadius: avatarWidth / 2,
                              child: CircularProgressIndicator(),
                            );
                            break;
                          case ConnectionState.done:
                            return Image.network(
                              snapshot.data,
                              width: avatarWidth,
                              errorBuilder: (context, exception, _) =>
                                  _errorAvatar(),
                            );

                            break;
                        }
                        return _errorAvatar();
                      }),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                          child: Text(
                            blogData.name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // todo: displayed only if not one of blog's followers
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
