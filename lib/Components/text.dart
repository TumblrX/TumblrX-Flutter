import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';
class TextWriting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color:Constant. bottomCoverColor,
        height: 100,
        child: Text(
          
          'Untitled',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
        )
        //child: Text(
        //'Untitled',
        //style:
        //  TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        //),
        );
  }
}
