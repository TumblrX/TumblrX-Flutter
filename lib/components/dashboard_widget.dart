/*
Description: 
    This file creates a statefulwdiget class to use for rendering
    the user dashboard in tab 'Stuff For You' in the user's feed, using
    the retrieved data from endpoint 'user/foryou'
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_widget.dart';

import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
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
        logger.e('error in dashboard widget while loading more posts $err');
        setState(() {});
      });
    }
  }

  /// Builds the ListView widget to view posts
  Widget _buildListView() {
    // if no posts to view, view an empty content state image
    if (content.posts.isEmpty)
      return Container(
        child: Center(
          child: Image.asset('assets/images/empty_content.jpg'),
        ),
      );

    // build stack to view post view and progress indicator  while loading
    return Stack(
      children: [
        ListView.separated(
          itemCount: content.totalPosts,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            Post post = content.posts[index];
            try {
              return PostWidget(
                post: post,
              );
            } catch (err) {
              logger.e(err);
              return Container(
                child: Center(
                  child: Icon(Icons.error),
                ),
              );
            }
          },
          separatorBuilder: (context, index) =>
              const Divider(height: 20.0, color: Colors.transparent),
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
      color: Theme.of(context).primaryColor,
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
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              );
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
