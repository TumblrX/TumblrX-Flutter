/*
Author: Passant Abdelgalil
Description: 
    A widget for the blog icon in the overlay entry with animation
    to switch between blogs
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/models/user/blog.dart';

class AccountIcon extends StatefulWidget {
  // blog object to update the current blog on select
  final Blog _blog;
  // string to hold the previously selected blog
  final String _defaultBlogName;

  AccountIcon(this._blog, this._defaultBlogName);
  @override
  _AccountIconState createState() => _AccountIconState();
}

class _AccountIconState extends State<AccountIcon> {
  // flag to indicate if the user selects the blog icon
  bool _isHovered = false;

  // update the flag state with the passed parameter
  // the parameter should be true on ['hover', 'enter'] events
  // and false on 'exit' event
  void _setSelection(bool selectionState) {
    setState(() {
      this._isHovered = selectionState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (ctx, user, child) => MouseRegion(
        onHover: (event) {
          _setSelection(true);
          user.setActiveBlog(widget._blog.handle);
        },
        onEnter: (event) {
          _setSelection(true);
          user.setActiveBlog(widget._blog.handle);
        },
        onExit: (event) {
          _setSelection(false);
          user.setActiveBlog(widget._defaultBlogName);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: _isHovered ? 30.0 : 25.0,
            backgroundImage: NetworkImage(
              widget._blog.blogAvatar,
            ),
          ),
        ),
      ),
    );
  }
}
