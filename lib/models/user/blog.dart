import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumblrx/services/authentication.dart';
import 'blog_theme.dart';

class Blog {
  /// The user's tumblr short name
  String _handle;

  /// The display title of the blog
  String _title;

  /// The id of the blog
  String _id;

  /// indicates if this is the user's primary blog, default=false
  bool _primary = false;

  /// total count of followers for this blog
  int _followersCount;

  /// list of blogs that follow this blog
  List<Blog> _followedBy;

  /// indicates whether a blog is private or not
  bool _isPrivate = false;

  /// indicates whether a blog is primary or not
  bool _isPrimary;

  /// url for avatar
  String _blogAvatar;

  /// The blog's description
  String _description;

  /// total count of blogs this blog follows
  int _following;

  /// Number of likes for this user, returned only if this is
  ///  the user's primary blog
  int _likes;

  /// The total number of posts to this blog
  int _postsCount;

  /// list of posts of this blog

  List<Post> _posts = [];

  /// flag to determine avatar shape
  bool _isCircleAvatar;

  //background color
  String _backGroundColor;
//check if show avatar or not
  bool _showAvatar;
  //show header image
  bool _showHeadeImage;
//strech header imae
  bool _stretchHeaderImage;
  //title befor Edit
  String _titleBeforeEdit;
//decription before Edit
  String _descriptionBeforEdit;
  //isCircleAvatar
  bool _isCircleBeforEdit;
  String _headerImage;
  String _backGroundColorBeforEdit;

  /// themes of Blog
  BlogTheme _blogTheme = BlogTheme();

  String get blogAvatar => _blogAvatar;
  String get handle => _handle;
  String get title => _title;
  String get id => _id;
  bool get isPrimary => _isPrimary;
  bool get isCircleAvatar => this._isCircleAvatar;
  String get description => this._description;
  BlogTheme get blogTheme => this._blogTheme;
  List<Post> get posts => _posts;
  String get backGroundColor => _backGroundColor;
  bool get showAvatar => _showAvatar;
  bool get showHeadeImage => _showHeadeImage;
  bool get stretchHeaderImage => _stretchHeaderImage;
  String get titleBeforEdit => _titleBeforeEdit;
  String get descriptionBeforEdit => _descriptionBeforEdit;
  bool get isCircleBeforEdit => _isCircleBeforEdit;
  String get backGroundColorBeforEdit => _backGroundColorBeforEdit;

  Blog(
      [this._handle,
      this._title,
      this._primary,
      this._followersCount,
      this._isPrivate,
      this._isPrimary,
      this._blogAvatar]);

