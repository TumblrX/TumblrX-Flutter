/*
Author:Esraa Gamal
Description:this bottom sheet in editing for(header image)
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';

///this bootom sheet for header image in editing for (header image)
class CoverImageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isswitched;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Icon(
              Icons.api_outlined,
              color: Colors.black,
            ),
            title: Text('Reposition'),
            onTap: () {}),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(thickness: 1),
        ),
        ListTile(
            leading: Icon(
              Icons.apps,
              color: Colors.black,
            ),
            title: Text('Choose a photo'),
            onTap: () {
              Provider.of<User>(context, listen: false)
                  .getActiveBlog()
                  .pickImage(2);
            }),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(thickness: 1),
        ),
        ListTile(
            title: Text('Stretch header'),
            trailing: Switch(

                ///set the image if stretched or not
                value: Provider.of<User>(context)
                        .getActiveBlogStretchHeaderImage() ??
                    true,
                onChanged: (value) {
                  Provider.of<User>(context, listen: false)
                      .setActiveBlogStretchHeaderImage(value);
                }),
            onTap: () {}),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(thickness: 1),
        ),
        ListTile(
            title: Text('Show header image'),
            trailing: Switch(value: isswitched, onChanged: (value) {}),
            onTap: () {}),
      ],
    );
  }
}
