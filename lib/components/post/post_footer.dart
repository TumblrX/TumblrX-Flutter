import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/constants.dart';

class PostFooter extends StatelessWidget {
  final int _notesCount;
  final bool _liked;
  PostFooter(this._notesCount, this._liked);
  final double _reactionsIconSize = 23;
  final double _interactIocnSize = 15;
  void _likePost() {}
  void _commentOnPost() {}
  void _reblogPost() {}
  void _sharePost() {}

  void _showNotesPage() {}

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

  Widget notesIcons() {
    final double shiftAmount = 20.0;
    final List<Widget> icons =
        reactionIcons.map((e) => _reactionIcon(e)).toList();

    List<Widget> stacked = List<Widget>.generate(icons.length, (index) {
      return Container(
        width: _reactionsIconSize,
        height: _reactionsIconSize,
        child: icons[index],
        margin: EdgeInsets.only(left: shiftAmount * index),
      );
    });
    return Stack(
      textDirection: TextDirection.ltr,
      children: stacked.reversed.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _notesCount > 0
                ? [
                    InkResponse(
                      onTap: _showNotesPage,
                      child: notesIcons(),
                    ),
                    TextButton(
                      child: Text(
                        '$_notesCount notes',
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                      onPressed: _showNotesPage,
                    ),
                  ]
                : [],
          ),
          Row(
            children: [
              _actionIcon("assets/icon/share.png", _sharePost),
              _actionIcon("assets/icon/chat.png", _commentOnPost),
              _actionIcon("assets/icon/reblog.png", _reblogPost),
              IconButton(
                onPressed: _likePost,
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
    );
  }
}
