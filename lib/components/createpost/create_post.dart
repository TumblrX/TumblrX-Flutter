import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/post_content.dart';
import 'package:tumblrx/components/createpost/post_tags.dart';
import 'package:tumblrx/services/post.dart';
import 'create_post_additions.dart';
import 'create_post_header.dart';
import 'create_post_user.dart';

class CreatePost extends StatefulWidget {
  CreatePost({this.topPadding});
  final double topPadding;
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight,
      ),
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.topPadding + 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: Column(
          children: [
            Flexible(
              child: Column(
                children: [
                  CreatePostHeader(),
                  SizedBox(
                    height: 10.0,
                  ),
                  CreatePostUser(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    child: PostContent(
                      postContent: Provider.of<Post>(context).postContent,
                    ),
                  ),
                  PostTags(),
                  SizedBox(
                    height: 10.0,
                  ),
                  CreatePostAdditions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
