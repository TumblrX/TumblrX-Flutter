import 'package:flutter/material.dart';
import 'package:tumblrx/models/user/blog.dart';

class PostHeader extends StatelessWidget {
  final Blog blogData;
  PostHeader(this.blogData);

  void _showBlog(BuildContext context) {
    Navigator.of(context)
        .pushNamed('blog_screen', arguments: blogData.toJson());
  }

  @override
  Widget build(BuildContext context) {
    final double avatarWidth = 40;
    final double postHeaderHeight = 60;
    return SizedBox(
      height: postHeaderHeight,
      child: TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.only(left: 15.0))),
        onPressed: () => _showBlog(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              blogData.getBlogAvatar(),
              width: avatarWidth,
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                    child: Text(
                      blogData.title,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: null,
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
              onPressed: null,
              icon: Icon(Icons.more_horiz),
            ),
          ],
        ),
      ),
    );
  }
}
