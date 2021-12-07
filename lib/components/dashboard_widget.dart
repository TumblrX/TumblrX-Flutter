/*
Author: Passant Abdelgalil
Description: 
    This file creates a statefulwdiget class to use for rendering
    the user dashboard in tab 'Stuff For You' in the user's feed, using
    the retrieved data from endpoint 'user/foryou'
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/services/api_provider.dart';

import 'dart:convert' as convert;

import 'package:tumblrx/services/content.dart';

class DashboardScreen extends StatefulWidget {
  /// endpoint to which went the get request
  final String _endpoint;
  DashboardScreen(this._endpoint);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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

    // request body
    final String endPoint = 'user/${widget._endpoint}';
    final Map<String, dynamic> queryParams = {
      "blog-identifier": "virtualtumblr"
    };
    // send get request to 'user/dashboard' | 'user/foryou'
    final Response response =
        await MockHttpRepository.sendGetRequest(endPoint, req: queryParams);

    if (response.statusCode != 200) return [];

    final resposeObject =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    // construct list of posts object from the parsed json response
    List<Post> postsArray =
        List<Map<String, dynamic>>.from(resposeObject['posts']).map((e) {
      return new Post.fromJson(e);
    }).toList();

    for (var i = 0; i < postsArray.length; i++) {
      postsArray[i].postBlog = await postsArray[i].getBlogData();
    }

    // update state with retrieve list of posts
    setState(() {
      if (_pageNum == 1) {
        _totalPosts = resposeObject['total_posts'];
        _arrayOfPosts = postsArray;
      } else {
        _arrayOfPosts.addAll(postsArray);
      }
      _pageNum++;
    });
    Provider.of<Content>(context, listen: false).updateContent(postsArray);
    return _arrayOfPosts;
  }

  /// Builds the ListView widget to view posts
  Widget _buildListView() {
    return ListView.builder(
        itemCount: _totalPosts == null ? 0 : _totalPosts,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          return _arrayOfPosts[index].showPost();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<Post>>(
        future: future,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            Navigator.of(context).pushNamed('not_found');
            return Container(
              child: Center(
                child: Icon(Icons.error_outline),
              ),
            );
          }
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
                  : SizedBox(
                      height: 3,
                      child: LinearProgressIndicator(),
                    );
            case ConnectionState.done:
              if (snapshot.data != null) {
                _isLoading = false;
                return _buildListView();
              } else {
                return Container(
                  child: Center(
                    child: Icon(Icons.exposure_minus_1_sharp),
                  ),
                );
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
