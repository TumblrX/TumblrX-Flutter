import 'package:flutter/foundation.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
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
  List<Map> _followingBlogs = [];

  /// List of tags the user are following
  List<Tag> _followingTags = [];

  /// List of posts the user has liked
  List<Post> _likedPosts = [];

  /// list of tumblr blogs for the user
  List<Blog> _blogs = [];

  /// index of the active blog in [_blogs] list
  int _activeBlogIndex;

  /// description of the currently active/used blog
  String _activeDescriptionTitle;

  User();

  List<Map> get followingBlogs => this._followingBlogs;

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

    // following tags
    if (json.containsKey('followingTags')) {
      logger.d('following tags are ${json['followingTags']}');
      List<Map<String, dynamic>>.from(json['followingTags']).forEach((tagData) {
        _followingTags.add(new Tag.fromJson({'name': tagData}));
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

  Future<void> getFollowingBlogs(String token) async {
    Map<String, dynamic> response = await apiClient
        .sendGetRequest('user/following', headers: {'Authorization': token});
    if (response.containsKey('followingBlogs')) {
      List<Map<String, dynamic>> blogs =
          List<Map<String, dynamic>>.from(response['followingBlogs']);
      blogs.map((blog) {
        Map blogData = {};
        try {
          if (blog.containsKey('title'))
            blogData['title'] = blog['title'];
          else
            throw Exception('missing required parameter "title"');
          if (blog.containsKey('handle'))
            blogData['handle'] = blog['handle'];
          else
            throw Exception('missing required parameter "handle"');
          if (blog.containsKey('avatar'))
            blogData['avatar'] = blog['avatar'];
          else
            throw Exception('missing required parameter "avatar"');
          if (blog.containsKey('_id'))
            blogData['_id'] = blog['_id'];
          else
            throw Exception('missing required parameter "id"');
          logger.d(blogData);
          _followingBlogs.add(blogData);
        } catch (err) {
          logger.e(err);
        }
      });
    }
  }

  ///set user data after login
  void setLoginUserData(Map<String, dynamic> json) {
    if (json.containsKey('following')) _following = json['following'];
    if (json.containsKey('default_post_format'))
      _defaultPostFormat = json['default_post_format'];
    if (json.containsKey('name'))
      _username = json['name'];
    else
      throw Exception('missing required parameter "username"');
    if (json.containsKey('likes')) _likes = json['likes'];

    if (json['blogs'] != null) {
      try {
        json['blogs'].forEach((v) {
          _blogs.add(new Blog.fromJson(v));
        });
        setActiveBlog(json['blogs'][0]['handle']);
      } catch (err) {
        logger.e('error in creating blogs $err');
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

  /// getter for active blog index
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

  bool getActiveBlogIsPrimary() {
    return _blogs[_activeBlogIndex].isPrimary;
  }

  bool getIsAvatarCircle() {
    return _blogs[_activeBlogIndex].isCircleAvatar;
  }

  void setActiveBlogTitle(String title) {
    _blogs[_activeBlogIndex].setBlogtitle(title);
    notifyListeners();
  }

  void setActiveBlogDescription(String description) {
    _blogs[_activeBlogIndex].setBlogDescription(description);
    notifyListeners();
  }

  void setActiveBlogIsCircle(bool isCircle) {
    _blogs[_activeBlogIndex].setIsCircleAvatar(isCircle);
    notifyListeners();
  }

  bool getActiveBlogShowAvatar() {
    return _blogs[_activeBlogIndex].blogTheme.showAvatar;
  }

  void setActiveBlogShowAvatar(bool showAvatar) {
    _blogs[_activeBlogIndex].blogTheme.showAvatar = showAvatar;
  }
}
