import 'package:flutter/material.dart';
import 'package:tumblrx/components/bottom_nav_bar/profile_icon.dart';

class BottomNavBarWidget extends StatefulWidget {
  final PageController _controller;
  final ValueNotifier<int> _selectedIndexNotifier;
  BottomNavBarWidget(this._controller, this._selectedIndexNotifier);
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    widget._selectedIndexNotifier.addListener(() {
      setState(() {
        _selectedIndex = widget._selectedIndexNotifier.value;
      });
    });
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      widget._controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.blueGrey[900],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    );
  }
}
