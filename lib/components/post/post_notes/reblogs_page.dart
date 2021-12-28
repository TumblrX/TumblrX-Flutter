/*
Author: Passant Abdelgalil
Description: 
    A class that implementes reblogs screen for a specific post
    list of reblogs on the post is passed to the constructor and
    been iterated on in the build method to render each reblog widget
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_content.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/models/notes.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:tumblrx/utilities/custom_icons.dart';

class ReblogsPage extends StatefulWidget {
  final String _postId;
  ReblogsPage({Key key, @required String postId})
      : _postId = postId,
        super(key: key);

  @override
  State<ReblogsPage> createState() => _ReblogsPageState();
}

class _ReblogsPageState extends State<ReblogsPage> {
  String selectedFilter = 'comments and tags';

  List<Notes> notes = [];

  @override
  Widget build(BuildContext context) {
    //dismiss keyboard if opened
    FocusScope.of(context).requestFocus(FocusNode());
    List<Post> posts = Provider.of<Content>(context, listen: false).posts;
    return FutureBuilder(
      future: Notes.getNotes(
          'reblog', Provider.of<Authentication>(context).token, widget._postId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
          case ConnectionState.none:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(
                child: Icon(Icons.error),
              );
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: null,
                      child: Row(
                        children: [
                          Text(selectedFilter),
                          Icon(Icons.arrow_drop_down_outlined)
                        ],
                      ),
                    ),
                  ),
                  // if no reblogs yet, render a placeholder
                  if (snapshot.data.length == 0)
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              CustomIcons.reblog,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'No reblogs yet',
                              style:
                                  kBiggerTextStyle.copyWith(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (snapshot.data.length > 0) ...[
                    Divider(),
                    Flexible(
                      child: ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final int postIndex = posts.indexWhere(
                              (element) => element.id == notes[index].postId);
                          if (postIndex == -1)
                            return Container(
                              child: Text('blog not found'),
                            );

                          Post post = posts[postIndex];
                          return Column(
                            children: [
                              // post header containing blog title, icon, and options icon
                              PostHeader(index: postIndex),
                              // post content widget without the original post
                              PostContentView(
                                postContent: post.content,
                                tags: post.tags,
                              ),
                              // options buttons to Reblog the reblogged post, or
                              // view the blog profile with this post at the begining
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: null, child: Text('Reblog')),
                                  TextButton(
                                      onPressed: null, child: Text('View post'))
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ],
              );
            }
            break;
        }
        return Container(
          child: Center(
            child: Icon(Icons.error),
          ),
        );
      },
    );
  }

  List<Notes> _handleResponse() {}
}
