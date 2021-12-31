import 'package:flutter/foundation.dart';
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
  CreatePost({this.topPadding, this.isReblog = false});

  ///top padding sent to the widget to show it below status bar
  final double topPadding;

  ///indicates of the post type is reblog so the button text changes
  final bool isReblog;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Container(
      constraints: !kIsWeb
          ? BoxConstraints(
              maxHeight: screenHeight,
            )
          : BoxConstraints(
              maxWidth: 500.0,
              maxHeight: 600.0,
              minWidth: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.9
                  : 500.0,
              minHeight: MediaQuery.of(context).size.height < 600
                  ? MediaQuery.of(context).size.height * 0.9
                  : 600.0,
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
                  CreatePostHeader(
                    isReblog: isReblog,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CreatePostUser(),
                  SizedBox(
                    height: 10.0,
                  ),
                  !kIsWeb
                      ? Flexible(
                          child: PostContent(
                            postContent:
                                Provider.of<CreatingPost>(context).postContent,
                          ),
                        )
                      : Expanded(
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
