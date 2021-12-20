import 'package:flutter/material.dart';
import 'package:tumblrx/services/api_provider.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    Future future = ApiHttpRepository.sendGetRequest('');
    return FutureBuilder(
      future: future,
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
            return Container();
        }
        return Container();
      },
    );
  }
}
