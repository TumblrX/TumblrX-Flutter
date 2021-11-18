import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_view.dart';

class StuffForYouWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 16,
      itemBuilder: (context, index) {
        return PostView();
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 12.0,
      ),
    );
  }
}
