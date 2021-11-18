import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';

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
            backgroundImage: AssetImage(Constant.avatarPath),
          ),
          onTap: () {
            //bottom sheet of avatar
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                builder: Constant.buildBottomSheetAvatar);
          },
        ));
  }
}
