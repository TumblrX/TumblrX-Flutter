import 'package:flutter/material.dart';
import 'package:tumblrx/Components/blog_screen_constant.dart';

///this to get the shape of circle avatar

/// for avatar image
class AvatarImage extends StatefulWidget {

  @override
  _AvatarImageState createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 143,
        child: GestureDetector(
          child: CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage( BlogScreenConstant.avatarPath),
          ),
          onTap: () {
            ///bottom sheet of avatar
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                builder:  BlogScreenConstant.buildBottomSheetAvatar);
          },
        ));
  }
}
