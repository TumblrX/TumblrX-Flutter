import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/blog_screen.dart';


///to show a circle behind avatar

class Avatar extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);

    return Positioned(
        top: 140,
        child: CircleAvatar(
          radius: 41,
          backgroundColor:  blogProvider.getBottomColor(),
        ));
  }
}
