import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'dart:convert' as convert;
import 'package:tumblrx/services/api_provider.dart';
import 'package:image_picker/image_picker.dart';
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

  /// themes of Blog
  BlogTheme _blogTheme = BlogTheme();

  String get blogAvatar => _blogAvatar;
  String get handle => _handle;
  String get title => _title;
  String get id => _id;
  bool get isPrimary => _isPrimary;
  bool get isCircleAvatar => this._isCircleAvatar;

  BlogTheme get blogTheme => this._blogTheme;
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

    // blog handle
    if (json.containsKey('handle'))
      _handle = json['handle'];
    else
      throw Exception('missing required parameter "handle"');

    // blog title
    if (json.containsKey('title'))
      _title = json['title'];
    else
      throw Exception('missing required parameter "title"');

    if (json.containsKey('avatar')) {
      _blogAvatar = json['avatar'] == 'none'
          ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
          : json['avatar'];
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

    // blog isPrimary flag
    if (json.containsKey('isPrimary')) _isPrimary = json['isPrimary'];

    // blog list of posts
    if (json.containsKey('posts')) {
      List<Map<String, dynamic>> parsedPosts =
          List<Map<String, dynamic>>.from(json['posts']);
      parsedPosts.map((post) {
        _posts.add(new Post.fromJson(post));
      });
      _postsCount = _posts.length;
    }
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['handle'] = this._handle;
    data['title'] = this._title;
    data['isPrimary'] = this._isPrimary;
    data['followedBy'] = convert.jsonEncode(this._followedBy);
    data['isPrivate'] = this._isPrivate;
    return data;
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
    blogTheme.backgroundColor = color;
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

  static Future pickImage(int indicator) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    logger.d(image.path);
    if (image == null) return;
    if (indicator == 1) Blog().setBlogAvatar(image.path);
    if (indicator == 2) Blog().setHeaderImage(image.path);
  }
}
