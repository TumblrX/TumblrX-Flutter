import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'dart:convert' as convert;

/// A class that holds a list of retrieved posts for later accessing
class Content extends ChangeNotifier {
  /// list of posts
  List<Post> _posts = [];

  int _totalPosts = 0;

  bool _isLoading = false;
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

  /// return total number of posts
  int get totalPosts => _totalPosts;

  /// return if a request is already being processed
  bool get isLoading => _isLoading;

  /// return copy of the posts list
  List<Post> get posts => [..._posts];

  /// return whether there are more posts to load or not
  bool hasMore() => _totalPosts == _posts.length;

  Future<List<Post>> getMorePosts(String endPoint, int pageNum) async {
    final String route = 'user/$endPoint';
    final Map<String, dynamic> queryParams = {
      "blog-identifier": "virtualtumblr",
      "page": pageNum,
    };
    // send get request to 'user/dashboard' | 'user/foryou'
    final Response response =
        await MockHttpRepository.sendGetRequest(route, req: queryParams);

    if (response.statusCode != 200) return [];

    final resposeObject =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (pageNum == 1) {
      _totalPosts = resposeObject['total_posts'];
    }

    // construct list of posts object from the parsed json response
    List<Post> postsArray =
        List<Map<String, dynamic>>.from(resposeObject['posts']).map((e) {
      return new Post.fromJson(e);
    }).toList();

    for (var i = 0; i < postsArray.length; i++) {
      postsArray[i].postBlog = await postsArray[i].getBlogData();
      _posts.add(postsArray[i]);
    }

    return postsArray;
  }
}
