import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'dart:convert' as convert;

import 'package:tumblrx/services/authentication.dart';

/// A class that holds a list of retrieved posts for later accessing
class Content extends ChangeNotifier {
  /// list of posts
  List<Post> _posts = [];

  int _totalPosts = 0;

  bool _isLoading = false;
  Content();

  /// class constructor from parsed JSON
  Content.fromJson(List<Map<String, dynamic>> parsedJson) {
    try {
      _posts = parsedJson.map((e) => new Post.fromJson(e)).toList();
    } catch (error) {
      print('$error @ content from json');
    }
  }
  void resetContent() {
    _totalPosts = 0;
    _posts = [];
  }

  /// delete a certain post with the passed id from the list
  void deletePost(String id) {
    _posts.removeWhere((element) => element.id == id);
  }

  /// return total number of posts
  int get totalPosts => _totalPosts;

  /// return if a request is already being processed
  bool get isLoading => _isLoading;

  /// return copy of the posts list
  List<Post> get posts => [..._posts];

  /// return whether there are more posts to load or not
  bool hasMore() => _posts.length < _totalPosts;

  Future<List<Post>> getMorePosts(
      String endPoint, int pageNum, Authentication auth) async {
    // if already a request is being processed,return
    if (isLoading) return [];

    // set loading flag
    _isLoading = true;

    // construct request data
    final String route = 'user/$endPoint';
    final Map<String, dynamic> queryParams = {'page': 1, 'limit': 20};
    Map<String, String> headers = {'Authorization': auth.token};

    // send get request to 'user/dashboard' | 'user/foryou'
    final Response response = await ApiHttpRepository.sendGetRequest(route,
        headers: headers, query: queryParams);

    // if unsuccessful request return empty list
    if (response.statusCode != 200) {
      print(response.body);
      _isLoading = false;
      return [];
    }

    // decode reponse
    final resposeObject =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    // for pagination, set total number of posts
    if (pageNum == 1) {
      _totalPosts = resposeObject['posts'].length ?? 0;
    }
    List<Post> postsArray;
    try {
      // type casting to list of map objects
      List postsList = List<Map<String, dynamic>>.from(resposeObject['posts']);
      try {
        // construct list of posts object from the parsed json response
        postsArray = postsList.map((e) {
          try {
            return new Post.fromJson(e);
          } catch (err) {}
        }).toList();
      } catch (err) {}
      // insert newely fetched data to the list
      _posts.addAll(postsArray);
    } catch (err) {
      print(err);
      postsArray = [];
    }
    _isLoading = false;
    return postsArray;
  }
}
