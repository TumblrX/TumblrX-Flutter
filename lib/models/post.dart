/*
Author: Passant Abdelgalil
Description: 
    A class that serves as an API for post objects with 
    like/unlike, comment, reblog, share, edit and delete funcitonalities.
    
    Also it contains functions to construct the object from JSON
    in addition to build the post widget for rendering
*/

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/create_post.dart';
import 'package:tumblrx/components/post/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/components/post/reblogged_post_header.dart';
import 'package:tumblrx/components/post/tags_widget.dart';
import 'package:tumblrx/models/posts/audio_block.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/link_block.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/video_block.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:intl/intl.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'dart:convert' as convert;

import 'package:tumblrx/services/creating_post.dart';

class Post {
  /// The short name used to uniquely identify a blog
  String blogTitle;

  String blogHandle;

  String blogAvatar;

  bool isAvatarCircle;

  /// Post's unique id
  String id;

  String blogId;

  /// post's unique "genesis" ID† as a String
  String gensisPostId;

  /// The location of the post
  String postUrl;

  /// The GMT date and time of the post
  DateTime date;

  /// The key used to reblog this post
  String reblogKey;

  /// Tags applied to the post
  List<String> _tags = [];

  /// The URL for the source of the content (for quotes, reblogs, etc)
  String sourceUrl;

  /// The title of the source site
  String sourceTitle;

  /// Flag for like/unlike
  bool liked;

  ///  the current state of the post
  String state;

  String postType;

  /// The content of the post
  List content = [];

  /// The layout of the post content.
  List layout = [];

  /// The reblog trail items, if any.
  List trail = [];

  /// total number of notes
  int totalNotes = 0;

  /// number of comments on the post
  int commentsCount = 0;

  /// number of likes on the post
  int likesCount = 0;

  /// number of reblogs on the post
  int reblogsCount = 0;

  Post({this.liked, this.content});

  /// blog object who published this post
  Blog postBlog;

  /// Constructs a new instance usin parsed json data
  Post.fromJson(Map<String, dynamic> parsedJson) {
    // ==================== post related data =========================

    // post identifier '_id'
    if (parsedJson.containsKey('_id'))
      id = parsedJson['_id'];
    else
      throw Exception('missing required paramter "_id"');

    // post type
    if (parsedJson.containsKey('postType'))
      postType = parsedJson['postType'];
    else
      throw Exception('missing required parameter "postType"');

    // post state ('published, draft, queued)
    if (parsedJson.containsKey('state'))
      state = parsedJson['state'];
    else
      throw Exception('missing required paramter "state"');

    // post publishing data
    if (parsedJson.containsKey('publishedOn')) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(parsedJson['publishedOn'] * 1000);
      date = DateFormat('yyyy-MM-dd hh:mm').parse(dateTime.toString());
    } else
      throw Exception('missing required paramter "publishedOn"');

    // post reblog key
    // if (parsedJson.containsKey('reblog_key'))
    //   reblogKey = parsedJson['reblog_key'];
    // else
    //   throw Exception("missing required paramter reblog_key");
    // post flag liked (true => user likes, false => user unlikes)
    // if (parsedJson.containsKey('liked'))
    //   liked = parsedJson['liked'];
    // else
    //   throw Exception("missing required paramter liked");
    liked = true;

    // number of comments on the post
    if (parsedJson.containsKey('commentsCount'))
      commentsCount = parsedJson['commentsCount'];

    // number of likes on the post
    if (parsedJson.containsKey('likesCount'))
      likesCount = parsedJson['likesCount'];

    // number of reblogs on the post
    if (parsedJson.containsKey('reblogsCount'))
      reblogsCount = parsedJson['reblogsCount'];

    // calculating total number of notes for viewing purposes
    totalNotes = commentsCount ?? 0 + likesCount ?? 0 + reblogsCount ?? 0;

    List<dynamic> parsedTags = List<dynamic>.from(parsedJson['tags']);
    // post tags
    if (parsedJson.containsKey('tags')) {
      for (var i = 0; i < parsedTags.length; i++)
        _tags.add(parsedJson['tags'][i].toString());
    }

    // post content
    if (parsedJson.containsKey('content')) {
      parsePostContent(List<Map<String, dynamic>>.from(parsedJson['content']));
    } else
      throw Exception('missing required paramter "content"');

    // ========================= post blog data ========================

    if (!parsedJson.containsKey('blogAttribution'))
      throw Exception('missing required paramter "blogAttribution"');
    Map<String, dynamic> blogData =
        parsedJson['blogAttribution'] as Map<String, dynamic>;

    // blog identifier '_id'
    if (blogData.containsKey('_id'))
      blogId = blogData['_id'];
    else
      throw Exception('missing required paramter "_id" in blogAttribution');

