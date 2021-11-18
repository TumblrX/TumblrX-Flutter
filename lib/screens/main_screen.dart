import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tumblrx/components/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:tumblrx/screens/blog_screen.dart';
import 'package:tumblrx/screens/feed_screen.dart';
import 'package:tumblrx/screens/notifications_screen.dart';
import 'package:tumblrx/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  static final String id = 'main_screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  void _onPageChanged(int index) {
    setState(() {
      // this._selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.sync(() {
        if (_controller.page.round() == _controller.initialPage)
          return true;
        else {
          _controller.jumpToPage(_controller.initialPage);
          return false;
        }
      }),
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            controller: _controller,
            onPageChanged: _onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeedScreen(),
              SearchScreen(),
              NotificationsScreen(),
              BlogScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavBarWidget(_controller),
        ),
      ),
    );
  }
}
