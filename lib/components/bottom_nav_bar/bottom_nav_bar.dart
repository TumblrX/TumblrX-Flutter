import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tumblrx/components/bottom_nav_bar/profile_icon.dart';
import 'package:tumblrx/screens/Profile_Screen.dart';
import 'package:tumblrx/screens/notifications_screen.dart';
import 'package:tumblrx/screens/search_screen.dart';
import 'package:tumblrx/screens/welcome_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  static final String id = 'main_screen';
  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  void _onPageChanged(int index) {
    setState(() {
      this._selectedIndex = index;
    });
  }

  void _onTap(int pageIndex) {
    _controller.jumpToPage(pageIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _key = GlobalKey();

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
              HomeScreen(),
              SearchScreen(),
              NotificationsScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            enableFeedback: false,
            key: _key,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onTap,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: ProfileIcon(context, _key, _onTap),
                label: 'Profile',
                backgroundColor: Colors.blueGrey[900],
              ),
            ],
            backgroundColor: Colors.blueGrey[900],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
