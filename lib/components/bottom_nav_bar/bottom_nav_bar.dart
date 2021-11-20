/*
Author: Passant Abdelgalil
Description: 
    The bottom navigation bar component to be used in 'Main Screen'

*/
import 'package:flutter/material.dart';
import 'package:tumblrx/components/bottom_nav_bar/profile_icon.dart';

class BottomNavBarWidget extends StatefulWidget {
  // passed controller from parent widget to use for navigation
  final PageController _controller;
  // notifier to update the state of current selected index
  final ValueNotifier<int> _selectedIndexNotifier;

  BottomNavBarWidget(this._controller, this._selectedIndexNotifier);
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  /// Current selected bar item index
  int _selectedIndex = 0;
  @override
  void initState() {
    // add listner to the ValueNotifier object
    widget._selectedIndexNotifier.addListener(() {
      // update the state with the updated value of the notifier
      setState(() {
        _selectedIndex = widget._selectedIndexNotifier.value;
      });
      super.initState();
    });
  }

  /// update the state of the bar and navigate to the tapped page
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      widget._controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // a key to access the bar and get its position to place
    // the profile overlay
    final GlobalKey _key = GlobalKey();

    return BottomNavigationBar(
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
      backgroundColor: Theme.of(context).primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    );
  }
}
