import 'package:flutter/material.dart';
import 'package:tumblrx/models/post.dart';

class Content extends ChangeNotifier {
  List<Post> _posts = [];
  Content();
  Content.fromJson(Map<String, dynamic> parsedJson) {
    _posts = parsedJson['body'];
  }

  // return copy of the posts list
  List<Post> get posts => [..._posts];
}
