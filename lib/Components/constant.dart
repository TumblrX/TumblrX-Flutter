import 'package:flutter/material.dart';
class Constant extends StatelessWidget {
 
 static Widget buildBottomSheetAvatar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Change your avatar'),
          onTap: () {},
        ),
        ListTile(
          title: Text('View your avatar'),
          onTap: () {},
        )
      ],
    );
  }
static Widget buildBottomSheetHeaderImage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Change your header image'),
          onTap: () {},
        ),
        ListTile(
          title: Text('View your header imge'),
          onTap: () {},
        )
      ],
    );
  }
  static Widget createNewTumblr() {
    return DropdownMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.add_circle_outline,
            color: Color(0xffa8a7a7),
          ),
          Text('Create a new Tumblr')
        ],
      ),
      value: 'create',
    );
  }
  static Color bottomCoverColor = Color(0xffb03fa8);
  static String valueOfDropList = 'unknown';
static  List<bool> isSelect = [true, false, false];
  //color which selected(post/Likes/Following)
  static Color posts = Color(0xffffff00);
 static Color likes = Color(0xffffffff);
  static Color following = Color(0xffffffff);
  //to choice between posts/likes/following
  static Color postsUnderline = Color(0xffffff00);
  static Color likesUnderline = Color(0xffb03fa8);
 static Color followingUnderline = Color(0xffb03fa8);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}