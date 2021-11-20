import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {    ///this for show image in Blog screen to see full image (cover image /avatar image )  
  final String img;
  ShowImage(this.img);
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        child: Container(
      child: Image(image: AssetImage(img), fit: BoxFit.fitWidth),
    ));
  }
}
