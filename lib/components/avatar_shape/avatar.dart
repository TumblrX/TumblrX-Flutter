import 'package:flutter/material.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';

///to show a circle behind avatar
class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 140,
        child: CircleAvatar(
          radius: 41,
          backgroundColor: BlogScreenConstant.bottomCoverColor,
        ));
  }
}
