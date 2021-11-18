import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/post_content.dart';
import 'package:tumblrx/components/createpost/post_tags.dart';
import 'package:tumblrx/services/creating_post.dart';
import 'create_post_additions.dart';
import 'create_post_header.dart';
import 'create_post_user.dart';

///Creating Post Container shows the Text Editor and all Post creating options
class CreatePost extends StatelessWidget {
  CreatePost({this.topPadding});

  ///top padding sent to the widget to show it below status bar
  final double topPadding;

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
          top: topPadding + 10.0,
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
                      postContent:
                          Provider.of<CreatingPost>(context).postContent,
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
