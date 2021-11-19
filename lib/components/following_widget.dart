import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/content.dart';

class FollowingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Content>(
      builder: (ctx, content, child) => ListView.separated(
        itemCount: content.posts.length,
        itemBuilder: (context, index) {
          return content.posts[index].showPost();
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 12.0,
        ),
      ),
    );
  }
}
