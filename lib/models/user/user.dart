import 'package:flutter/foundation.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/tag.dart';
import 'package:tumblrx/models/user/blog.dart';

/// A class that manages all user functionalities and
///  used for contacting with API
class User extends ChangeNotifier {
  /// number of blogs the user follows
  int _following;

  /// deffault post format: 'npf' for now
  String _defaultPostFormat = 'npf';

  /// user name
  String _username;

  /// number of user likes
  int _likes;

  /// List of blogs the user has blocked
  List<Blog> _blockedBlogs = [];

  /// List of blogs the user are following
  List<Blog> _followingBlogs = [];

  /// List of tags the user are following
  List<Tag> _followingTags = [];

  /// List of posts the user has liked
  List<Post> _likedPosts = [];

  /// list of tumblr blogs for the user
  List<Blog> _blogs = [];

  /// index of the active blog in [_blogs] list
  int _activeBlogIndex;

  User();

  /// constructor of the class using decoded json
  User.fromJson(Map<String, dynamic> json) {
    // =====
    // username
    if (json.containsKey('name'))
      _username = json['name'];
    else
      throw Exception('missing required parameter "name"');

    // blogs list
    if (json['blogs'] != null) {
      json['blogs'].forEach((blogData) {
        _blogs.add(new Blog.fromJson(blogData));
      });
    }

    // following blogs
    if (json.containsKey('followingBlogs')) {
      List<Map<String, dynamic>>.from(json['followingBlogs'])
          .forEach((blogData) {
        _followingBlogs.add(new Blog.fromJson(blogData));
      });
      _following = _followingBlogs.length;
    } else
      throw Exception('missing required parameter "followingBlogs"');

    // following tags
    if (json.containsKey('followingTags')) {
      List<Map<String, dynamic>>.from(json['followingTags']).forEach((tagData) {
        _followingTags.add(new Tag.fromJson(tagData));
      });
    } else
      throw Exception('missing required parameter "followingTags"');

    // liked posts
    if (json.containsKey('likedPosts')) {
      List<Map<String, dynamic>>.from(json['likedPosts']).forEach((postData) {
        _likedPosts.add(new Post.fromJson(postData));
      });
      _likes = _likedPosts.length;
    } else
      throw Exception('missing required parameter "likedPosts"');

    // blocked posts
    if (json.containsKey('blockedBlogs')) {
      List<Map<String, dynamic>>.from(json['blockedBlogs']).forEach((blogData) {
        _blockedBlogs.add(new Blog.fromJson(blogData));
      });
    } else
      throw Exception('missing required parameter "blockedBlogs"');
  }

  ///set user data after login
  void setLoginUserData(Map<String, dynamic> json) {
    if (json.containsKey('following')) _following = json['following'];
    if (json.containsKey('default_post_format'))
      _defaultPostFormat = json['default_post_format'];
    if (json.containsKey('name'))
      // TODO : change this to handler
      _username = json['name'];
    else
      throw Exception('missing required parameter "username"');
    if (json.containsKey('likes')) _likes = json['likes'];

    if (json['blogs'] != null) {
      // TODO : change this to handler
      try {
        json['blogs'].forEach((v) {
          _blogs.add(new Blog.fromJson(v));
        });
        setActiveBlog(json['blogs'][0]['handle']);
      } catch (err) {
        print('error in creating blogs $err');
      }
    }
  }

  /// function to export the user object as a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (_following != null) data['following'] = this._following;
    if (_defaultPostFormat != null)
      data['default_post_format'] = this._defaultPostFormat;
    if (_username != null) data['_username'] = this._username;
    if (_likes != null) data['likes'] = this._likes;
    if (this._blogs != null) {
      data['blogs'] = this._blogs.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// API to set active/used blog name
  void setActiveBlog(String blogName) {
    _activeBlogIndex =
        _blogs.indexWhere((element) => element.handle == blogName);
  }

  /// API to notify listeners when the activeblog is changed
  void updateActiveBlog() {
    notifyListeners();
  }

  /// getter for active blog name
  int get activeBlogIndex => _activeBlogIndex;

  /// getter for active user blogs list
  List<Blog> get userBlogs => _blogs;

  ///Returns the link to the current active blog avatar
  String getActiveBlogAvatar() {
    return _blogs[_activeBlogIndex].blogAvatar;
  }

  ///Returns the title of the current active blog
  String getActiveBlogTitle() {
    return _blogs[_activeBlogIndex].title;
  }

  ///Returns the description of the current active blog
  String getActiveBlogDescription() {
    return _blogs[_activeBlogIndex].getBlogDescription();
  }

  ///Returns the handle of the current active blog
  String getActiveBlogName() {
    return _blogs[_activeBlogIndex].handle;
  }

  ///Returns the id of the current active blog
  String getActiveBlogId() {
    return _blogs[_activeBlogIndex].id;
  }
}
