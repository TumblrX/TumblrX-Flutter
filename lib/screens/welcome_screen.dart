import 'package:flutter/material.dart';
import 'package:tumblrx/components/Stuff_for_you_widget.dart';
import 'package:tumblrx/components/following_widget.dart';
import 'package:tumblrx/components/top_nav_bar/top_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'feed_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [TopNavBar()];
          },
          body: TabBarView(
            children: [
              FollowingScreen(),
              StuffForYouWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit),
        onPressed: () {
          //double topPadding = MediaQuery.of(context).padding.top;
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(),
              // child: CreatePost(
              //   topPadding: topPadding,
              // ),
            ),
          );
        },
      ),
    );
  }
}
