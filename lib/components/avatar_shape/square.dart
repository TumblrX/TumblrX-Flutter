/*
Author:Esraa Gamal
Description: this class to show avatar as a square in Blog 
*/
import 'package:flutter/material.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';
/// for square avatar
class Square extends StatelessWidget {
  ///Background color of the Blog
  final _color;
  final String _path;
  Square({@required color, @required path})
      : _color = color,
        _path = path;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 135,
      child: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.height / 8.7,
          height: MediaQuery.of(context).size.height / 8.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.network(
              _path.startsWith('http') ? _path : ApiHttpRepository.api + _path,
              fit: BoxFit.cover,
            ),
          ),
          decoration: BoxDecoration(
            color: hexToColor(_color ?? '#000000') ?? Colors.blue,
            border: Border.all(
                width: 3,
                color: hexToColor(
                  (_color ?? '#000000') ?? Colors.blue,
                )),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        onTap: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              context: context,
              builder: BlogScreenConstant.buildBottomSheetAvatar);
        },
      ),
    );
  }
}