  Blog.fromJson(Map<String, dynamic> json) {
    // blog id
    if (json.containsKey('_id'))
      _id = json['_id'];
    else
      throw Exception('missing required parameter "_id"');

    // blog description
    if (json.containsKey('description')) _description = json['description'];

    // blog handle
    if (json.containsKey('handle'))
      _handle = json['handle'];
    else
      throw Exception('missing required parameter "handle"');

    // blog title
    if (json.containsKey('title')) {
      _title = json['title'];
      _titleBeforeEdit = json['title'];
    } else
      throw Exception('missing required parameter "title"');
    //blog description
    if (json.containsKey('description')) {
      _description = json['description'];
      _descriptionBeforEdit = json['description'];
    }
    // else
    // throw Exception('missing required parameter "description"');

    if (json.containsKey('avatar')) {
      _blogAvatar = json['avatar'] == 'none'
          ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
          : json['avatar'];
      if (!this._blogAvatar.contains('http'))
        this._blogAvatar = '${ApiHttpRepository.api}' + this._blogAvatar;
    }
    // blog avatar shape
    if (json.containsKey('isAvatarCircle'))
      _isCircleAvatar = json['isAvatarCircle'];
    // avatar header image
    if (json.containsKey('headerImage')) {
      this._blogTheme.headerImage = json['headerImage'] == 'none'
          ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
          : json['headerImage'];
      if (!this._blogTheme.headerImage.contains('http'))
        this._blogTheme.headerImage =
            '${ApiHttpRepository.api}' + this._blogTheme.headerImage;
    }
    // blog isPrivate flag
    if (json.containsKey('isPrivate')) _isPrivate = json['isPrivate'];

    if (json.containsKey('isAvatarCircle')) {
      _isCircleAvatar = json['isAvatarCircle'];
      _isCircleBeforEdit = json['isAvatarCircle'];
    }

    // blog isPrimary flag
    if (json.containsKey('isPrimary')) _isPrimary = json['isPrimary'];

    // // blog list of posts
    // if (json.containsKey('posts')) {
    //   List<Map<String, dynamic>> parsedPosts =
    //       List<Map<String, dynamic>>.from(json['posts']);
    //   parsedPosts.map((post) {
    //     _posts.add(new Post.fromJson(post));
    //   });
    //   _postsCount = _posts.length;
    // }
    // // followed by blogs
    // if (json.containsKey('followedBy')) {
    //   List<Map<String, dynamic>> parsedBlogs =
    //       List<Map<String, dynamic>>.from(json['followedBy']);

    //   parsedBlogs.forEach((blogData) {
    //     _followedBy.add(new Blog.fromJson(blogData));
    //   });
    //   _followersCount = _followedBy.length;
    // }
    //  else
    //   throw Exception('missing required parameter "followedBy"');

    if (json.containsKey('blockedTumblrs')) {}

// blog theme
    if (json.containsKey('customApperance')) {
      Map<String, dynamic> customApperance =
          json['customApperance'] as Map<String, dynamic>;
      if (customApperance.containsKey('globalParameters')) {
        Map<String, dynamic> globalParameters =
            customApperance['globalParameters'] as Map<String, dynamic>;
        if (globalParameters.containsKey('backgroundColor')) {
          this._blogTheme.backgroundColor = globalParameters['backgroundColor'];
        }
      }
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();

    if (this._backGroundColor != null) {
      //data['customappearance'] = {};
      //data['customappearance']['globalparameters'] = {};
      //data['customappearance']['globalparameters']['backgroundcolor'] =
      //  this._backGroundColor;
    }
    if (this._description != null) data['description'] = this._description;

    if (this._handle != null) data['handle'] = this._handle;
    if (this._title != null) data['title'] = this._title;
    if (this._isPrimary != null) data['isPrimary'] = this._isPrimary.toString();
    //data['followedBy'] = convert.jsonEncode(this._followedBy);
    if (this._isPrivate != null) data['isPrivate'] = this._isPrivate.toString();
    if (this.isCircleAvatar != null)
      data['isAvatarCircle'] = this.isCircleAvatar.toString();

    return data;
  }

  Future<String> getBlogAvatar() async {
    final String endPoint = 'blog/';
    final Map<String, dynamic> reqParameters = {
      "blog-identifier": _title,
      "size": 64
    };
    try {
      final Map<String, dynamic> response =
          await apiClient.sendGetRequest(endPoint, query: reqParameters);
      if (response['statusCode'] == 200) {
        print(response['avatar_url']);
        return response['avatar_url'];
      } else {
        // handle failed request
        throw Exception(response.toString());
      }
    } catch (error) {
      // handle failed request
      logger.e(error);
//      throw Exception(error.message.toString());
    }
  }

  static Future<Blog> getInfo(String name) async {
    final String endPoint = 'blog/info';
    final Map<String, dynamic> reqParameters = {"blog-identifier": name};

    try {
      final Map<String, dynamic> response =
          await apiClient.sendGetRequest(endPoint, query: reqParameters);

      if (response['statuscode'] != 200) {
        logger.e('error happened ${response['body']['error']}');
      }

      return Blog.fromJson(response['body']['blog']);
    } catch (error) {
      logger.e(error.toString());
      return null;
    }
  }

  Future<bool> followBlog(String blogId, String token) async {
    final String endPoint = "api/user/follow";
    Map<String, dynamic> response =
        await apiClient.sendPostRequest(endPoint, headers: {
      'Authorization': token,
    }, reqBody: {
      '_id': blogId
    });
    if (response['statuscode'] != 200) {
      logger.e('error at comment ${response['body']}');
      return false;
    }
    return true;
  }

  Future<bool> followTag(String tagName, String token) async {
    final String endPoint = "api/user/follow-tag";
    Map<String, dynamic> response =
        await apiClient.sendPostRequest(endPoint, headers: {
      'Authorization': token,
    }, reqBody: {
      'tag': tagName,
    });
    if (response['statuscode'] != 200) {
      logger.e('error at comment ${response['body']}');
      return false;
    }
    return true;
  }

  void setTitleBeforeEdit(String title) {
    this._titleBeforeEdit = title;
  }

  void setDescriptionBeforEdit(String description) {
    this._descriptionBeforEdit = description;
  }

  void setIsCircleBeforEditing(bool isCircle) {
    this._isCircleBeforEdit = isCircle;
  }

  void setBackGroundColorBeforEditing(String color) {
    this._backGroundColorBeforEdit = color;
  }

  void getPosts() async {
    //final String url = 'blog/$name/posts/';
    try {} catch (error) {}
  }

  void blockBlog(String toBlock) async {
    //String url = 'blog/$name/blocks';
    try {} catch (error) {}
  }

  void setBlogAvatar(String avatar) {
    _blogAvatar = avatar;
  }

  void setBlogtitle(String title) {
    _title = title;
  }

  void setBlogDescription(String description) {
    _description = description;
  }

  void setBlogBackGroundColor(String color) {
    this._backGroundColor = color;
  }

  void setHeaderImage(String image) {
    blogTheme.headerImage = image;
  }

  void setAvatarShape(String shape) {
    blogTheme.avatarShape = shape;
  }

  String getAvatarShape() {
    return blogTheme.avatarShape;
  }

  String getHeaderImage() {
    return blogTheme.headerImage;
  }

  String getBlogDescription() {
    return _description;
  }

  void setIsCircleAvatar(bool isCircle) {
    _isCircleAvatar = isCircle;
  }

  bool getIsPrimary() {
    return _isPrimary;
  }

  void setShowAvatar(bool show) {
    this._showAvatar = show;
  }

  void setStrtchHeaderImage(bool stretch) {
    this._stretchHeaderImage = stretch;
  }

  Future pickImage(int indicator) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    logger.d(image.path);
    if (image == null) return;
    if (indicator == 1) this._blogAvatar = File(image.path).toString();
    if (indicator == 2) this._headerImage = File(image.path).toString();
  }

