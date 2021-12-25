import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

class TextWriting extends StatelessWidget {

  
  ///this area which has title and discription
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
    return Container(
        alignment: Alignment.center,
        color:hexToColor( Provider.of<User>(context,listen: false).getActiveBlogBackColor())??Colors.blue,
        padding: const EdgeInsets.all(25.0),

        ///height: 123,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              ///title
              Provider.of<User>(context).getActiveBlogTitle()??'',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
            ),
            Text(

                ///description
                Provider.of<User>(context,listen: false).getActiveBlogDescription()??' '
                
                
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
