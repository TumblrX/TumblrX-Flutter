import 'package:flutter/material.dart';
import 'package:tumblrx/services/api_provider.dart';

class LikesPage extends StatelessWidget {
  final String _postId;
  LikesPage({Key key, String postId})
      : _postId = postId,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    Future future = ApiHttpRepository.sendGetRequest('');
    List<dynamic> blogs = [];

    return FutureBuilder(
        future: future,
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
              blogs = snapshot.data;
              return ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(blogs[index].blogAvatar),
                        ),
                        title: blogs[index].title,
                        subtitle: blogs[index].name,
                        trailing: TextButton(
                          onPressed: null,
                          child: Text('Follow'),
                        ));
                  });
          }
          return Center(
            child: Icon(Icons.error_outline),
          );
        });
  }
}
