import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/models/user/user.dart';

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
            backgroundImage: AssetImage(
              Provider.of<User>(context).getActiveBlogAvatar() ??
                  "assets/icon/avatar2.png",
            ),
          ),
          onTap: () {
            ///bottom sheet of avatar
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                builder: BlogScreenConstant.buildBottomSheetAvatar);
          },
        ));
  }
}
