import 'package:flutter/material.dart';
import 'package:tumblrx/Components/show_image.dart';
///all constant, variable , widget and function which use more than one
class Constant extends StatelessWidget {
  static Widget buildBottomSheetAvatar(BuildContext context) {
    //bottomsheet for avatar

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Change your avatar'),
          onTap: () {},
        ),
        ListTile(
          title: Text('View your avatar'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowImage(Constant.avatarPath)));
          },
        )
      ],
    );
  }

  static Widget buildBottomSheetHeaderImage(BuildContext context) {
    //bottomsheet for Header Image
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Change your header image'),
          onTap: () {},
        ),
        ListTile(
          title: Text('View your header imge'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowImage(Constant.headerImgPath)));
          },
        )
      ],
    );
  }

  static Widget createNewTumblr() {
    //the shape of create new tumblr
    return PopupMenuItem( child: 
      Row(
        
        children: <Widget>[
          Icon(
            Icons.add_circle_outline,
            color: Color(0xffa8a7a7),
          ),
          SizedBox(width: 5,),
        
          Text('Create a new Tumblr')
        ],
      ),
      value: 'create',);
  }

  static String toLengthFifteen(String text) {
    if (text.length > 15) {
      return (text.substring(0, 15) + "...");
    } else {
      return text;
    }
  }

  static Color accent = Color(0xffffff00);

  static Color bottomCoverColor = Color(0xffb03fa8); //color of header
  static String valueOfDropList = 'unknown'; //intial value in drop list
  static List<bool> isSelect = [true, false, false];
  //color which selected(post/Likes/Following)
  static Color posts = Color(0xffffff00); //color post
  static Color likes = Color(0xffffc7c1c1); //color likes
  static Color following = Color(0xffffc7c1c1); //color following
  //to choice between posts/likes/following
  static Color postsUnderline = Color(0xffffff00);
  static Color likesUnderline = Color(0xffb03fa8);
  static Color followingUnderline = Color(0xffb03fa8);
  static String userName = 'nervouswinner';
  static String headerImgPath = 'images/header.png';
  static String avatarPath = 'images/avatar.png';
  static String profileDescription = 'i want to finish this project';
  //for tumbler blogs
  static List tumblrsBlog = ['account1', 'account2'];
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
