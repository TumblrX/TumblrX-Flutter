import 'package:flutter/material.dart';
/// this widget use in bottom sheet of avatar and header image to display any image by passing the path  of image 
class ShowImage extends StatelessWidget {
  final String img; ///path of image
  ShowImage(this.img);
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        child: Container(
      child: Image(image: AssetImage(img), fit: BoxFit.fitWidth),
    ));
  }
}
