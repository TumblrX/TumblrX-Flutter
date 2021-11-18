import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_view.dart';
import 'package:tumblrx/services/content.dart';

class FollowingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FutureBuilder(
    //   future: TextPostContent,
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.none:
    //         return Text('None');
    //       case ConnectionState.active:
    //       case ConnectionState.waiting:
    //         return Text('Waiting');
    //       case ConnectionState.done:
    //         return Text('Done');
    //       default:
    //         return Text('Error');
    //     }
    //   },
    // );
    Provider.of<Content>(context);
    return ListView.separated(
      itemCount: 60,
      itemBuilder: (context, index) {
        return PostView();
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 12.0,
      ),
    );
  }
}
