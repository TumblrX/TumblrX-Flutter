import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_notes/comments_page.dart';
import 'package:tumblrx/components/post/post_notes/likes_page.dart';
import 'package:tumblrx/components/post/post_notes/notes_app_bar.dart';
import 'package:tumblrx/components/post/post_notes/reblogs_page.dart';

class NotesPage extends StatelessWidget {
  final String _postId;
  final int _totalNotes;
  final int _commentCount;
  final int _likeCount;
  final int _reblogCount;
  const NotesPage(
      {Key key,
      @required String postId,
      @required int totlaNotes,
      @required int likeCount,
      @required int commentCount,
      @required int reblogCount})
      : _postId = postId,
        _totalNotes = totlaNotes,
        _likeCount = likeCount,
        _commentCount = commentCount,
        _reblogCount = reblogCount,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: NotesAppBar(
            totalNotes: _totalNotes,
            commentCount: _commentCount,
            likeCount: _likeCount,
            reblogCount: _reblogCount,
          ),
          body: TabBarView(
            children: [
              CommentsPage(postId: _postId),
              ReblogsPage(postId: _postId),
              LikesPage(postId: _postId),
            ],
          ),
        ),
      ),
    );
  }
}
