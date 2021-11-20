import 'package:flutter/material.dart';
import '../blog_screen_constant.dart';
import 'edit_bottons.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: BlogScreenConstant.bottomCoverColor,
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Title',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Description',
            ),
          ),
          EditButtons()
        ],
      ),
    ));
  }
}
