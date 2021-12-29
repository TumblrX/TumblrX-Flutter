import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/screens/search_results_screen.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';

class SearchScreen extends StatefulWidget {
  static final String id = "search_screen";
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Widget _viewSearchedBlogs(Map<String, dynamic> response, String query) {
    //logger.d(response);
    if (response.containsKey('blogs')) {
      List<Map<String, dynamic>> blogs =
          List<Map<String, dynamic>>.from(response['blogs']);
      List<Blog> blogsList = [];
      blogs.map((blog) {
        try {
          blogsList.add(Blog.fromJson(blog));
        } catch (err) {
          logger.e('error in handle search blog, $err');
        }
      }).toList();
      logger.d(blogsList.length);
      final double avatarWidth = MediaQuery.of(context).size.width * .1;
      return blogsList == null || blogsList.isEmpty
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tumblrs',
                    style: kBiggerTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Go to @$query',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ...blogsList.map((blog) {
                        return ListTile(
                          leading: CachedNetworkImage(
                            width: avatarWidth,
                            height: avatarWidth,
                            imageUrl: blog.blogAvatar,
                            imageBuilder: (context, imageProvider) => Container(
                              width: avatarWidth,
                              height: avatarWidth,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: avatarWidth,
                              height: avatarWidth,
                              child: Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                          title: Text(
                            blog.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            blog.handle,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text("FOLLOW"),
                          ),
                        );
                      }).toList()
                    ],
                  ),
                ),
              ],
            );
    }
    return Container();
  }

  Widget resultWidget = Container();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        title: Container(
          width: MediaQuery.of(context).size.width * .75,
          child: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              resultWidget = SearchResultScreen(query: value);
              setState(() {});
            },
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Search Tumblrx",
              focusColor: Colors.transparent,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            onChanged: (value) async {
              resultWidget = value.isEmpty
                  ? Container()
                  : _viewSearchedBlogs(
                      await apiClient.sendGetRequest('blog/search', query: {
                        'q': value
                      }, headers: {
                        'Authorization':
                            Provider.of<Authentication>(context, listen: false)
                                .token
                      }),
                      value);
              setState(() {});
            },
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Container(
            constraints: !kIsWeb
                ? BoxConstraints()
                : BoxConstraints(
                    maxWidth: 750.0,
                    minWidth: MediaQuery.of(context).size.width < 750
                        ? MediaQuery.of(context).size.width * 0.9
                        : 750.0,
                  ),
            color: Colors.white,
            child: resultWidget,
          ),
        ),
      ),
    );
  }
}
