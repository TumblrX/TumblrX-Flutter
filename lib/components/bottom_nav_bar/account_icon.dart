import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/account.dart';
import 'package:tumblrx/models/user/blog.dart';

class AccountIcon extends StatefulWidget {
  final Blog _blog;
  final String _defaultBlogName;

  AccountIcon(this._blog, this._defaultBlogName);
  @override
  _AccountIconState createState() =>
      _AccountIconState(_blog, this._defaultBlogName);
}

class _AccountIconState extends State<AccountIcon> {
  bool _isHovered = false;
  Blog _blog;
  String _defaultBlogName;

  _AccountIconState(this._blog, this._defaultBlogName);

  void setSelection(bool selectionState) {
    setState(() {
      this._isHovered = selectionState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (ctx, user, child) => MouseRegion(
        onHover: (event) {
          setSelection(true);
          user.setActiveBlog(_blog.name);
        },
        onEnter: (event) {
          setSelection(true);
          user.setActiveBlog(_blog.name);
        },
        onExit: (event) {
          setSelection(false);
          user.setActiveBlog(_defaultBlogName);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: _isHovered ? 30.0 : 25.0,
            backgroundImage: AssetImage(_blog.blogAvatar),
          ),
        ),
      ),
    );
  }
}
