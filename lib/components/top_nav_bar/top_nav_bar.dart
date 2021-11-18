import 'package:flutter/material.dart';
import 'package:tumblrx/components/top_nav_bar/tumblrx_icon.dart';

class TopNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: TumblrXIcon(),
      leadingWidth: 30.0,
      backgroundColor: Colors.blueGrey[900],
      title: Row(
        mainAxisSize: MainAxisSize.max,
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            labelColor: Colors.blueAccent,
            padding: EdgeInsets.only(right: 60.0),
            enableFeedback: false,
            labelStyle: TextStyle(fontSize: 16),
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 3.0, color: Colors.blue),
              insets: EdgeInsets.symmetric(horizontal: 30.0),
            ),
            tabs: [
              Text('Following'),
              Text('Stuff for you'),
            ],
          ),
        ],
      ),
    );
  }
}