    // blog title
    if (blogData.containsKey('title')) blogTitle = blogData['title'];
    // blog handle
    if (blogData.containsKey('handle')) blogHandle = blogData['handle'];
    // blog avatar url
    if (blogData.containsKey('avatar'))
      blogAvatar = blogData['avatar'] == 'none'
          ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
          : blogData['avatar'];
    // blog avatar shape flag (true => circular, false => rectangular)
    if (blogData.containsKey('isAvatarCircle'))
      isAvatarCircle = blogData['isAvatarCircle'];
  }

  /// Construct the right block for each of the Post content
  /// Text, Audio, Video, Image, and Link
  void parsePostContent(List<Map<String, dynamic>> json) {
    List parsedConent = [];
    try {
      json.forEach((obj) {
        print(obj['type'].toString().trim());
        switch (obj['type'].toString().trim()) {
          case 'text':
            parsedConent.add(new TextBlock.fromJson(obj));
            break;
          case 'audio':
            parsedConent.add(new AudioBlock.fromJson(obj));
            break;
          case 'video':
            //parsedConent.add(new VideoBlock.fromJson(obj));
            break;
          case 'image':
            //parsedConent.add(new ImageBlock.fromJson(obj));
            break;
          case 'link':
            parsedConent.add(new LinkBlock.fromJson(obj));
            break;
          default:
            throw Exception("invalid post type");
        }
      });
      content.addAll(parsedConent);
    } catch (error) {
      print('$error @ parseContent');
    }
  }

  /// API for post object to like the post
  Future<bool> likePost() async {
    final String endPoint = 'user/like';
    final Map<String, dynamic> queryParameters = {
      "id": id,
      "reblog_key": reblogKey
    };
    try {
      final response = await MockHttpRepository.sendPostRequest(
          endPoint, convert.jsonEncode(queryParameters));

      if (response.statusCode != 200)
        throw Exception('post ID or reblog_key was not found');
      else {
        liked = true;
        return true;
      }
    } catch (error) {
      throw Exception(error.message.toString());
    }
  }

  /// API for post object to unlike the post
  Future<bool> unlikePost() async {
    final String endPoint = 'user/unlike';
    final Map<String, dynamic> queryParameters = {
      "id": id,
      "reblog_key": reblogKey
    };
    try {
      final response = await MockHttpRepository.sendPostRequest(
          endPoint, convert.jsonEncode(queryParameters));

      if (response.statusCode != 200)
        throw Exception('post ID or reblog_key was not found');
      else {
        liked = false;
        return true;
      }
    } catch (error) {
      throw Exception(error.message.toString());
    }
  }

  /// API for post object to comment on the post
  void commentOnPost() async {
    try {} catch (error) {}
  }

  /// API for post object to reblog the post
  void reblogPost(BuildContext context) async {
    double topPadding = MediaQuery.of(context).padding.top;
    Provider.of<CreatingPost>(context, listen: false)
        .initializePostOptions(context, reblog: true, rebloggedPost: this);
    !kIsWeb
        ? showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: CreatePost(
                topPadding: topPadding,
                isReblog: true,
              ),
            ),
          )
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: CreatePost(
                    topPadding: topPadding,
                    isReblog: true,
                  ),
                ));
  }

  /// API for post object to share the post
  void sharePost() async {
    try {} catch (error) {}
  }

  /// API for post object to delete the post
  Future<bool> deletePost() async {
    final String endPoint = 'post/delete';
    final Map<String, dynamic> queryParameters = {
      "id": id,
    };
    try {
      final response = await MockHttpRepository.sendPostRequest(
          endPoint, convert.jsonEncode(queryParameters));

      if (response.statusCode != 200)
        throw Exception('post ID or reblog_key was not found');
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  /// API for post object to edit the post
  void editPost(BuildContext context) async {
    double topPadding = MediaQuery.of(context).padding.top;
    Provider.of<CreatingPost>(context, listen: false).initializePostOptions(
        context,
        edit: true,
        editPostContent: content,
        editPostId: id);
    !kIsWeb
        ? showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: CreatePost(
                topPadding: topPadding,
              ),
            ),
          )
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: CreatePost(
                    topPadding: topPadding,
                  ),
                ));
  }

  /// API for post object to fetch a post
  static Future<Post> fetchPost(String id) async {
    try {
      final String endPoint = 'posts/id=$id';
      final Response response =
          await MockHttpRepository.sendGetRequest(endPoint);
      if (response.statusCode != 200) throw Exception(response.body.toString());
      final resposeObject =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Post.fromJson(resposeObject);
    } catch (error) {
      throw Exception(error.message);
    }
  }

  void navigateToTag(String tag) {}

  /// API for post object to render the post
  Container showPost(int index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(index),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                content.map<Widget>((block) => block.showBlock()).toList(),
          ),
          Divider(
            color: Colors.transparent,
          ),
          TagsWidget(_tags),
          Divider(
            color: Colors.transparent,
          ),
          PostFooter(index),
        ],
      ),
    );
  }

  /// Shows a reblogged post view
  Container showRebloggedPost() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RebloggedPostHeader(blogAvatar: blogAvatar, blogTitle: blogTitle),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                content.map<Widget>((block) => block.showBlock()).toList(),
          ),
          Divider(
            color: Colors.transparent,
          ),
          TagsWidget(_tags),
        ],
      ),
    );
  }
}
