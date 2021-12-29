import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';

class EditAvatarBottomSheet extends StatelessWidget {
  bool showAvatar;

  List<bool> selectShape;
  XFile a; //test

  @override
  Widget build(BuildContext context) {
    selectShape = [
      !Provider.of<User>(context, listen: false).getIsAvatarCircle(),
      Provider.of<User>(context, listen: false).getIsAvatarCircle()
    ];
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
              Provider.of<User>(context, listen: false)
                  .getActiveBlog()
                  .pickImage(1);
                  
            
            }),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(thickness: 1),
        ),
        ListTile(
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
            isSelected: selectShape,
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
