import 'package:flutter/material.dart';

class WelcomeScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      
    return Image(
      image: AssetImage('images/welcomeScreenGif.gif'),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }
}
