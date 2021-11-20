/*
Author: Passant Abdelgalil
Description: 
    A class that serves as an API for post objects with 
    like/unlike, comment, reblog, share, edit and delete funcitonalities.
    
    Also it contains functions to construct the object from JSON
    in addition to build the post widget for rendering
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tumblrx/components/post/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/models/posts/audio_block.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/link_block.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/video_block.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:intl/intl.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'dart:convert' as convert;

class Post extends ChangeNotifier {
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

  /// total number of notes
  int totalNotes;

  Post({this.blogName, this.liked, this.content});

  /// blog object who published this post
  Blog postBlog;

  /// Constructs a new instance usin parsed json data
  Post.fromJson(Map<String, dynamic> parsedJson) {
    // identifiers
    if (parsedJson.containsKey('blog_name'))
      blogName = parsedJson['blog_name'];
    else
      throw Exception("missing required paramter blog_name");
    if (parsedJson.containsKey('id'))
      id = parsedJson['id'];
    else
      throw Exception("missing required paramter id");
    // post info

    if (parsedJson.containsKey('date')) {
      date = DateFormat("yyyy-MM-dd hh:mm:ss").parse(parsedJson['date']);
    } else
      throw Exception("missing required paramter date");

    if (parsedJson.containsKey('reblog_key'))
      reblogKey = parsedJson['reblog_key'];
    else
      throw Exception("missing required paramter reblog_key");

    if (parsedJson.containsKey('tags')) {
      for (var i = 0; i < parsedJson['tags'].length; i++)
        tags.add(parsedJson['tags'][i].toString());
    }
    if (parsedJson.containsKey('liked'))
      liked = parsedJson['liked'];
    else
      throw Exception("missing required paramter liked");
    if (parsedJson.containsKey('totalNotes'))
      totalNotes = parsedJson['totalNotes'];
    else
      totalNotes = 0;
    if (parsedJson.containsKey('state'))
      state = parsedJson['state'];
    else
      throw Exception("missing required paramter state");

    // post content
    if (parsedJson.containsKey('content'))
      try {
        parsePostContent(parsedJson['content']);
      } catch (error) {
        throw error;
      }
    else
      throw Exception("missing required paramter content");
  }

  /// Construct the right block for each of the Post content
  /// Text, Audio, Video, Image, and Link
  void parsePostContent(json) {
    List parsedConent = [];
    try {
      json.forEach((obj) {
        switch (obj['type']) {
          case 'text':
            parsedConent.add(new TextBlock.fromJson(obj));
            break;
          case 'audio':
            parsedConent.add(new AudioBlock.fromJson(obj));
            break;
          case 'video':
            parsedConent.add(new VideoBlock.fromJson(obj));
            break;
          case 'image':
            parsedConent.add(new ImageBlock.fromJson(obj));
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
      throw error;
    }
  }

  /// API for post object to like the post
  void likePost() async {
    final String endPoint = 'user/like';
    final Map<String, dynamic> queryParameters = {
      "id": id,
      "reblog_key": reblogKey
    };
    try {
      final response =
          await MockHttpRepository.sendPostRequest(endPoint, queryParameters);

      if (response.statusCode != 200)
        throw Exception('post ID or reblog_key was not found');
      else
        liked = true;
    } catch (error) {
      throw Exception(error.message.toString());
    }
  }

  /// API for post object to unlike the post
  void unlikePost() async {
    final String endPoint = 'user/unlike';
    final Map<String, dynamic> queryParameters = {
      "id": id,
      "reblog_key": reblogKey
    };
    try {
      final response =
          await MockHttpRepository.sendPostRequest(endPoint, queryParameters);

      if (response.statusCode != 200)
        throw Exception('post ID or reblog_key was not found');
      else
        liked = false;
    } catch (error) {
      throw Exception(error.message.toString());
    }
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
    final String endPoint = 'post/delete';
    final Map<String, dynamic> queryParameters = {
      "id": id,
    };
    try {
      final response =
          await MockHttpRepository.sendPostRequest(endPoint, queryParameters);

      if (response.statusCode != 200)
        throw Exception('post ID or reblog_key was not found');
    } catch (error) {
      throw Exception(error.message);
    }
  }

  /// API for post object to edit the post
  void editPost() async {
    final String endPoint = 'posts';
    final Map<String, dynamic> queryParameters = {"id": id};
    try {
      final Response response =
          await MockHttpRepository.sendPostRequest(endPoint, queryParameters);
      if (response.statusCode != 200)
        throw Exception('post ID or reblog_key was not found');
    } catch (error) {
      throw Exception(error.message);
    }
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

  /// API for post object to get the post blog data
  Future<Blog> getBlogData() async {
    return await Blog.getInfo(blogName);
  }

  /// API for post object to render the post
  Container showPost() {
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
          PostFooter(totalNotes, liked),
        ],
      ),
    );
  }
}
