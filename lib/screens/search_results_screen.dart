/*
Description: 
    a stateful widget for viewing search result screen
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_widget.dart';
import 'package:tumblrx/components/search_results/tumblrs_view.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/services/authentication.dart';

class SearchResultScreen extends StatefulWidget {
  final String _query;
  const SearchResultScreen({Key key, String query})
      : _query = query,
        super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  // inform user to choose a filter to apply on search results
  Widget _searchResultBody = Center(
    child: Text("Filter Your Results"),
  );

  final Color _unSelectedButtonColor = Colors.grey[850];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: MediaQuery.of(context).size.width * .98,
            child: Row(
              children: [
                // button to select tumblrs from the search results
                TextButton(
                  onPressed: () {
                    _searchResultBody = FutureBuilder(
                      // request search results with type 'blog'
                      future: _getBlogsResult(widget._query),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.done:
                            // if something went wrong, view error icon
                            if (snapshot.hasError)
                              return Center(
                                child: Icon(Icons.error),
                              );
                            // view blogs
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TumblrView(blog: snapshot.data[index]),
                              ),
                            );
                        }
                        return Center(
                          child: Icon(Icons.error),
                        );
                      },
                    );
                    setState(() {});
                  },
                  child: Text('Tumblrs'),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(_unSelectedButtonColor)),
                ),
                // button to select posts with type image from the search results
                TextButton(
                  onPressed: () {
                    _searchResultBody = FutureBuilder(
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.done:
                            // if something went wrong, view error icon
                            if (snapshot.hasError)
                              return Center(
                                child: Icon(Icons.error),
                              );
                            // view posts
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PostWidget(post: snapshot.data[index]),
                              ),
                            );
                        }
                        return Center(
                          child: Icon(Icons.error),
                        );
                      },
                      future: _filterPostsResults(
                          widget._query,
                          "image",
                          Provider.of<Authentication>(context, listen: false)
                              .token),
                    );
                    setState(() {});
                  },
                  child: Text('Photo'),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(_unSelectedButtonColor)),
                ),
                // button to select posts with type text from the search results
                TextButton(
                  onPressed: () {
                    _searchResultBody = FutureBuilder(
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.done:
                            // if something went wrong, view error icon
                            if (snapshot.hasError)
                              return Center(
                                child: Icon(Icons.error),
                              );
                            // view posts
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PostWidget(post: snapshot.data[index]),
                              ),
                            );
                        }
                        return Center(
                          child: Icon(Icons.error),
                        );
                      },
                      future: _filterPostsResults(
                          widget._query,
                          "text",
                          Provider.of<Authentication>(context, listen: false)
                              .token),
                    );
                    setState(() {});
                  },
                  child: Text('Text'),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(_unSelectedButtonColor)),
                ),
                // button to select posts with type video from the search results
                TextButton(
                  onPressed: () {
                    _searchResultBody = FutureBuilder(
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.done:
                            // if something went wrong, view error icon
                            if (snapshot.hasError)
                              return Center(
                                child: Icon(Icons.error),
                              );
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PostWidget(post: snapshot.data[index]),
                              ),
                            );
                        }
                        return Center(
                          child: Icon(Icons.error),
                        );
                      },
                      future: _filterPostsResults(
                          widget._query,
                          "video",
                          Provider.of<Authentication>(context, listen: false)
                              .token),
                    );
                    setState(() {});
                  },
                  child: Text('Video'),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(_unSelectedButtonColor)),
                ),
              ],
            ),
          ),
        ),
        // widget to render search results
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: _searchResultBody,
          ),
        )
      ],
    );
  }

// private helper function to filter posts with the passed type
  Future<List<Post>> _filterPostsResults(
      String query, String type, String token) async {
    Map<String, dynamic> response = await apiClient.sendGetRequest('post',
        headers: {'Authorization': token}, query: {'q': query, 'type': type});
    logger.d(response);
    if (response['statuscode'] != 200) {
      logger.e(response['error']);
      return [];
    }
    List<Map<String, dynamic>> returnedPosts =
        List<Map<String, dynamic>>.from(response['data']);
    return returnedPosts.map((post) {
      try {
        return Post.fromJson(post);
      } catch (err) {
        logger.e(err);
      }
    }).toList();
  }

// private helper function to request blogs from the search results
  Future<List<Blog>> _getBlogsResult(String query) async {
    Map<String, dynamic> response = await apiClient
        .sendGetRequest('blog/search', query: {
      'q': query
    }, headers: {
      'Authorization': Provider.of<Authentication>(context, listen: false).token
    });
    //logger.d(response);
    if (response['statuscode'] != 200) {
      logger.e(response['error']);
      return [];
    }
    try {
      List<Map<String, dynamic>> blogs =
          List<Map<String, dynamic>>.from(response['blogs']);

      return blogs.map((blog) {
        try {
          return Blog.fromJson(blog);
        } catch (err) {
          logger.e(err);
        }
      }).toList();
    } catch (err) {
      logger.e(err);
      return [];
    }
  }
}
