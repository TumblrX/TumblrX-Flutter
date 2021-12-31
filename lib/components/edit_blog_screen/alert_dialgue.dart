/*
Author:Esraa Gamal
Description: alert dialgue show when you exsit from edit blog
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/blog_screen.dart';

///alert dialgue for edit page
class AlerDialgue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Save changes?'),
      actions: [
        TextButton(
            ///action when press on discard
            onPressed: () {
              ///set blog title with value before chang  
              Provider.of<User>(context, listen: false).setActiveBlogTitle(
                  Provider.of<User>(context, listen: false)
                          .getActiveBlogTitleBeforeEdit() ??
                      '');
              ///set blog description with value before chang          
              Provider.of<User>(context, listen: false)
                  .setActiveBlogDescription(
                      Provider.of<User>(context, listen: false)
                              .getActiveBlogDescriptionBeforeEdit() ??
                          '');
                  ///set blog is circle with value before chang  
              Provider.of<User>(context, listen: false).setActiveBlogIsCircle(
                  Provider.of<User>(context, listen: false)
                          .getActiveBlogIsCircleBeforeEdit() ??
                      Provider.of<User>(context, listen: false)
                          .getIsAvatarCircle());
                          ///set blog background color with value before chang  
              Provider.of<User>(context, listen: false).setActiveBlogBackColor(
                  Provider.of<User>(context, listen: false)
                          .getActiveBlogBackGroundColoreBeforeEdit() ??
                      '');
              ///navigate to blog screen    
              Navigator.of(context).pop();
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => BlogScreen()),
              );
            },
            child: Text('Discard')),
        TextButton(
          ///action when pressed on save button
          onPressed: () {
            ///update blog changes
            Provider.of<User>(context, listen: false)
                .updateActiveBlogInfo(context);
            Provider.of<User>(context, listen: false).updateBlog(context);
            ///navigate to blog screen    
            Navigator.of(context).pop();

            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => BlogScreen()),
            );
          },
          child: Text('save'),
        )
      ],
    );
  }
}
