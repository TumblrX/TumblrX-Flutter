/*
Author:Esraa Gamal
Description:thsi class for constant function and variable 
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/show_image.dart';
import 'package:tumblrx/models/user/user.dart';
import 'edit_blog_screen/edit.dart';

///all constant, variable , widget and function which use more than one
class BlogScreenConstant extends StatelessWidget {
  static Widget buildBottomSheetAvatar(BuildContext context) {
    /// function pop up bottom sheet when click avatar
    //bottomsheet for avatar

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Change your avatar'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Edit()));
          },
        ),
        ListTile(
          title: Text('View your avatar'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowImage(
                        Provider.of<User>(context, listen: false)
                            .getActiveBlogAvatar())));
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
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Edit()));
          },
        ),
        ListTile(
          title: Text('View your header imge'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowImage(
                        Provider.of<User>(context, listen: false)
                            .getActiveBlogHeaderImage())));
          },
        )
      ],
    );
  }

  static String toLengthFifteen(String text) {
    if (text.length > 15) {
      {
        return (text.substring(0, 15) + "...");
      }
    } else {
      return text;
    }
  }

  static Color accent = Color(0xffffff00);

  //static Color bottomCoverColor = Color(0xffb03fa8);

  ///color of header
  static String valueOfDropList = 'unknown';

  ///intial value in drop list
  static List<bool> isSelect = [true, false, false];

  ///color which selected(post/Likes/Following)
  static Color posts = Color(0xffffff00);

  ///color post
  static Color likes = Color(0xffffc7c1c1);

  ///color likes
  static Color following = Color(0xffffc7c1c1);

  ///color following
  //to choice between posts/likes/following
  static Color postsUnderline = Color(0xffffff00);
  static Color likesUnderline = Color(0xffb03fa8);
  static Color followingUnderline = Color(0xffb03fa8);
  //static String title = 'untitled';
  static String userName = 'nervouswinner';
  static String headerImgPath = 'images/header.png';
  static String avatarPath = 'images/avatar.png';
  // static String profileDescription = 'i want to finish this project';

  ///for tumbler blogs
  static List tumblrsBlog = [userName, 'account2'];
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
