/*
Author: Passant Abdelgalil
Description: 
    This file creates a class to use as a Provider for posts
    it supports paginattion for lazy loading
*/

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
    final Response response = await ApiHttpRepository.sendGetRequest(route,
        headers: headers, query: queryParams);

    return _handleResponse(response);
  }

  /// private helper function to handle 'getMorePosts' response and constructs&
  ///  add neccessary Post objects to content list
  List<Post> _handleResponse(Response response) {
    // if unsuccessful request return empty list
    if (response.statusCode != 200) {
      // TODO: replace this with logging
      print(response.body);
      return [];
    }
    // decode reponse
    final Map<String, dynamic> resposeObject =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    // TODO: replace this with logging
    print(resposeObject);

    // for pagination, set total number of posts
    if (resposeObject.containsKey('posts'))
      _totalPosts += resposeObject['posts'].length ?? 0;
    if (resposeObject.containsKey('for-youPosts'))
      _totalPosts += resposeObject['for-youPosts'].length ?? 0;

    // parse returned posts
    List<Post> postsArray = _parseResponseJsonPosts(resposeObject['posts']);
    // add posts to content list
    _posts.addAll(postsArray);

    // parse returned recommended posts
    postsArray = _parseResponseJsonPosts(resposeObject['for_youPosts']);
    // add posts to content list
    _posts.addAll(postsArray);

    // mark request as resolved
    _isLoading = false;
    // return fetched posts
    return postsArray;
  }

  /// private helper function to parse json-like array of posts
  /// and return list of Post objects
  List<Post> _parseResponseJsonPosts(dynamic posts) {
    List<Post> postsArray = [];
    try {
      // type casting to list of map objects
      List postsList = List<Map<String, dynamic>>.from(posts);

      // construct list of posts object from the parsed json response
      postsArray = postsList.map((post) {
        // if any exception happened, skip this malformed post
        try {
          return new Post.fromJson(post);
        } catch (err) {
          // TODO: replace this with logging
          print(err);
        }
      }).toList();
    } catch (err) {
      // TODO: replace this with logging
      print(err);
    }
    return postsArray;
  }
}
