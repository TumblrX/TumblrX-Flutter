import 'package:flutter/material.dart';
import 'package:tumblrx/Components/avatar.dart';
import 'package:tumblrx/Components/constant.dart';
import 'package:tumblrx/Components/headerImage.dart';
import 'package:tumblrx/Components/text.dart';
import 'package:tumblrx/Components/avatarImage.dart';
import 'package:tumblrx/Components/edit/editBottons.dart';
import 'package:tumblrx/Components/tabBars.dart';

class Profile extends StatelessWidget {
  static final String profile = 'profile';
  @override
  Widget build(BuildContext context) {
    return TabBars();

    // return Scaffold(
    //   backgroundColor: Constant.bottomCoverColor,
    //     body: Column(children: <Widget>[
    //        Stack(
    //          alignment: Alignment.center, children: <Widget>[
    //        Column(
    //            children: [
    //             HeaderImage(),
    //              TextWriting(),
    //            Toggle(),

    //         ],
    //          ),
    //         Avatar(),
    //          AvatarImage()
    //        ]),

    //      ]), );
  }
}
