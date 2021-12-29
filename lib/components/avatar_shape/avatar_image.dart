import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

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
              radius: 42,
              backgroundColor: hexToColor(
                      Provider.of<User>(context, listen: false)
                          .getActiveBlogBackColor()) ??
                  Colors.blue,
              child: CircleAvatar(
                radius: 38,
                backgroundImage: NetworkImage(
                  Provider.of<User>(context).getActiveBlogAvatar(),
                ),
              )),
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
