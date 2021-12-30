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
        TextButton(
            onPressed: () {
              Provider.of<User>(context, listen: false).setActiveBlogTitle(
                  Provider.of<User>(context, listen: false)
                          .getActiveBlogTitleBeforeEdit() ??
                      '');
              Provider.of<User>(context, listen: false)
                  .setActiveBlogDescription(
                      Provider.of<User>(context, listen: false)
                              .getActiveBlogDescriptionBeforeEdit() ??
                          '');

              Provider.of<User>(context, listen: false).setActiveBlogIsCircle(
                  Provider.of<User>(context, listen: false)
                          .getActiveBlogIsCircleBeforeEdit() ??
                      Provider.of<User>(context, listen: false)
                          .getIsAvatarCircle());
              Provider.of<User>(context, listen: false).setActiveBlogBackColor(
                  Provider.of<User>(context, listen: false)
                          .getActiveBlogBackGroundColoreBeforeEdit() ??
                      '');

              Navigator.of(context).pop();
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => BlogScreen()),
              );

              //Navigator.pop(
              // context,
              //MaterialPageRoute(builder: (context) => BlogScreen()),
              //);
            },
            child: Text('Discard')),
        TextButton(
          onPressed: () {
            Provider.of<User>(context, listen: false)
                .updateActiveBlogInfo(context);
            Provider.of<User>(context, listen: false).updateBlog(context);

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
