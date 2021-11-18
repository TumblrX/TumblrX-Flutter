import 'package:flutter/material.dart';
import 'package:tumblrx/models/post.dart';

class Content extends ChangeNotifier {
  List<Post> _posts = [];
  Content();
  Content.fromJson(Map<String, dynamic> parsedJson) {
    _posts = parsedJson['body'];
  }

  // void addPost() {
  //   _posts.add(value);
  //   notifyListeners();
  // }

  // return copy of the posts list
  List<Post> get posts => [..._posts];
}
