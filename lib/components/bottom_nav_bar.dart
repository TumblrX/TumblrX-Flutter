import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  OverlayEntry switchAccountsOverlayEntry;
  List<String> accounts = [
    'assets/icon/Tumblr_Logo_t_Icon_White.png',
    'assets/icon/Tumblr_Logo_t_Icon_White.png'
  ];

  Widget buildAccountPicker() {
    return Material(
      color: Colors.transparent,
      child: Column(
          children: accounts
              .map(
                (e) => GestureDetector(
                  child: IconButton(
                    iconSize: 60,
                    onPressed: null,
                    icon: CircleAvatar(
                      backgroundImage: AssetImage(e),
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }

  void showPicker(key) {
    // get the overlay stack of the screen
    final OverlayState overlayState = Overlay.of(context);
    // get the context of the Profile Icon
    final RenderBox renderBox = key.currentContext.findRenderObject();
    // get the size of the Profile Icon
    final size = renderBox.size;
    // get offset of the Profile icon
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    switchAccountsOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 70,
        child: buildAccountPicker(),
        bottom: size.height,
      ),
    );
    // insert the custom popup menu
    overlayState.insert(switchAccountsOverlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _key = GlobalKey();
    var selectedIndex = 0;

    return BottomNavigationBar(
      key: _key,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => setState(() {
        selectedIndex = index;
      }),
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
          icon: GestureDetector(
            onLongPressStart: (_) {
              showPicker(_key);
            },
            onLongPressEnd: (_) {
              switchAccountsOverlayEntry.remove();
            },
            onTap: () => {}, // navigate to profile
            child: Icon(Icons.person),
          ),
          label: 'Profile',
          backgroundColor: Colors.blueGrey[900],
        ),
      ],
      backgroundColor: Colors.blueGrey[900],
      currentIndex: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    );
  }
}
