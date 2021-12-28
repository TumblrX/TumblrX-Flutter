import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/blog.dart';

class SearchScreen extends StatelessWidget {
  static final String id = 'search_screen';
  final List<Post> _trendingPosts = _handleTrendingPostsResponse({});
  final List<Blog> _trendingBlogs = _handleTrendingBlogsResponse({});
  final List<String> _endPoints = [
    // trending images
    'user/explore/0/image',
    // trending blogs
    'blog/explore/0/trending',
    // trending posts
    'user/explore/0/trending'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://i.pinimg.com/236x/fb/bf/df/fbbfdf0b5dd8a03841eb61a5a0aa33b2.jpg"),
                        ),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(),
                              children: [
                                WidgetSpan(
                                  baseline: TextBaseline.ideographic,
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                    text: 'Search Tumblr',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          style: ButtonStyle(
                            enableFeedback: false,
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width * 0.7, 20),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(55),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            alignment: Alignment.center,
                            elevation: MaterialStateProperty.all(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Text('Posted By Passant'),
                    bottom: 10,
                    right: 10,
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Text("To Be Implemented!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Post>> _getTrendingPosts() async {
  Map<String, dynamic> response =
      await apiClient.sendGetRequest('user/explore/0/trending');

  if (response['statuscode'] != 200) {
    logger.e('unsuccessful request, ${response['body']['error']}');
    return [];
  }
  return _handleTrendingPostsResponse(response);
}

Future<Response> _getTrendingBlogs() {}
List<Post> _handleTrendingPostsResponse(Map<String, dynamic> json) {}

List<Blog> _handleTrendingBlogsResponse(Map<String, dynamic> json) {}
