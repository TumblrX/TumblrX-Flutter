import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_notes/notes_app_bar.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/utilities/custom_icons.dart';

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
    Future future = ApiHttpRepository.sendGetRequest('post/$_postId/notes');
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
          body: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                List<Widget> children = [];
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    children = [
                      // TODO: replace with CommentsPage(),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      // TODO: replace with ReblogsPage(),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      // TODO: replace with LikesPage(),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ];
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      children = [
                        Icon(Icons.error),
                        Icon(Icons.error),
                        Icon(Icons.error)
                      ];
                    } else if (snapshot.hasData) {
                      children = [
                        Icon(CustomIcons.chat),
                        Icon(CustomIcons.reblog),
                        Icon(CustomIcons.like)
                      ];
                    }
                    break;
                }
                return TabBarView(
                  children: children,
                );
              }),
        ),
      ),
    );
  }
}
