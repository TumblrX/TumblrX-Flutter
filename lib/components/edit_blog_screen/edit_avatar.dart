import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/blog_screen.dart';
import '../blog_screen_constant.dart';
import 'avatar_bottomsheet.dart';

class EditAvatar {
  
  Widget editCircleAvatar(BuildContext context) {
    
    return Positioned(
      left: 140,
      top: 160,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(
              radius: 42,
              backgroundColor: Provider.of<BlogScreenConstantProvider>(context)
                  .bottomCoverColor,
              child: CircleAvatar(
                radius: 38,
                backgroundImage: NetworkImage(
                  Provider.of<User>(context).getActiveBlogAvatar(),
                ),
              )),
          IconButton(
              onPressed: () {
                 showModalBottomSheet( context: context,
                builder:EditAvatarBottomSheet().build);


              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget editSquareAvatar(BuildContext context) {
     final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
    return Positioned(
      left: 140,
      top: 160,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
           Container(
            width: MediaQuery.of(context).size.height / 8.7,
            height: MediaQuery.of(context).size.height / 8.8,
            child:   ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.network(
                  Provider.of<User>(context).getActiveBlogAvatar(),
                   fit: BoxFit.cover,
                ),
            ),
          
            decoration: BoxDecoration(
              color: blogProvider.getBottomColor(),
              border: Border.all(width: 3, color:   blogProvider.getBottomColor()),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          
          IconButton(
              onPressed: () {
                
                 showModalBottomSheet( context: context,
                builder:EditAvatarBottomSheet().build);


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
