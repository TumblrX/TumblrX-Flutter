import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';

class Toggle extends StatefulWidget {
  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //this container for (post / Likes /Following)
      color: Constant.bottomCoverColor,
      height: 50,
      //toggle Buttons
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              //post
              height: 50,
              width: (MediaQuery.of(context).size.width / 3.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1.5, color: Constant.postsUnderline),
              )),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      //For Change Color of Post

                      Constant.posts = Constant. accent;
                      Constant.likes = Color(0xffc7c1c1);
                      Constant.following = Color(0xffc7c1c1);
                      Constant.isSelect[0] = true;
                      Constant.isSelect[1] = false;
                      Constant.isSelect[2] = false;
                      Constant.postsUnderline = Constant. accent;

                      Constant.likesUnderline = Constant.bottomCoverColor;
                      Constant.followingUnderline = Constant.bottomCoverColor;
                    });
                  },
                  child: Text(
                    'Posts',
                    style: TextStyle(color: Constant.posts),
                  ))),
          Container(
              //likes
              height: 50,
              width: (MediaQuery.of(context).size.width / 3.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1.5, color: Constant.likesUnderline),
              )),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      //For Change Color of Likes
                      Constant.posts = Color(0xffc7c1c1);
                      Constant.likes = Constant. accent;
                      Constant.following = Color(0xffc7c1c1);
                      Constant.isSelect[0] = false;
                      Constant.isSelect[1] = true;
                      Constant.isSelect[2] = false;

                      Constant.postsUnderline = Constant.bottomCoverColor;

                      Constant.likesUnderline = Constant. accent;
                      Constant.followingUnderline = Constant.bottomCoverColor;
                    });
                  },
                  child: Text(
                    'Likes',
                    style: TextStyle(color: Constant.likes),
                  ))),
          Container(
              //following
              height: 50,
              width: (MediaQuery.of(context).size.width / 3.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom:
                    BorderSide(width: 1.5, color: Constant.followingUnderline),
              )),
              child: TextButton(
                  onPressed: () {
                    //For Change Color of following
                    setState(() {
                      Constant.posts = Color(0xffc7c1c1);
                      Constant.likes = Color(0xffc7c1c1);
                      Constant.following = Constant. accent;
                      Constant.isSelect[0] = false;
                      Constant.isSelect[1] = false;
                      Constant.isSelect[2] = true;
                      Constant.postsUnderline = Constant.bottomCoverColor;

                      Constant.likesUnderline = Constant.bottomCoverColor;
                      Constant.followingUnderline =Constant. accent;
                    });
                  },
                  child: Text(
                    'Following',
                    style: TextStyle(color: Constant.following),
                  ))),
        ],
      ),
    );
  }
}