import 'package:flutter/material.dart';

import 'package:tumblrx/Components/constant.dart';

class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 44,
       backgroundColor:Constant .bottomCoverColor,
    );
  }
}
