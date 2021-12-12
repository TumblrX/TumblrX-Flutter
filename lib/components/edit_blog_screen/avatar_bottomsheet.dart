import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/blog.dart';

class EditAvatarBottomSheet extends StatelessWidget {
  bool showAvatar;

  XFile a; //test
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Icon(
              Icons.apps,
              color: Colors.black,
            ),
            title: Text('Choose a photo'),
            onTap: () {
              Blog.pickImage(1);

             
            }),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(thickness: 1),
        ),
        ListTile(
            title: Text('Show avatar'),
            trailing: Switch(value: showAvatar, onChanged: (value) {}),
            onTap: () {}),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(thickness: 1),
        ),
        ListTile(
          title: Text('Shape'),
        ),
      ],
    );
  }
}
