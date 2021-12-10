/*
Author: Passant Abdelgalil
Description: 
    This file creates a statefulwdiget class to use for rendering
    the user dashboard in tab 'Stuff For You' in the user's feed, using
    the retrieved data from endpoint 'user/foryou'
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/services/authentication.dart';

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

  /// scroll controller used to check for end of scrolling
  /// to re-send the GET request
  ScrollController _controller;

  Content content;
  Authentication auth;

  @override
  void initState() {
    // intialize the controller and add a listner with _scrollListner
    // as a callback function
    _controller = ScrollController()..addListener(_scrollListner);

    super.initState();
  }

  /// Callback function for scrolling events to load/stop loading posts
  void _scrollListner() async {
    if (!content.hasMore()) return;
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      await content.getMorePosts(widget._endpoint, _pageNum, auth);

      setState(() {
        _pageNum += 1;
      });
    }
  }

  /// Builds the ListView widget to view posts
  Widget _buildListView() {
    return ListView.builder(
        itemCount:
            content.hasMore() ? content.posts.length + 1 : content.posts.length,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          // if end of list, return linear progress
          if (index == content.posts.length && index > 0)
            return LinearProgressIndicator();
          // if it's actually a post return its widget
          if (index > 0) return content.posts[index].showPost();
          // otherwise return empty container
          return Container(
            child: Center(
              child: Icon(Icons.sensors_sharp),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    content = Provider.of<Content>(context, listen: false);
    auth = Provider.of<Authentication>(context, listen: false);
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<Post>>(
        future: content.getMorePosts(widget._endpoint, _pageNum, auth),
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
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            case ConnectionState.done:
              if (snapshot.data != null) {
                return _buildListView();
              } else {
                return Container(
                  child: Center(
                    child: Icon(Icons.error_outline),
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
