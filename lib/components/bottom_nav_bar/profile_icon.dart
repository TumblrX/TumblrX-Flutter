/*
Author: Passant Abdelgalil
Description: 
    A widget for the profile icon in the bottom nav bar with animation
    to open the overlay entry to choose between blogs
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/bottom_nav_bar/account_icon.dart';
import 'package:tumblrx/models/user/user.dart';

class ProfileIcon extends StatelessWidget {
  // passed callback function from parent widget to use on tap event
  final Function _onTab;
  // parent context to access the overlay of the screen
  final BuildContext _context;

  // key of the bottom nav bar to use to access it
  final GlobalKey _key;

  ProfileIcon(this._context, this._key, this._onTab);

  /// builds the stacked blogs icons to choose from
  Widget _buildAccountPicker(User user) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: (user != null && user.userBlogs != null)
            ? user.userBlogs
                .map((blog) => AccountIcon(blog, user.getActiveBlogName()))
                .toList()
            : [Container()],
      ),
    );
  }

  /// inserts the overaly entry of the blogs picker
  OverlayEntry _showPicker(key, User user) {
    // get the overlay stack of the screen
    final OverlayState overlayState = Overlay.of(_context);
    // get the context of the Profile Icon
    final RenderBox renderBox = key.currentContext.findRenderObject();
    // get the size of the Profile Icon
    final size = renderBox.size;
    // get offset of the Profile icon
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    OverlayEntry _switchAccountsOverlayEntry = OverlayEntry(
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
                child: _buildAccountPicker(user),
              ),
            ],
          ),
        );
      },
    );

    // insert the custom popup menu
    overlayState.insert(_switchAccountsOverlayEntry);
    return _switchAccountsOverlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    OverlayEntry _switchAccountsOverlayEntry;

    return Consumer<User>(builder: (ctx, user, child) {
      return GestureDetector(
        onLongPressStart: (_) {
          _switchAccountsOverlayEntry = _showPicker(_key, user);
        },
        onLongPressEnd: (_) {
          user.updateActiveBlog();
          _switchAccountsOverlayEntry.remove();
        },
        onTap: () => _onTab(3), // navigate to profile
        child: Icon(Icons.person),
      );
    });
  }
}
