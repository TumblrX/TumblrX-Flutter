/*
Description: 
    The main screen after sign in, a template to inject other routes
    but with a shared bottom navigation bar among all of them

    Main structure is:
      * routes screen ['feed', 'search', 'notification', or 'profile page']
      * bottom navigation bar 
*/
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tumblrx/components/bottom_nav_bar/bottom_nav_bar.dart';

import 'package:tumblrx/screens/blog_screen.dart';
import 'package:tumblrx/screens/feed_screen.dart';
import 'package:tumblrx/screens/notifications_screen.dart';
import 'package:tumblrx/screens/explore_screen.dart';

/// class to build main screen when the user successfully log in
class MainScreen extends StatefulWidget {
  /// unique id for the screen to access later
  static final String id = 'main_screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// control the PageView widget logic of naviagtionn
  PageController _controller;

  /// Notifier of current selected page index to update bottom navigation
  /// bar selectedIndex state
  ValueNotifier<int> _selectedIndex;

  /// initialize controller and notifier when the widget is initialized
  @override
  void initState() {
    super.initState();

    // initializing page controller
    _controller = PageController();
    // initializing the notifier of selected index of taps with 0 value
    _selectedIndex = ValueNotifier(0);
  }

  /// updates the state with the current selected index
  void _onPageChanged(int index) {
    setState(() {
      this._selectedIndex.value = index;
    });
  }

  /// dispose listners on removing the screen from the tree permanently
  @override
  void dispose() {
    _controller.dispose();
    _selectedIndex.dispose();
    super.dispose();
  }

  /// build widget for the main screen of the app with
  /// pageview to inject routes page
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // handle android back button logic
      onWillPop: () => Future.sync(() {
        // if the current page is the home page, then exit the app
        if (_controller.page.round() == _controller.initialPage)
          return true;
        // else, jump to the home page no matter what
        else {
          _controller.jumpToPage(_controller.initialPage);
          return false;
        }
      }),
      child: Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FeedScreen(),
            ExploreScreen(),
            NotificationsScreen(),
            BlogScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavBarWidget(_controller, _selectedIndex),
      ),
    );
  }
}
