import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/notes.dart';
import 'package:tumblrx/services/authentication.dart';

class LikesPage extends StatelessWidget {
  final String _postId;
  LikesPage({Key key, @required String postId})
      : _postId = postId,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Notes.getNotes(
            'like', Provider.of<Authentication>(context).token, _postId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(
                  child: Icon(Icons.error_outline),
                );
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                          title: Text("Blog Title"),
                          subtitle: Text("Blog handle"),
                          trailing: TextButton(
                            onPressed: null,
                            child: Text('Follow'),
                          ),
                        );
                      }),
                );
              }
          }
          return Center(
            child: Icon(Icons.error_outline),
          );
        });
  }
}
