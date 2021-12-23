import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/blog_screen.dart';

class AlerDialgue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Save changes?'),
      actions: [
        TextButton(onPressed: () {

         
         }, child: Text('Discard')),
        TextButton(
          onPressed: () { },child: Text('save'),
        )
      ],
    );
  }
}
