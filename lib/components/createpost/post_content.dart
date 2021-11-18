import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/components/createpost/post_text_field.dart';
import 'package:tumblrx/components/createpost/video_player_preview.dart';
import 'dart:io';
import 'package:tumblrx/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/post.dart';

class PostContent extends StatelessWidget {
  final List<dynamic> postContent;

  PostContent({this.postContent});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getPostContent(context),
    );
  }

  List<Widget> getPostContent(BuildContext context) {
    List<Widget> postContentList = [];
    for (int i = 0; i < postContent.length; i++) {
      Widget content;
      if (postContent[i]['type'] == PostContentType.text) {
        content = PostTextField(
          index: i,
          focus: postContent[i]['content']['data'].focusNode,
          textStyle: postContent[i]['content']['data'].textStyle,
          textEditingController:
              postContent[i]['content']['data'].textEditingController,
        );
      } else if (postContent[i]['type'] == PostContentType.gif) {
        content = Image.network(
          postContent[i]['content']['link'],
          headers: {'accept': 'image/*'},
        );
      } else if (postContent[i]['type'] == PostContentType.link) {
        content = AnyLinkPreview(
          link: postContent[i]['content']['link'],
          displayDirection: UIDirection.UIDirectionHorizontal,
          showMultimedia: false,
          bodyMaxLines: 5,
          bodyTextOverflow: TextOverflow.ellipsis,
          titleStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        );
      } else if (postContent[i]['type'] == PostContentType.image) {
        content = kIsWeb
            ? Image.network(postContent[i]['content'].path)
            : Image.file(File(postContent[i]['content'].path));
      } else if (postContent[i]['type'] == PostContentType.video) {
        content = VideoPlayerPreview(file: postContent[i]['content']);
      }
      postContentList.add(
        Stack(children: [
          content,
          postContent[i]['type'] != PostContentType.text
              ? Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<Post>(context, listen: false)
                            .removePostItem(i);
                      },
                      child: Container(
                        width: 18.0,
                        height: 18.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(230, 230, 230, 1),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.blue,
                          size: 15.0,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ]),
      );
    }
    return postContentList;
  }
}
