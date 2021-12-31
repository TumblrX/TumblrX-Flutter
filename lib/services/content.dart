/*
Author: Passant Abdelgalil
Description: 
    This file creates a class to use as a Provider for posts
    it supports paginattion for lazy loading
*/

import 'package:flutter/material.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/services/authentication.dart';

/// A class that holds a list of retrieved posts for later accessing
class Content extends ChangeNotifier {
  /// list of posts
  List<Post> _posts = [];

  /// integer to hold total number of posts
  int _totalPosts = 0;

  /// flag to indicating if a request is still being processed
  bool _isLoading = false;

  Content();

  /// class constructor from parsed JSON
  Content.fromJson(List<Map<String, dynamic>> parsedJson) {
    try {
      _posts = parsedJson.map((e) => new Post.fromJson(e)).toList();
    } catch (error) {
      logger.e('$error @ content from json');
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
    // if already a request is being processed or all posts are fetched,return
    if (isLoading || (posts.length == totalPosts && posts.isNotEmpty))
      return [];

    // set loading flag
    _isLoading = true;

    // construct request data
    final String route = 'user/$endPoint';
    final Map<String, dynamic> queryParams = {'page': pageNum, 'limit': 20};
    Map<String, String> headers = {'Authorization': auth.token};

    // send get request to 'user/dashboard' | 'user/foryou'
    final Map<String, dynamic> response = await apiClient.sendGetRequest(route,
        headers: headers, query: queryParams);
    logger.d(response);
    return _handleResponse(response);
  }

  /// private helper function to handle 'getMorePosts' response and constructs&
  ///  add neccessary Post objects to content list
  List<Post> _handleResponse(Map<String, dynamic> response) {
    // if unsuccessful request return empty list
    if (response.containsKey('statuscode') && response['statuscode'] != 200) {
//      logger.d(response.body);
      return [];
    }

    // logger.d(resposeObject);

    // for pagination, set total number of posts
    if (response.containsKey('posts'))
      _totalPosts += response['posts'].length ?? 0;
    if (response.containsKey('for-youPosts'))
      _totalPosts += response['for-youPosts'].length ?? 0;

    // parse returned posts
    List<Post> postsArray =
        _parseResponseJsonPosts(response['posts'], isFollowed: true);
    // add posts to content list
    _posts.addAll(postsArray);

    // parse returned recommended posts
    postsArray =
        _parseResponseJsonPosts(response['for-youPosts'], isFollowed: false);
    // add posts to content list
    _posts.addAll(postsArray);

    // mark request as resolved
    _isLoading = false;
    // return fetched posts
    return postsArray;
  }

  /// private helper function to parse json-like array of posts
  /// and return list of Post objects
  List<Post> _parseResponseJsonPosts(dynamic posts, {bool isFollowed = true}) {
    if (posts == null) return [];
    List<Post> postsArray = [];
    try {
      // type casting to list of map objects
      List postsList = List<Map<String, dynamic>>.from(posts);

      // construct list of posts object from the parsed json response
      postsArray = postsList.map((post) {
        // if any exception happened, skip this malformed post
        try {
          post['isFollowed'] = isFollowed;
          return new Post.fromJson(post);
        } catch (err) {
          logger.e(err.toString());
        }
      }).toList();
    } catch (err) {
      logger.e(err.toString());
    }
    return postsArray;
  }
}
