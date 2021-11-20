/*
Author: Passant Abdelgalil
Description: 
    A class that serves as an API for post objects with 
    like/unlike, comment, reblog, share, edit and delete funcitonalities.
    
    Also it contains functions to construct the object from JSON
    in addition to build the post widget for rendering
*/

import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/models/posts/audio_block.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/link_block.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/video_block.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:intl/intl.dart';

class Post {
  /// The short name used to uniquely identify a blog
  String blogName;

  /// Post's unique id
  int id;

  /// post's unique "genesis" ID† as a String
  String gensisPostId;

  /// The location of the post
  String postUrl;

  /// The GMT date and time of the post
  DateTime date;

  /// The key used to reblog this post
  String reblogKey;

  /// Tags applied to the post
  List<String> tags = [];

  /// The URL for the source of the content (for quotes, reblogs, etc)
  String sourceUrl;

  /// The title of the source site
  String sourceTitle;

  /// Flag for like/unlike
  bool liked;

  ///  the current state of the post
  String state;

  /// The content of the post
  List content = [];

  /// The layout of the post content.
  List layout = [];

  /// The reblog trail items, if any.
  List trail = [];

  Post({this.blogName, this.liked, this.content});

  /// Constructs a new instance usin parsed json data
  Post.fromJson(Map<String, dynamic> parsedJson) {
    // identifiers
    if (parsedJson.containsKey('blog_name')) blogName = parsedJson['blog_name'];
    if (parsedJson.containsKey('id')) id = parsedJson['id'];
    // post info
    if (parsedJson.containsKey('date')) {
      date = DateFormat("yyyy-MM-dd hh:mm:ss").parse(parsedJson['date']);
    }
    if (parsedJson.containsKey('reblog_key'))
      reblogKey = parsedJson['reblog_key'];
    if (parsedJson.containsKey('tags')) {
      for (var i = 0; i < parsedJson['tags'].length; i++)
        tags.add(parsedJson['tags'][i].toString());
    }
    if (parsedJson.containsKey('liked')) liked = parsedJson['liked'];
    if (parsedJson.containsKey('state')) state = parsedJson['state'];
    // post content
    if (parsedJson.containsKey('content'))
      parsePostContent(parsedJson['content']);
  }

  /// Construct the right block for each of the Post content
  /// Text, Audio, Video, Image, and Link
  void parsePostContent(json) {
    json.forEach((obj) {
      switch (obj['type']) {
        case 'text':
          content.add(new TextBlock.fromJson(obj));
          break;
        case 'audio':
          content.add(new AudioBlock.fromJson(obj));
          break;
        case 'video':
          content.add(new VideoBlock.fromJson(obj));
          break;
        case 'image':
          content.add(new ImageBlock.fromJson(obj));
          break;
        case 'link':
          content.add(new LinkBlock.fromJson(obj));
          break;
        default:
      }
    });
  }

  /// API for post object to like the post
  void likePost() async {
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/user/like?id=$id&reblog_key=$reblogKey';
    try {} catch (error) {}
  }

  /// API for post object to unlike the post
  void unlikePost() async {
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/user/unlike?id=$id&reblog_key=$reblogKey';
    try {} catch (error) {}
  }

  /// API for post object to comment on the post
  void commentOnPost() async {
    try {} catch (error) {}
  }

  /// API for post object to reblog the post
  void reblogPost() async {
    try {} catch (error) {}
  }

  /// API for post object to share the post
  void sharePost() async {
    try {} catch (error) {}
  }

  /// API for post object to delete the post
  void deletePost() async {
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/user/delete?id=$id';
    try {} catch (error) {}
  }

  /// API for post object to edit the post
  void editPost() async {
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/posts/id=$id';
    try {} catch (error) {}
  }

  /// API for post object to fetch a post
  void fetchPost() async {
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/posts/id=$id';
    try {} catch (error) {}
  }

  /// API for post object to get the post blog data
  Blog getBlogData() {
    return new Blog(title: "passant");
  }

  /// API for post object to render the post
  Container showPost() {
    Blog postBlog = getBlogData();
    return Container(
      child: Column(
        children: [
          PostHeader(postBlog),
          Divider(),
          Column(
            children:
                content.map<Widget>((block) => block.showBlock()).toList(),
          ),
          Divider(
            color: Colors.transparent,
          ),
          PostFooter(584, true),
        ],
      ),
    );
  }
}
