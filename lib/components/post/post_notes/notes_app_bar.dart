/*
  Description:
      this file creates a class that extends stateful widget to view
      number of notes in addition to notification icon inside the notes page
      also with tabs to navigate between [comments, like, reblogs] page
 */
import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_notes/notification_button.dart';
import 'package:tumblrx/utilities/custom_icons.dart';

class NotesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int _totalNotes;
  final int _commentCount;
  final int _reblogCount;
  final int _likeCount;

  NotesAppBar(
      {Key key,
      int totalNotes = 0,
      int commentCount = 0,
      int reblogCount = 0,
      int likeCount = 0})
      : _totalNotes = totalNotes,
        _likeCount = likeCount,
        _commentCount = commentCount,
        _reblogCount = reblogCount,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TabBar tabBar = TabBar(
      indicatorColor: Colors.blueAccent,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.blueAccent,
      tabs: [
        // comments tab
        Tab(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(CustomIcons.chat, size: 15),
              Text('$_commentCount')
            ],
          ),
        ),
        // reblogs tab
        Tab(
          icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(CustomIcons.reblog, size: 15),
                Text('$_reblogCount')
              ]),
        ),
        // likes tab
        Tab(
          icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(CustomIcons.heart, size: 15),
                Text('$_likeCount')
              ]),
        )
      ],
    );
    // build app bar
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('$_totalNotes notes'),
      actions: [NotificationButton(isOn: false)],
      bottom: PreferredSize(
        preferredSize: tabBar.preferredSize,
        child: Container(
          child: tabBar,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight * 2);
}
