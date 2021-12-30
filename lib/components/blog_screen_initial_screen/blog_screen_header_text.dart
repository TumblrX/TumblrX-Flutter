import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

class TextWriting extends StatelessWidget {
  ///this area which has title and discription
  final String _title;
  final String _description;
  final String _colorBackground;
  final String _textColor;
  TextWriting(
      {@required title,
      @required color,
      @required textColor,
      @required description})
      : _title = title,
        _description = description,
        _colorBackground = color,
        _textColor = textColor;
  @override
  Widget build(BuildContext context) {
    //final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
    return Container(
        alignment: Alignment.center,
        color: hexToColor(_colorBackground ?? '#000000') ?? Colors.blue,
        padding: const EdgeInsets.all(25.0),

        ///height: 123,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              ///title
              _title ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  color: hexToColor(_textColor ?? '#000000') ?? Colors.black),
            ),
            Text(
              _description ?? ' ',
              style: TextStyle(
                  color: hexToColor(_textColor ?? '#000000') ?? Colors.black),
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
