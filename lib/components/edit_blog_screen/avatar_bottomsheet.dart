/*
Author:Esraa Gamal
Description:Bottom sheet for Avatar in Edinting 
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
///this class for avatr bottom sheet in editing blog
class EditAvatarBottomSheet extends StatelessWidget {
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
              ///pick the image from device
              Provider.of<User>(context, listen: false)
                  .getActiveBlog()
                  .pickImage(1);
            }),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(thickness: 1),
        ),
        ListTile(
          ///showing  avatar or hide it
            title: Text('Show avatar'),
            trailing: Switch(
                value: Provider.of<User>(context).getActiveBlogShowAvatar(),
                onChanged: (value) {
                  Provider.of<User>(context, listen: false)
                      .setActiveBlogShowAvatar(value);
                }),
            onTap: () {}),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(thickness: 1),
        ),
        ListTile(
          title: Text('Shape'),
          trailing: ToggleButtons(
            renderBorder: false,
            isSelected: [
      !Provider.of<User>(context, listen: false).getIsAvatarCircle(),
      Provider.of<User>(context, listen: false).getIsAvatarCircle()
    ],      ///index [0] for square shape and index [1] for circle        
            onPressed: (index) {
              Provider.of<User>(context, listen: false)
                  .setActiveBlogIsCircleBeforeEdit(
                      Provider.of<User>(context, listen: false)
                          .getIsAvatarCircle());

              Provider.of<User>(context, listen: false)
                  .setActiveBlogIsCircle(index == 0 ? false : true);
            },
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black26),
                ),
              ),
              CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.black26,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.white,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
