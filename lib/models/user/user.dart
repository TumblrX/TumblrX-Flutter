import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/tag.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/authentication.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

/// A class that manages all user functionalities and
///  used for contacting with API
class User extends ChangeNotifier {
  /// number of blogs the user follows
  int _following;

  /// deffault post format: 'npf' for now
  String _defaultPostFormat = 'npf';

  /// user name
  String _username;

  /// user id
  String _id;

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

  List<Blog> get followingBlogs => this._followingBlogs;

  /// constructor of the class using decoded json
  User.fromJson(Map<String, dynamic> json) {
    // =====
    // id
    if (json.containsKey('id'))
      _id = json['id'];
    else
      throw Exception('missing required parameter "id"');

    /// username
    if (json.containsKey('name'))
      _username = json['name'];
    else
      throw Exception('missing required parameter "name"');

    /// blogs list
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

  ///set user data after login
  void setLoginUserData(Map<String, dynamic> json, BuildContext context) {
    if (json.containsKey('following')) _following = json['following'];
    if (json.containsKey('id'))
      _id = json['id'];
    else
      throw Exception('missing required parameter "id"');
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

        Provider.of<User>(context, listen: false)
            .setBlogsInfo(context); //esraa added

        Provider.of<User>(context, listen: false)
            .getUserPosts(context); //esraa added

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

  void getUserPosts(BuildContext context) {
    _blogs.forEach((element) {
      element.blogPosts(context, true);
    });
    notifyListeners();
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

  ///getter for username
  String get username => _username;

  ///getter for userid
  String get userId => _id;

  ///Returns the link to the current active blog avatar
  String getActiveBlogAvatar() {
    return _blogs[_activeBlogIndex].blogAvatar;
  }

  ///Returns the title of the current active blog
  String getActiveBlogTitle() {
    return _blogs[_activeBlogIndex].title;
  }

  String getActiveBlogTitleBeforeEdit() {
    return _blogs[_activeBlogIndex].titleBeforEdit;
  }

  void settActiveBlogTitleBeforeEdit(String title) {
    _blogs[_activeBlogIndex].setTitleBeforeEdit(title);
    notifyListeners();
  }

  String getActiveBlogBackGroundColoreBeforeEdit() {
    return _blogs[_activeBlogIndex].backGroundColorBeforEdit;
  }

  void settActiveBlogBackGroundColorBeforeEdit(String color) {
    _blogs[_activeBlogIndex].setBackGroundColorBeforEditing(color);
    notifyListeners();
  }

  String getActiveBlogDescriptionBeforeEdit() {
    return _blogs[_activeBlogIndex].descriptionBeforEdit;
  }

  void setActiveBlogDescriptionBeforeEdit(String description) {
    _blogs[_activeBlogIndex].setDescriptionBeforEdit(description);
    notifyListeners();
  }

  bool getActiveBlogIsCircleBeforeEdit() {
    return _blogs[_activeBlogIndex].isCircleBeforEdit;
  }

  void setActiveBlogIsCircleBeforeEdit(bool isCircle) {
    _blogs[_activeBlogIndex].setIsCircleBeforEditing(isCircle);
    notifyListeners();
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

  ///return if blog is primary
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

  Future<List<Post>> getActiveBlogPosts() async {
    return _blogs[_activeBlogIndex].posts;
  }

  bool getActiveBlogShowAvatar() {
    return _blogs[_activeBlogIndex].showAvatar;
  }

  void setActiveBlogShowAvatar(bool showAvatar) {
    _blogs[_activeBlogIndex].setShowAvatar(showAvatar);
    notifyListeners();
  }

  String getActiveBlogBackColor() {
    return _blogs[_activeBlogIndex].backGroundColor;
  }

  ///Returns primary blog avatar url
  String getPrimaryBlogAvatar() {
    for (Blog blog in _blogs) {
      if (blog.isPrimary) return blog.blogAvatar;
    }
    return null;
  }

  ///Returns primary blog handle
  String getPrimaryBlogName() {
    for (Blog blog in _blogs) {
      if (blog.isPrimary) return blog.handle;
    }
    return null;
  }

  ///get if show header image true or false
  bool getActiveShowHeaderImage() {
    return _blogs[_activeBlogIndex].showHeadeImage;
  }

  void setActiveBlogBackColor(String color) {
    _blogs[_activeBlogIndex].setBlogBackGroundColor(color);

    notifyListeners();
  }

  Blog getActiveBlog() {
    return _blogs[_activeBlogIndex];
  }

  String getActiveBlogHeaderImage() {
    return _blogs[_activeBlogIndex].headerImage;
  }

  void updateActiveBlogInfo(BuildContext context) {
    _blogs[_activeBlogIndex].updateBlog(context);
  }

  void setActiveBlogStretchHeaderImage(bool stretch) {
    _blogs[_activeBlogIndex].setStrtchHeaderImage(stretch);
    notifyListeners();
  }

  bool getActiveBlogStretchHeaderImage() {
    return _blogs[_activeBlogIndex].stretchHeaderImage;
  }

  String getActiveBlogTitleColor() {
    return _blogs[_activeBlogIndex].titleColor;
  }

  ///send request to create new blog for the same user
  Future<void> createNewlog(String name, BuildContext context) async {
    final endPoint = 'api/blog/dfsfdfsfsd';

    final Map<String, dynamic> blogInfo = {
      "title": "Untitled",
      "handle": name,
      "private": false.toString()
    };

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    final response = await apiClient.sendPostRequest(endPoint,
        reqBody: blogInfo, headers: headers);
    logger.d(response);
    if (response['statuscode'] == 200 || response['statuscode'] == 201) {
      if (response.containsKey('data')) {
        _blogs.add(Blog.fromJson(response['data']));

        ///set new blog as active blog
        _activeBlogIndex = _blogs.length - 1;
        logger.d('active blog index $_activeBlogIndex');
        logger.d('_blogs ${_blogs.length}');
        notifyListeners();
      }
    } else {
      {}
      print(response['statuscode']);
    }
  }

  ///set blogs' information for the user
  void setBlogsInfo(BuildContext context) {
    _blogs.forEach((element) {
      element.blogRetrive(context);
    });
    notifyListeners();
  }

  int getUserFollowing() {
    return _following;
  }

  ///check if blog User's Blog
  bool isUserBlog(String _id) {
    for (int i = 0; i < _blogs.length; i++) {
      if (_id == _blogs[i].id) return true;
    }
    return false;
  }

  ///retrive blogs' information from data base
  void getUserInfo(BuildContext context) async {
    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };
    final response = await http.get(
        Uri.parse('${ApiHttpRepository.api}api/user/info'),
        headers: headers);
    Map<String, dynamic> responseObject =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      // print(responseObject);
      if (responseObject.containsKey('blogs')) {
        responseObject['blogs'].forEach((blog) {
          //print(blog.values.runtimeType);
          this._blogs = [];
          this._blogs.add(new Blog.fromJson(blog));
        });
      }
    }
  }
/// send get request to retrive all post this user likes
  Future<List<Post>> getUserLikes(BuildContext context) async {
    final String endPoint = 'user/likes';

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    _likedPosts = [];
    final response = await apiClient.sendGetRequest(endPoint, headers: headers);
    if (response['statuscode'] == 200) {
      logger.d(response);
      if (response.containsKey('likePosts')) {
        if (response['likePosts'] != null) {
          List<Map<String, dynamic>>.from(response['likePosts'])
              .forEach((data) {
            try {
              this._likedPosts.add(new Post.fromJson(data));
            } catch (e) {
              print(e);
            }
          });
        }
      }
    }
    return _likedPosts;
  }

  ///return primary blog id

  ///follow user
  void followUser(BuildContext context, String _id) async {
    final String endPoint = 'api/user/follow';
    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };
    final Map<String, String> body = {"_id": _id};

    final response = await apiClient.sendPostRequest(endPoint,
        reqBody: body, headers: headers);
    if (response['statuscode'] == 200) {
    } else {
      logger.e('unseccful');
      logger.e(response);
    }
  }
///send get request to retrive the blogs the user follow
  Future<List<Blog>> getUserBlogFollowing(BuildContext context) async {
    String endPoint = 'user/following';

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };
    final response = await apiClient.sendGetRequest(endPoint, headers: headers);

    if (response['statuscode'] == 200) {
      this._followingBlogs = [];
      if (response.containsKey('followingBlogs')) {
        if (response.containsKey('followingBlogs')) {
          List<Map<String, dynamic>>.from(response['followingBlogs'])
              .forEach((blogData) {
            _followingBlogs.add(new Blog.fromJson(blogData));
          });
        }
      }
      return _followingBlogs;
    } else {}
    return [];
  }
///update blog
  Future<void> updateBlog(BuildContext context) async {
    await _blogs[_activeBlogIndex].updateBlogTheme(context);
    notifyListeners();
  }
}
