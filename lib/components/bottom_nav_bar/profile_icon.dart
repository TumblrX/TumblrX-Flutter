import 'package:flutter/material.dart';
import 'package:tumblrx/components/bottom_nav_bar/account_icon.dart';

class ProfileIcon extends StatelessWidget {
  BuildContext _context;
  GlobalKey _key;
  ProfileIcon(this._context, this._key);
  OverlayEntry _switchAccountsOverlayEntry;

  List<String> accounts = [
    'assets/icon/Tumblr_Logo_t_Icon_White.png',
    'assets/icon/Tumblr_Logo_t_Icon_White.png'
  ];

  Widget _buildAccountPicker() {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          AccountIcon(),
          AccountIcon(),
        ],
      ),
    );
  }

  void _showPicker(key) {
    // get the overlay stack of the screen
    final OverlayState overlayState = Overlay.of(_context);
    // get the context of the Profile Icon
    final RenderBox renderBox = key.currentContext.findRenderObject();
    // get the size of the Profile Icon
    final size = renderBox.size;
    // get offset of the Profile icon
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _switchAccountsOverlayEntry = OverlayEntry(
      builder: (context) {
        EdgeInsets padding = MediaQuery.of(context).padding;
        Size screenSize = MediaQuery.of(context).size;

        return Container(
          color: Colors.black.withOpacity(0.5),
          width: screenSize.width,
          height: screenSize.height - padding.top - padding.bottom,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: size.height,
                right: offset.dx,
                child: _buildAccountPicker(),
              ),
            ],
          ),
        );
      },
    );

    // insert the custom popup menu
    overlayState.insert(_switchAccountsOverlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        _showPicker(_key);
      },
      onLongPressEnd: (_) {
        _switchAccountsOverlayEntry.remove();
      },
      onTap: () => {
        Navigator.of(_context).pushNamedAndRemoveUntil(
            'profile_screen', ModalRoute.withName('welcome_screen'))
      }, // navigate to profile
      child: Icon(Icons.person),
    );
  }
}