  ///Get Blog Posts
  Future<bool> blogPosts(BuildContext context) async {
    final String endPoint = 'blog/${this._id}/posts';

    print(endPoint);
    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    final response = await apiClient.sendGetRequest(endPoint, headers: headers);

    if (response['statusCode'] == 200) {
      logger.e(response['statusCode']);

      if (response['data'] != {}) {
        List<Map<String, dynamic>>.from(response['data']).map((postData) {
          try {
            logger.d(postData);
            this._posts.add(Post.fromJson(postData));
          } catch (e) {
            logger.e(e);
          }
        });
      }

      logger.d(response);
    } else {
      logger.e(response);
    }

    return true;
  }

  //convert hexcolor to Color

  void updateBlog(BuildContext context) async {
    final String endPoint = 'api/blog/${this._id}';
    final Map<dynamic, dynamic> body = this.toJson();

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    final response = await apiClient.sendPutRequest(endPoint, headers, body);

    print('${ApiHttpRepository.api}api/blog/${this._id}');

    if (response.statusCode == 200) {
      print(response.statusCode);
    }
  }

  void blogRetrive(BuildContext context) async {
    final String endPoint = 'blog/${this._handle}';

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };
    final response = await apiClient.sendGetRequest(endPoint, headers: headers);

    if (response['statusCode'] == 200) {
      if (response.containsKey('globalParameters')) {
        if (response['globalParameters'].containsKey('backgroundColor')) {
          this._backGroundColor =
              response['globalParameters']['backgroundColor'];
        }
        if (response['globalParameters'].containsKey('showAvatar')) {
          this._showAvatar = response['globalParameters']['showAvatar'];
        }
        if (response['globalParameters'].containsKey('showHeaderImage')) {
          this._showHeadeImage =
              response['globalParameters']['showHeaderImage'];
        }
        if (response['globalParameters'].containsKey('stretchHeaderImage')) {
          this._stretchHeaderImage =
              response['globalParameters']['stretchHeaderImage'];
        }
      }

      //print(responseObject);
    } else {
      logger.e(response['statusCode']);
    }
  }
}
