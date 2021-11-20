import 'package:flutter/material.dart';
import 'package:tumblrx/models/post.dart';

/// A class that holds a list of retrieved posts for later accessing
class Content extends ChangeNotifier {
  /// list of posts
  List<Post> _posts = [];

  Content();

  /// class constructor from parsed JSON
  Content.fromJson(Map<String, dynamic> parsedJson) {
    try {
      if (parsedJson.containsKey('body'))
        _posts = parsedJson['body'].map((e) => new Post.fromJson(e)).toList();
      else
        print('no argument called body');
    } catch (error) {
      print(error.toString());
    }
  }

  /// update the posts list with passed data
  /// used in ViewList.builder for feed screen
  void updateContent(List<Post> postList) {
    _posts.addAll(postList);
  }

  /// delete a certain post with the passed id from the list
  void deletePost(int id) {
    _posts.removeWhere((element) => element.id == id);
  }

  /// return copy of the posts list
  List<Post> get posts => [..._posts];
}
