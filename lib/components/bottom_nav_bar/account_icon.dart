import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/models/user/blog.dart';

class AccountIcon extends StatefulWidget {
  final Blog _blog;
  final String _defaultBlogName;

  AccountIcon(this._blog, this._defaultBlogName);
  @override
  _AccountIconState createState() => _AccountIconState();
}

class _AccountIconState extends State<AccountIcon> {
  bool _isHovered = false;

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
          user.setActiveBlog(widget._blog.name);
        },
        onEnter: (event) {
          setSelection(true);
          user.setActiveBlog(widget._blog.name);
        },
        onExit: (event) {
          setSelection(false);
          user.setActiveBlog(widget._defaultBlogName);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: _isHovered ? 30.0 : 25.0,
            backgroundImage: AssetImage(widget._blog.blogAvatar),
          ),
        ),
      ),
    );
  }
}
