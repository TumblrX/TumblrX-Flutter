import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/explore_screen_widgets/check_out_these_blogs.dart';
import 'package:tumblrx/components/explore_screen_widgets/check_out_these_tags.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/tag.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';

Future<List<Post>> _getTrendingPosts(String token) async {
  Map<String, dynamic> response = await apiClient.sendGetRequest(
      'user/explore/0/trending',
      headers: {'Authorization': token});

  logger.d(response);
  if (response['statuscode'] != 200) {
    logger.e('unsuccessful request, $response');
    return [];
  }
  return _handleTrendingPostsResponse(response);
}

Future<List<Tag>> _getTags(String token) async {
  Map<String, dynamic> response = await apiClient
      .sendGetRequest('user/get-tags', headers: {'Authorization': token});
  logger.d(response['tagsPhotos']);
  if (response['statuscode'] != 200) return [];
  List<Tag> result = [];
  Map<String, dynamic> tags = response['tagsPhotos'] as Map<String, dynamic>;
  tags.forEach((key, value) {
    result.add(Tag.fromJson({'name': key, 'image': value[0]}));
  });
  return result;
}

Future<List<Blog>> _getTrendingBlogs(String token) async {
  Map<String, dynamic> response = await apiClient.sendGetRequest(
      'blog/explore/0/trending',
      headers: {'Authorization': token});
  //logger.d(response);
  return _handleTrendingBlogsResponse(response);
}

List<Post> _handleTrendingPostsResponse(Map<String, dynamic> json) {
  return [];
}

Future<List<Blog>> _handleTrendingBlogsResponse(
    Map<String, dynamic> json) async {
  List<Blog> trendingBlogs = [];
  try {
//    logger.d(json);
    if (json.containsKey('trendingBlogs')) {
      // cast response as list of map
      List<Map<String, dynamic>> response =
          List<Map<String, dynamic>>.from(json['trendingBlogs']);
      // fetch blogs info
      for (var blog in response) {
        Map<String, dynamic> result = await apiClient
            .sendGetRequest('blog/search', query: {'q': blog['handle']});
        List<Map<String, dynamic>> searchedBlogs =
            List<Map<String, dynamic>>.from(result['blogs']);

        try {
          //logger.d('blog data is ${searchedBlogs[0]}');
          final blogData = Blog.fromJson(searchedBlogs[0]);
          trendingBlogs.add(blogData);
        } catch (err) {
          logger.e('error calling fromJson $err');
        }
      }
    } else {
      throw Exception('missing required parameter "trendingBlogs"');
    }
  } catch (error) {
    logger.e('outer try error is $error');
  }
  return trendingBlogs;
}

class SearchScreen extends StatelessWidget {
  static final String id = 'search_screen';

  @override
  Widget build(BuildContext context) {
    final String token =
        Provider.of<Authentication>(context, listen: false).token;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: FutureBuilder(
          future: Future.wait<List>([
            _getTrendingBlogs(token),
            _getTrendingPosts(token),
            _getTags(token)
          ]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  logger.e(snapshot.error);
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/404.png"),
                      ),
                    ),
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 200,
                      flexibleSpace: Stack(
                        children: [
                          // header
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
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        TextSpan(
                                            text: 'Search Tumblr',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ButtonStyle(
                                    enableFeedback: false,
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                          20),
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
                    // Explore body
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          // check out these tags
                          ...[
                            if (snapshot.data[2].length > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'Check out these tags',
                                      style: kBiggerTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                  CheckOutTheseTags(tags: snapshot.data[2]),
                                ],
                              )
                          ],
                          // check out these blogs
                          ...[
                            if (snapshot.data[0].length > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'Check out these blogs',
                                      style: kBiggerTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                  CheckOutTheseBlogs(blogs: snapshot.data[0]),
                                ],
                              )
                          ],

                          // check out these posts
                          ...[],
                        ],
                      ),
                    ),
                  ],
                );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
