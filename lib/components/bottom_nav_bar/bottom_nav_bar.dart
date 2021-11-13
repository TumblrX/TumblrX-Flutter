import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tumblrx/components/bottom_nav_bar/profile_icon.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey _key = GlobalKey();
    final List<String> routeNames = [
      'welcome_screen',
      'search_screen',
      'notification_screen',
      'profile_screen',
    ];
    int _selectedIndex = 0;
    return BottomNavigationBar(
      enableFeedback: false,
      key: _key,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        _selectedIndex = index;
        if (routeNames[index] != 'welcome_screen') {
          Navigator.of(context).pushNamedAndRemoveUntil(
              routeNames[index], ModalRoute.withName('welcome_screen'));
        } else {
          Navigator.of(context).popUntil(ModalRoute.withName('welcome_screen'));
        }
      },
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
          icon: ProfileIcon(context, _key),
          label: 'Profile',
          backgroundColor: Colors.blueGrey[900],
        ),
      ],
      backgroundColor: Colors.blueGrey[900],
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    );
  }
}
