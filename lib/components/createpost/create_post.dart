import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/post_tags.dart';
import 'package:tumblrx/components/createpost/tags_list_view.dart';
import 'package:tumblrx/services/post.dart';
import 'add_tags.dart';
import 'create_post_additions.dart';
import 'create_post_header.dart';
import 'create_post_user.dart';
import '../modal_bottom_sheet.dart';

class CreatePost extends StatefulWidget {
  CreatePost({this.topPadding});
  final double topPadding;
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  List<Widget> postContent = [
    TextField(
      decoration: InputDecoration(
        hintText: "Add something, if you'd like",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  ];

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
                    child: ListView(
                      children: postContent,
                    ),
                  ),
                  PostTags(),
                  SizedBox(
                    height: 10.0,
                  ),
                  CreatePostAdditions(
                    addGif: addGif,
                    addImage: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addGif() async {
    GiphyGif gif = await GiphyGet.getGif(
      context: context,
      apiKey: 'N4xaE80Z4B2vOJ5Kd6VAKsmYqXx4Ijyq',
    );
    if (gif != null && mounted) {
      Widget pickedGif = Image.network(
        gif.images.original.webp,
        headers: {'accept': 'image/*'},
      );
      postContent.add(pickedGif);
    } else
      return;
    addTextField();
  }

  void addTextField() {
    Widget textField = TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
    postContent.add(textField);
    setState(() {});
  }
}