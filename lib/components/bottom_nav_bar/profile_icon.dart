import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/bottom_nav_bar/account_icon.dart';
import 'package:tumblrx/models/user/account.dart';

class ProfileIcon extends StatelessWidget {
  final Function _onTab;
  BuildContext _context;
  GlobalKey _key;
  OverlayEntry _switchAccountsOverlayEntry;

  ProfileIcon(this._context, this._key, this._onTab);

  Widget _buildAccountPicker(User user) {
    if (user != null) print(user.blogs[0].blogAvatar);
    return Material(
      color: Colors.transparent,
      child: Column(
        children: (user != null && user.blogs != null)
            ? user.blogs
                .map((blog) => AccountIcon(blog, user.activeBlogName))
                .toList()
            : [Container()],
      ),
    );
  }

  void _showPicker(key, User user) {
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
                child: _buildAccountPicker(user),
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
    return Consumer<User>(builder: (ctx, user, child) {
      return GestureDetector(
        onLongPressStart: (_) {
          _showPicker(_key, user);
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
