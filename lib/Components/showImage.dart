import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';

class ShowImage extends StatelessWidget {
  String img;
  ShowImage(String image) {
    img = image;
  }
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        child: Container(
      child:
          Image(image: AssetImage(img), fit: BoxFit.fitWidth),
    ));
  }
}
