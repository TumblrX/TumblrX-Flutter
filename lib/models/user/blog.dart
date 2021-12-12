import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:tumblrx/models/post.dart';
import 'dart:convert' as convert;
import 'package:tumblrx/services/api_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'blog_theme.dart';

class Blog extends ChangeNotifier {
  /// The user's tumblr short name
  String _handle;

  /// The display title of the blog
  String _title;

  /// the URL of the blog
  String _url;

  /// indicate if posts are tweeted auto, Y, N
  String _tweet;

  /// indicate if posts are sent to facebook Y, N
  String _facebook;

  /// indicates if this is the user's primary blog, default=false
  bool _primary = false;

  /// total count of followers for this blog
  int _followersCount;

  /// list of blogs that follow this blog
  List<Blog> _followedBy;

  /// indicates whether a blog is private or not
  bool _isPrivate = false;

  /// indicates whether a blog is primary or not
  bool _isPrimary = false;

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
  List<Post> _posts;

  /// themes of Blog
  BlogTheme blogTheme;

  Blog(
      [this._handle,
      this._title,
      this._primary,
      this._followersCount,
      this._isPrivate,
      this._isPrimary,
      this._blogAvatar]);

  Blog.fromJson(Map<String, dynamic> json) {
    // blog handle
    print(json);
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
          ? ApiHttpRepository.api +
              "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg"
          : json['avatar'];
    }
    // blog isPrivate flag
    if (json.containsKey('isPrivate')) _isPrivate = json['isPrivate'];

    // blog isPrimary flag
    if (json.containsKey('isPrimary')) _isPrimary = json['isPrimary'];

    // blog list of posts
    if (json.containsKey('posts')) {
      List<Map<String, dynamic>> parsedPosts =
          List<Map<String, dynamic>>.from(json['posts']);
      parsedPosts.forEach((post) {
        _posts.add(new Post.fromJson(post));
      });
      _postsCount = _posts.length;
    }
    //else
    //   throw Exception('missing required parameter "posts"');
    //if (json.containsKey('description')) description = json['description'];

    // followed by blogs
    if (json.containsKey('followedBy')) {
      List<Map<String, dynamic>> parsedBlogs =
          List<Map<String, dynamic>>.from(json['followedBy']);

      parsedBlogs.forEach((blogData) {
        _followedBy.add(new Blog.fromJson(blogData));
      });
      _followersCount = _followedBy.length;
    }
    //  else
    //   throw Exception('missing required parameter "followedBy"');

    if (json.containsKey('blockedTumblrs')) {}
    // else
    //   throw Exception('missing required parameter "blockedTumblrs"');
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

  String get blogAvatar => _blogAvatar;
  String get handle => _handle;
  String get title => _title;

  Future<String> getBlogAvatar() async {
    final String endPoint = 'blog/';
    final Map<String, dynamic> reqParameters = {
      "blog-identifier": _title,
      "size": 64
    };
    try {
      final Response response =
          await MockHttpRepository.sendGetRequest(endPoint, req: reqParameters);
      if (response.statusCode == 200) {
        final responseParsed = convert.jsonDecode(response.body);

        print(responseParsed['avatar_url']);
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
    //final String url = 'blog/$name/posts/';
    try {} catch (error) {}
  }

  void blockBlog(String toBlock) async {
    //String url = 'blog/$name/blocks';
    try {} catch (error) {}
  }

  void setBlogAvatar(String avatar) {
    _blogAvatar = avatar;
    notifyListeners();
  }

  void setBlogBackGroundColor(String color) {
    blogTheme.backgroundColor = color;
    notifyListeners();
  }

  void setHeaderImage(String image) {
    blogTheme.headerImage = image;
    notifyListeners();
  }

  void setAvatarShape(String shape) {
    blogTheme.avatarShape = shape;
    notifyListeners();
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

  static Future pickImage(int indicator) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image.path);
    if (image == null) return;
    if (indicator == 1) Blog().setBlogAvatar(image.path);
    if (indicator == 2) Blog().setHeaderImage(image.path);
  }
}
