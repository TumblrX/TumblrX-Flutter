import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/notes.dart';
import 'package:tumblrx/services/authentication.dart';

class CommentsPage extends StatefulWidget {
  final String _postId;
  CommentsPage({Key key, @required String postId})
      : _postId = postId,
        super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Notes.getNotes('comment',
          Provider.of<Authentication>(context).token, widget._postId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(
                child: Icon(Icons.error_outline),
              );
            return Container(
              child: Text('Comments To be fetched'),
            );
        }
        return Container();
      },
    );
  }
}
