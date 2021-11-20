import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
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
