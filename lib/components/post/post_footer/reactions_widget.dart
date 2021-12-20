/*
Author: Passant Abdeljalil
Description: 
    Reaction icons widget that displays only icons with reaction count above 0,
    stacked together with small amount of overlapping
*/

import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/custom_icons.dart';

class ReactionsWidget extends StatelessWidget {
  final int _likesCount, _commentCount, _reblogsCount;
  final double _reactionsIconSize = 20;

  final void Function() _showNotesPage;

  ReactionsWidget(
      {Key key,
      int likesCount = 0,
      int commentCount = 0,
      int reblogsCount = 0,
      @required void Function() showNotesPage})
      : _likesCount = likesCount,
        _commentCount = commentCount,
        _reblogsCount = reblogsCount,
        _showNotesPage = showNotesPage,
        super(key: key);

  /// Build the widget of the passed reaction icon
  Widget _reactionIcon(IconData icon, Color color) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(2),
        color: Colors.white,
        child: ClipOval(
            child: Icon(
          icon,
          color: color,
          size: _reactionsIconSize,
        )),
      ),
    );
  }

  /// Builds the widget of stacked notes icon ['likes', 'reblogs', 'comments']
  Widget notesIcons() {
    // constant shifting amount, should be < icon size
    final double shiftAmount = 20.0;

    // list of icons
    List<Widget> stacked = [];
    int index = 0;
    // check if any comment => insert the comment icon
    if (_commentCount > 0) {
      stacked.add(Container(
        child: _reactionIcon(CustomIcons.comment, Colors.blue),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
      index++;
    }
    // check if any reblog => insert the reblog icon
    if (_reblogsCount > 0) {
      stacked.add(Container(
        child: _reactionIcon(CustomIcons.reblogs, Colors.green),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
      index++;
    }
    // check if any like => insert the like icon
    if (_likesCount > 0) {
      stacked.add(Container(
        child: _reactionIcon(CustomIcons.like, Colors.red),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
    }
    // stacked notes icon widget
    return Stack(
      children: stacked.reversed.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int _totalNotes =
        _likesCount ?? 0 + _commentCount ?? 0 + _reblogsCount ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _totalNotes > 0
          ? [
              InkWell(
                onTap: () => _showNotesPage,
                child: notesIcons(),
              ),
              TextButton(
                child: Text(
                  '${_totalNotes.toString()} notes',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                onPressed: _showNotesPage,
              ),
            ]
          : [],
    );
  }
}
