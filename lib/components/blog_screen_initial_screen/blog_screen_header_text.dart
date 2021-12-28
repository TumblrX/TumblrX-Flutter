import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/expect.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

class TextWriting extends StatelessWidget {
  ///this area which has title and discription
  final String _title;
 final String _description;
 TextWriting({@required title,description}):_title=title,_description=description;
  @override
  Widget build(BuildContext context) {
    //final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
    return Container(
        alignment: Alignment.center,
        color: hexToColor(Provider.of<User>(context, listen: false)
                .getActiveBlogBackColor()) ??
            Colors.blue,
        padding: const EdgeInsets.all(25.0),

        ///height: 123,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              ///title
              _title ?? '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
            ),
            Text(

               _description ??
                    ' ')
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
