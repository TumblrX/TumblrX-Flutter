import 'package:flutter/material.dart';
import 'package:tumblrx/Components/Blog_screen.dart';
class Profile extends StatefulWidget {
  static final String profile = 'profile';
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlogScreen(); // return Scaffold(
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
