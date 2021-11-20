/*
Author: Passant Abdelgalil
Description: 
    The post footer widget that contains reactions count and icons, and 
    post options: share, comment, reblog, and like/unlike
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/utilities/constants.dart';

class PostFooter extends StatelessWidget {
  /// total number of notes
  final int _notesCount;

  /// flag for the user's like/unlike on the post
  final bool _liked;

  PostFooter(this._notesCount, this._liked);

  // constants to size the icons
  final double _reactionsIconSize = 23;
  final double _interactIocnSize = 15;

  /// callback on tap notes icon/number
  void _showNotesPage() {}

  /// Build the widget of the passed reaction icon
  Widget _reactionIcon(String iconPath) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(2),
        color: Colors.white,
        child: ClipOval(
          child: Image.asset(
            iconPath,
            fit: BoxFit.cover,
            width: _reactionsIconSize,
            height: _reactionsIconSize,
          ),
        ),
      ),
    );
  }

  /// Build the widget with actions icon ['like', 'reblog', 'comment', 'share]
  Widget _actionIcon(String iconPath, Function callback) {
    return IconButton(
      iconSize: _interactIocnSize,
      onPressed: callback,
      icon: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(
          iconPath,
          fit: BoxFit.fitWidth,
          // width: _interactIocnSize,
          height: _interactIocnSize,
        ),
      ),
      enableFeedback: false,
    );
  }

  /// Builds the widget of stacked notes icon ['likes', 'reblogs', 'comments']
  Widget notesIcons() {
    // constant shifting amount, should be < icon size
    final double shiftAmount = 20.0;

    // list of notes icon widget
    final List<Widget> icons =
        reactionIcons.map((e) => _reactionIcon(e)).toList();

    // generate stacked icons by applying margin = shiftamount * icon index
    List<Widget> stacked = List<Widget>.generate(icons.length, (index) {
      return Container(
        width: _reactionsIconSize,
        height: _reactionsIconSize,
        child: icons[index],
        margin: EdgeInsets.only(left: shiftAmount * index),
      );
    });

    // stacked notes icon widget
    return Stack(
      children: stacked.reversed.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Post>(
      builder: (context, post, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _notesCount > 0
                  ? [
                      InkResponse(
                        onTap: () => post.commentOnPost(),
                        child: notesIcons(),
                      ),
                      TextButton(
                        child: Text(
                          '$_notesCount notes',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        onPressed: _showNotesPage,
                      ),
                    ]
                  : [],
            ),
            Row(
              children: [
                _actionIcon("assets/icon/share.png", () => post.showPost()),
                _actionIcon("assets/icon/chat.png", () => post.commentOnPost()),
                _actionIcon("assets/icon/reblog.png", () => post.reblogPost()),
                IconButton(
                  onPressed: () => post.likePost(),
                  padding: EdgeInsets.all(0.0),
                  icon: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/icon/heart.png",
                      fit: BoxFit.fitWidth,
                      width: _interactIocnSize,
                      height: _interactIocnSize,
                      colorBlendMode: BlendMode.modulate,
                      color: _liked ? Colors.red : Colors.white,
                    ),
                  ),
                  enableFeedback: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
