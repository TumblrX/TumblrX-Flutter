/*
Description: 
    a stateful widget for the animated tumblr icon that changes its color on pressed event
*/
import 'package:flutter/material.dart';

class TumblrXIcon extends StatefulWidget {
  @override
  _TumblrXIconState createState() => _TumblrXIconState();
}

class _TumblrXIconState extends State<TumblrXIcon>
    with SingleTickerProviderStateMixin {
  // Animation controller to control the logo icon animation
  AnimationController _logoAnimationController;
  // Color Animation that will be applied on the logo icon
  Animation _colorTween;
  // store the color to blend with the icon
  Color color;
  // update state whenever the animation updates
  void _animationListener() {
    setState(() {
      color = _colorTween.value;
    });
  }

  @override
  void initState() {
    // initialize the animation controller on this class
    _logoAnimationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        reverseDuration: Duration(seconds: 1));
    // initialize the begin & end colors of the animation
    _colorTween = ColorTween(begin: Colors.white, end: Colors.purple).animate(
        CurvedAnimation(
            parent: _logoAnimationController, curve: Curves.linearToEaseOut));
    // attach listner function to trigger on change
    _colorTween.addListener(_animationListener);
    super.initState();
  }

  @override
  void dispose() {
    _colorTween.removeListener(_animationListener);
    _logoAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        enableFeedback: false,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        _logoAnimationController
            .forward()
            .then((value) => _logoAnimationController.reverse());
      },
      child: Image.asset(
        'assets/icon/Tumblr_Logo_t_Icon_White.png',
        fit: BoxFit.scaleDown,
        colorBlendMode: BlendMode.modulate,
        color: _colorTween.value,
      ),
    );
  }
}
