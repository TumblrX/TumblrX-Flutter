import 'package:flutter/material.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/show_image.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

///this to get the shape of circle avatar
/// for avatar image
class AvatarImage extends StatefulWidget {
  final bool _myBlog;
  final String _path;
  final String _color;

  AvatarImage({@required bool myBlog, @required color, String path})
      : _myBlog = myBlog,
        _path = path,
        _color = color;
  @override
  _AvatarImageState createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 143,
        child: GestureDetector(
          child: CircleAvatar(
              radius: 42,
              backgroundColor: hexToColor(widget._color) ?? Colors.blue,
              child: CircleAvatar(
                radius: 38,
                backgroundImage: NetworkImage(
                  widget._path.startsWith('http')
                      ? widget._path
                      : ApiHttpRepository.api + widget._path,
                ),
              )),
          onTap: () {
            ///bottom sheet of avatar
            if (widget._myBlog)
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  context: context,
                  builder: BlogScreenConstant.buildBottomSheetAvatar);
            else
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowImage(widget._path)));
          },
        ));
  }
}
