/*
Author: Passant Abdelgalil
Description: 
    This file creates a statefulwdiget class to use for rendering
    the user dashboard in tab 'Stuff For You' in the user's feed, using
    the retrieved data from endpoint 'user/foryou'
*/

import 'package:flutter/material.dart';
import 'package:tumblrx/models/post.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class StuffForYouWidget extends StatefulWidget {
  @override
  State<StuffForYouWidget> createState() => _StuffForYouWidgetState();
}

class _StuffForYouWidgetState extends State<StuffForYouWidget> {
  /// integer used for pagination
  int _pageNum = 1;

  /// flag to use to view a progress indicator while
  ///  the request is still being processed
  bool _isLoading = false;

  /// cumulative list of posts that have been retrieved to
  /// use for scrolling in the listview widget
  List<Post> _arrayOfPosts;

  /// scroll controller used to check for end of scrolling
  /// to re-send the GET request
  ScrollController _controller;

  /// future retrieved from the GET request containing the
  /// newly set of posts to be viewd
  Future<List<Post>> future;

  /// number of total posts for pagination purpose
  int _totalPosts = 0;

  @override
  void initState() {
    // intialize the controller and add a listner with _scrollListner
    // as a callback function
    _controller = ScrollController()..addListener(_scrollListner);
    // get first packet of posts to render
    future = _getListOfPosts();
    super.initState();
  }

  /// Callback function for scrolling events to load/stop loading posts
  void _scrollListner() {
    if (_totalPosts == _arrayOfPosts.length) return;
    if (_controller.position.extentAfter <= 0 && _isLoading == false)
      _getListOfPosts();
  }

  /// Uses API provider to send a get request to '/user/dashboard'
  /// and update the cumulative list of posts after parsing the response
  Future<List<Post>> _getListOfPosts() async {
    _isLoading = true;
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/user/foryou?blog-identifier="virtualtumblr"';
    final Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    final resposeObject =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<Post> postsArray = [];
    for (Map<String, dynamic> post in resposeObject['posts']) {
      postsArray.add(new Post.fromJson(post));
    }
    setState(() {
      if (_pageNum == 1) {
        _totalPosts = resposeObject['total_posts'];
        _arrayOfPosts = postsArray;
      } else {
        _arrayOfPosts.addAll(postsArray);
      }
      _pageNum++;
    });
    return _arrayOfPosts;
  }

  /// Builds the ListView widget to view posts
  Widget _buildListView() {
    return ListView.builder(
        itemCount: _arrayOfPosts == null ? 0 : _arrayOfPosts.length,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          return _arrayOfPosts[index].showPost();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Post>>(
        future: future,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _pageNum == 1
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      child: LinearProgressIndicator(
                        minHeight: 5,
                      ),
                    );
            case ConnectionState.done:
              if (!snapshot.hasError && snapshot.data != null) {
                _isLoading = false;
                return _buildListView();
              }
              break;
            default:
          }
          return Container();
        },
      ),
    );
  }
}
