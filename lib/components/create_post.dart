import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_picker/image_picker.dart';

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
  bool isPostEnabled;
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
  void initState() {
    isPostEnabled = false;

    super.initState();
  }

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
                  CreatePostHeader(
                    isPostEnabled: isPostEnabled,
                  ),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 5.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              size: 30.0,
                              color: Colors.black,
                            ),
                            Text(
                              'Add tags to help people find your post',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black12),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            isPostEnabled = !isPostEnabled;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CreatePostAdditions(
                    addGif: addGif,
                    addImage: addImage,
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

  void addImage() async {
    // final ImagePicker _picker = ImagePicker();
    // final List<XFile> images = await _picker.pickMultiImage();
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
