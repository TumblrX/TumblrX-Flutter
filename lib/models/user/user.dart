import 'package:flutter/foundation.dart';
import 'package:tumblrx/models/user/blog.dart';

class User extends ChangeNotifier {
  int following;
  String defaultPostFormat;
  String name;
  int likes;
  List<Blog> blogs = [
    new Blog(
      name: "ammarovic21",
      title: "ammar",
      primary: true,
      blogType: "public",
      followers: 20,
      blogAvatar: "assets/icon/default_avatar.png",
    ),
    new Blog(
      name: "passant",
      title: "passant",
      primary: false,
      blogType: "public",
      followers: 20,
      blogAvatar: "assets/icon/avatar2.png",
    ),
  ];
  String activeBlogName;

  User();

  User.fromJson(Map<String, dynamic> json) {
    following = json['following'];
    defaultPostFormat = json['default_post_format'];
    name = json['name'];
    likes = json['likes'];
    if (json['blogs'] != null) {
      json['blogs'].forEach((v) {
        blogs.add(new Blog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['following'] = this.following;
    data['default_post_format'] = this.defaultPostFormat;
    data['name'] = this.name;
    data['likes'] = this.likes;
    if (this.blogs != null) {
      data['blogs'] = this.blogs.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void setActiveBlog(String blogName) {
    activeBlogName = blogName;
  }

  void updateActiveBlog() {
    print("active blog is $activeBlogName");
    notifyListeners();
  }

  String get activeBlog => activeBlogName;

  ///Returns the link to the current active blog avatar
  String getActiveBlogAvatar() {
    for (int i = 0; i < blogs.length; i++) {
      if (blogs[i].name == activeBlog) {
        return blogs[i].blogAvatar;
      }
    }
    return null;
  }
}
