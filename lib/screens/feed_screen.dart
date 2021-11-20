import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/dashboard_widget.dart';
import 'package:tumblrx/components/createpost/create_post.dart';
import 'package:tumblrx/components/top_nav_bar/top_nav_bar.dart';
import 'package:tumblrx/models/user/account.dart';
import 'package:tumblrx/services/creating_post.dart';

class FeedScreen extends StatelessWidget {
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
              DashboardScreen('dashboard'),
              DashboardScreen('foryou'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit),
        onPressed: () {
          Provider.of<User>(context, listen: false)
              .setActiveBlog('ammarovic21');
          double topPadding = MediaQuery.of(context).padding.top;
          Provider.of<CreatingPost>(context, listen: false)
              .initializePostOptions(context);
          !kIsWeb
              ? showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: CreatePost(
                      topPadding: topPadding,
                    ),
                  ),
                )
              : showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: CreatePost(
                          topPadding: topPadding,
                        ),
                      ));
        },
      ),
    );
  }
}
