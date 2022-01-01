/*
Author:Esraa Gamal
Description: this for showing text and description in blog
*/
import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';
class TextWriting extends StatelessWidget {
/// Blog's title 
  final String _title;
/// Blog's description
  final String _description;
///Blog's background color
  final String _colorBackground;
///Blog's text color
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
    return Container(
        alignment: Alignment.center,
        color: hexToColor(_colorBackground ?? '#2196f3') ?? Colors.blue,
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
            Text(///description
              _description ?? ' ',
              style: TextStyle(
                  color: hexToColor(_textColor ?? '#000000') ?? Colors.black),
            )
          ],
        ),
        

        );
  }
}
