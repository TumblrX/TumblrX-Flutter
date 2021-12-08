import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/models/user/user.dart';

class TextWriting extends StatelessWidget {
  ///this area which has title and discription

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: BlogScreenConstant.bottomCoverColor,
        padding: const EdgeInsets.all(25.0),

        ///height: 123,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              ///title
              Provider.of<User>(context).getActiveBlogTitle(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
            ),
            Text(
              ///description
              BlogScreenConstant.profileDescription,
            )
          ],
        )
        //child: Text(
        //'Untitled',
        //style:
        //  TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        //),
        );
  }
}
