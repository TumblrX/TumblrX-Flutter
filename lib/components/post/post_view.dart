import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/content.dart';

class PostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Content>(
      builder: (context, content, child) => Container(
          child: Column(
        children: content.posts.map((post) => post.showPost()).toList(),
      )),
    );
  }
}
