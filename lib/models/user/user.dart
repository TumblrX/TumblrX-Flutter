import 'package:flutter/foundation.dart';
import 'package:tumblrx/models/user/blog.dart';

/// A class that manages all user functionalities and
///  used for contacting with API
class User extends ChangeNotifier {
  /// number of blogs the user follows
  int following;

  /// deffault post format: 'npf' for now
  String defaultPostFormat = 'npf';

  /// user name
  String name;

  /// number of user likes
  int likes;

  /// list of tumblr blogs for the user
  List<Blog> blogs = [
    new Blog(
      name: "passant",
      title: "passant",
      primary: true,
      blogType: "public",
      followers: 20,
      blogAvatar: "assets/icon/default_avatar.png",
    ),
  ];

  /// name of the currently active/used blog
  String activeBlogName;

  User();

  /// constructor of the class using decoded json
  User.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('following')) following = json['following'];
    if (json.containsKey('default_post_format'))
      defaultPostFormat = json['default_post_format'];
    if (json.containsKey('name'))
      name = json['name'];
    else
      throw Exception('missing required parameter name');
    if (json.containsKey('likes')) likes = json['likes'];

    if (json['blogs'] != null) {
      json['blogs'].forEach((v) {
        blogs.add(new Blog.fromJson(v));
      });
    }
  }

  /// function to export the user object as a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (following != null) data['following'] = this.following;
    if (defaultPostFormat != null)
      data['default_post_format'] = this.defaultPostFormat;
    if (name != null) data['name'] = this.name;
    if (likes != null) data['likes'] = this.likes;
    if (this.blogs != null) {
      data['blogs'] = this.blogs.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// API to set active/used blog name
  void setActiveBlog(String blogName) {
    activeBlogName = blogName;
  }

  /// API to notify listeners when the activeblog is changed
  void updateActiveBlog() {
    notifyListeners();
  }

  /// getter for active blog name
  String get activeBlog => activeBlogName;
}
