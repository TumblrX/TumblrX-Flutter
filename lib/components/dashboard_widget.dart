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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  /// Callback function for scrolling events to load/stop loading posts
  void _scrollListner() async {
    if (!content.hasMore()) return;
    if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
        !content.isLoading) {
      content.getMorePosts(widget._endpoint, _pageNum, auth).then((value) {
        // rebuild to update pagenum and remove linear progress
        setState(() {
          _pageNum++;
        });
      }).catchError((err) {
        print('error in dashboard widget while loading more posts $err');

        setState(() {});
      });
      // rebuild to view linear progress
      setState(() {});
    }
  }

  /// Builds the ListView widget to view posts
  Widget _buildListView() {
    return Stack(
      children: [
        ListView.builder(
          itemCount: content.totalPosts,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) =>
              content.posts[index].showPost(index),
        ),
        content.isLoading
            ? LinearProgressIndicator()
            : Container(
                height: 0,
              )
      ],
    );
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
