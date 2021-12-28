import 'package:flutter/material.dart';

///this for show image in Blog screen to see full image (cover image /avatar image )
///this widget use in bottom sheet of avatar and header image to display any image by passing the path  of image

class ShowImage extends StatelessWidget {
  final String img;

  
  ShowImage(this.img);
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        child: Container(
      child: Image(image: NetworkImage(img), fit: BoxFit.fitWidth),
    ));
  }
}
