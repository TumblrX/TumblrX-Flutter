import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:tumblrx/services/api_provider.dart';

class Blog {
  /// The user's tumblr short name
  String name;

  /// The display title of the blog
  String title;

  /// the URL of the blog
  String url;

  /// indicate if posts are tweeted auto, Y, N
  String tweet;

  /// indicate if posts are sent to facebook Y, N
  String facebook;

  /// indicates if this is the user's primary blog, default=false
  bool primary = false;

  /// total count of followers for this blog
  int followers;

  /// indicates whether a blog is public or private
  String blogType;

  /// url for avatar
  String blogAvatar;

  /// The blog's description
  String description;

  /// total count of blogs this blog follows
  int following;

  /// Number of likes for this user, returned only if this is
  ///  the user's primary blog
  int likes;

  /// The total number of posts to this blog
  int posts;

  Blog(
      {this.name,
      this.title,
      this.primary,
      this.followers,
      this.blogType,
      this.blogAvatar});

  Blog.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('name'))
      name = json['name'];
    else
      throw Exception('missing required parameter "name"');

    if (json.containsKey('title'))
      title = json['title'];
    else
      throw Exception('missing required parameter "title"');

    if (json.containsKey('blogType')) blogType = json['blogType'];
    // else
    //   throw Exception('missing required parameter "blogType"');

    if (json.containsKey('posts')) posts = json['posts'];
    if (json.containsKey('description')) description = json['description'];
    if (json.containsKey('likes')) likes = json['likes'];
    if (json.containsKey('primary')) primary = json['primary'];
    if (json.containsKey('followers')) followers = json['followers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['title'] = this.title;
    data['primary'] = this.primary;
    data['followers'] = this.followers;
    data['blogType'] = this.blogType;
    return data;
  }

  Future<String> getBlogAvatar() async {
    final String endPoint = 'blog/';
    final Map<String, dynamic> reqParameters = {
      "blog-identifier": title,
      "size": 64
    };
    try {
      final Response response =
          await MockHttpRepository.sendGetRequest(endPoint, req: reqParameters);
      if (response.statusCode == 200) {
        final responseParsed = convert.jsonDecode(response.body);
        return responseParsed['avatar_url'];
      } else {
        // handle failed request
        throw Exception(response.body.toString());
      }
    } catch (error) {
      // handle failed request
      throw Exception(error.message.toString());
    }
  }

  static Future<Blog> getInfo(String name) async {
    final String endPoint = 'blog/info';
    final Map<String, dynamic> reqParameters = {"blog-identifier": name};

    try {
      final Response response =
          await MockHttpRepository.sendGetRequest(endPoint, req: reqParameters);
      if (response.statusCode != 200) throw Exception(response.body.toString());
      final parsedResponse = convert.jsonDecode(response.body);
      return Blog.fromJson(parsedResponse['blog']);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  void getPosts() async {
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/blog/$name/posts/';
    try {} catch (error) {}
  }

  void blockBlog(String toBlock) async {
    String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/blog/$name/blocks';
    try {} catch (error) {}
  }
}
