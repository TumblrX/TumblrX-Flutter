import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';

class TextWriting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Constant.bottomCoverColor,
        padding: const EdgeInsets.all(25.0),
        //height: 123,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Untitled',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
            ),
            Text(
              Constant.profileDescription,
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