/*
Author:Esraa Gamal
Description:Editing avatar functions  
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';
import 'avatar_bottomsheet.dart';
///this class for editing avatar and show avatar in Editing page
class EditAvatar {
  Widget editCircleAvatar(BuildContext context) {
    ///position of avatar in editing
    return Positioned(
      left: MediaQuery.of(context).size.width / 2.6,
      top: MediaQuery.of(context).size.height / 4.5,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(
              radius: 42,
              backgroundColor: hexToColor(
                      Provider.of<User>(context, listen: false)
                          .getActiveBlogBackColor()) ??
                  Colors.blue,
              child: CircleAvatar(
                radius: 38,
                backgroundImage: NetworkImage(
                    Provider.of<User>(context)
                            .getActiveBlogAvatar()
                            .startsWith('http')
                        ? Provider.of<User>(context).getActiveBlogAvatar()
                        : ApiHttpRepository.api +
                            Provider.of<User>(context).getActiveBlogAvatar(),
                    scale: 1.0),
              )),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: EditAvatarBottomSheet().build);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
/// when avatar is square
  Widget editSquareAvatar(BuildContext context) {
    Provider.of<BlogScreenConstantProvider>(context);
    return Positioned(
      left: MediaQuery.of(context).size.width / 2.6,
      top: MediaQuery.of(context).size.height / 4.5,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.height / 8.7,
            height: MediaQuery.of(context).size.height / 8.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.network(
               
                    Provider.of<User>(context).getActiveBlogAvatar().startsWith('http')
                        ? Provider.of<User>(context).getActiveBlogAvatar()
                        : ApiHttpRepository.api +
                            Provider.of<User>(context).getActiveBlogAvatar(),
                fit: BoxFit.cover,
              ),
            ),
            decoration: BoxDecoration(
              color: hexToColor(Provider.of<User>(context, listen: false)
                      .getActiveBlogBackColor()) ??
                  Colors.blue,
              border: Border.all(
                width: 3,
                color: hexToColor(Provider.of<User>(context, listen: false)
                        .getActiveBlogBackColor()) ??
                    Colors.blue,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: EditAvatarBottomSheet().build);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
