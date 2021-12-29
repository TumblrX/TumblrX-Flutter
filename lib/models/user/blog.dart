import 'package:dio/dio.dart';
import 'package:dartdoc/dartdoc.dart';
import 'package:flutter/cupertino.dart';
//import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/post.dart';
import 'dart:convert' as convert;
import 'package:tumblrx/services/api_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumblrx/services/authentication.dart';
import 'blog_theme.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

//import 'package:http/http.dart' as http;
class Blog {
  /// The user's tumblr short name
  String _handle;

  /// The display title of the blog
  String _title;

  /// The id of the blog
  String _id;

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
  bool _isPrimary;

  /// url for avatar
  String _blogAvatar;

  ///url for headerImage
  String _headerImage;

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
  bool isCircleAvatar;
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

  String _backGroundColorBeforEdit;

  ///title color
  String _titleColor;

  ///user id
  String _ownerId;

  XFile avatarPick;
  XFile headerImagePick;

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
          ? ApiHttpRepository.api +
              "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg"
          : json['avatar'];
    }

    ///headerImage
    if (json.containsKey('headerImage')) {
      _headerImage = ApiHttpRepository.api + json['headerImage'] == 'none'
          ? ApiHttpRepository.api + "uploads/blog/defaultHeader.png"
          : json['headerImage'];
    }

    // blog isPrivate flag
    if (json.containsKey('isPrivate')) _isPrivate = json['isPrivate'];
    if (json.containsKey('isAvatarCircle')) {
      isCircleAvatar = json['isAvatarCircle'];
      _isCircleBeforEdit = json['isAvatarCircle'];
    }

    // blog isPrimary flag
    if (json.containsKey('isPrimary')) _isPrimary = json['isPrimary'];

    // followed by blogs
    if (json.containsKey('followedBy')) {
      List<Map<String, dynamic>> parsedBlogs =
          List<Map<String, dynamic>>.from(json['followedBy']);

      parsedBlogs.forEach((blogData) {
        _followedBy.add(new Blog.fromJson(blogData));
      });

      if (_followedBy != null) _followersCount = _followedBy.length;
    }
    //  else
    //   throw Exception('missing required parameter "followedBy"');

    if (json.containsKey('blockedTumblrs')) {}
    // else
    //   throw Exception('missing required parameter "blockedTumblrs"');
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

  String get blogAvatar => _blogAvatar;
  String get handle => _handle;
  String get title => _title;
  String get id => _id;
  bool get isPrimary => _isPrimary;
  List<Post> get posts => _posts;
  String get backGroundColor => _backGroundColor;
  bool get showAvatar => _showAvatar;
  bool get showHeadeImage => _showHeadeImage;
  bool get stretchHeaderImage => _stretchHeaderImage;
  String get titleBeforEdit => _titleBeforeEdit;
  String get descriptionBeforEdit => _descriptionBeforEdit;
  bool get isCircleBeforEdit => _isCircleBeforEdit;
  String get backGroundColorBeforEdit => _backGroundColorBeforEdit;
  String get headerImage => _headerImage;
  String get description => _description;
  String get titleColor => _titleColor;
  String get ownerId => _ownerId;
  Future<String> getBlogAvatar() async {
    final String endPoint = 'blog/';
    final Map<String, dynamic> reqParameters = {
      "blog-identifier": _title,
      "size": 64
    };
    try {
      final response = await MockHttpRepository.sendGetRequest(endPoint,
          queryParams: reqParameters);
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
      final response = await MockHttpRepository.sendGetRequest(endPoint,
          queryParams: reqParameters);
      if (response.statusCode != 200) throw Exception(response.body.toString());
      final parsedResponse = convert.jsonDecode(response.body);
      return Blog.fromJson(parsedResponse['blog']);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  void setBlogId(String id) {
    this._id = id;
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
    isCircleAvatar = isCircle;
  }

  bool getIsPrimary() {
    return this._isPrimary;
  }

  Future<List<Post>> getBlogPosts() async {
    return _posts;
  }

  void setShowAvatar(bool show) {
    this._showAvatar = show;
  }

  void setStrtchHeaderImage(bool stretch) {
    this._stretchHeaderImage = stretch;
  }

  Future pickImage(int indicator) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image.path.toString());
    if (image == null) return null;
    if (indicator == 1) avatarPick = image;
    if (indicator == 2) headerImagePick = image;
  }

  ///Get Blog Posts
  Future<List<Post>> blogPosts(BuildContext context) async {
    this._posts = [];
    final String endPoint = 'blog/${this._id}/posts';

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    final response =
        await ApiHttpRepository.sendGetRequest(endPoint, headers: headers);

    if (response.statusCode == 200) {
      final resposeObject =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      if (resposeObject['data'] != null) {
        List<Map<String, dynamic>> arr =
            List<Map<String, dynamic>>.from(resposeObject['data']);

        arr.forEach((data) {
          try {
            this._posts.add(new Post.fromJson(data));
          } catch (e) {
            print(e);
          }
        });
      }
      return this._posts;
    }

    return [];
  }

  //convert hexcolor to Color

  void updateBlog(BuildContext context) async {
    final String endPoint = 'api/blog/${this._id}';
    final Map<dynamic, dynamic> body = this.toJson();

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    final response =
        await ApiHttpRepository.sendPutRequest(endPoint, headers, body);

    if (response.statusCode == 200) {
      print(response.statusCode);
    }
  }

  Future<Blog> blogRetrive(BuildContext context) async {
    String endPoint;

    if (this._handle != null)
      endPoint = 'blog/${this._handle}';
    else
      endPoint = 'blog/${this._id}';
    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };
    final response =
        await ApiHttpRepository.sendGetRequest(endPoint, headers: headers);

    Map<String, dynamic> responseObject =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      //Blog.fromJson(responseObject);

      if (responseObject.containsKey('_id'))
        this._id = responseObject['_id'];
      else
        throw Exception('missing required parameter "_id"');
      // blog title
      if (responseObject.containsKey('title')) {
        _title = responseObject['title'];
        _titleBeforeEdit = responseObject['title'];
      }
      if (responseObject.containsKey('ownerId')) {
        _ownerId = responseObject['ownerId'];
      }

      if (responseObject.containsKey('handle')) {
        this._handle = responseObject['handle'];
      }
      if (responseObject.containsKey('description')) {
        _description = responseObject['description'];
        _descriptionBeforEdit = responseObject['description'];
      }
      if (responseObject.containsKey('isPrimary'))
        _isPrimary = responseObject['isPrimary'];

      if (responseObject.containsKey('avatar')) {
        _blogAvatar = responseObject['avatar'] == 'none'
            ? ApiHttpRepository.api +
                "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg"
            : responseObject['avatar'];
      }
      if (responseObject.containsKey('headerImage')) {
        _headerImage = responseObject['headerImage'] == 'none'
            ? "https://assets.tumblr.com/images/default_header/optica_pattern_11.png"
            : responseObject['headerImage'];
      }
      if (responseObject.containsKey('isAvatarCircle')) {
        this.isCircleAvatar = responseObject['isAvatarCircle'];
      }
      if (responseObject.containsKey('globalParameters')) {
        if (responseObject['globalParameters'].containsKey('backgroundColor')) {
          this._backGroundColor =
              responseObject['globalParameters']['backgroundColor'];
        }
        if (responseObject['globalParameters'].containsKey('showAvatar')) {
          this._showAvatar = responseObject['globalParameters']['showAvatar'];
        }
        if (responseObject['globalParameters'].containsKey('showHeaderImage')) {
          this._showHeadeImage =
              responseObject['globalParameters']['showHeaderImage'];
        }
        if (responseObject['globalParameters']
            .containsKey('stretchHeaderImage')) {
          this._stretchHeaderImage =
              responseObject['globalParameters']['stretchHeaderImage'];
        }
        if (responseObject['globalParameters'].containsKey('backgroundColor')) {
          this._backGroundColor =
              responseObject['globalParameters']['backgroundColor'];
        }
        if (responseObject['globalParameters'].containsKey('titleColor')) {
          this._titleColor = responseObject['globalParameters']['titleColor'];
        }
      }

      //print(responseObject);
      return this;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  void updateBlogTheme(BuildContext context) async {
    final String endPoint = 'api/blog/edit-theme/${this._handle}';
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();

    if (this._backGroundColor != null)
      data['backgroundColor'] = this._backGroundColor;
    data['avatar'] = "none";

    if (this._stretchHeaderImage != null)
      data['stretchHeaderImage'] = this._stretchHeaderImage.toString();
    if (this._showAvatar != null)
      data['showAvatar'] = this._showAvatar.toString();
    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };
    /////////////////////////////////////////////////////////////////////////////////
    var dio = Dio();
    dio.options.headers["Authorization"] =
        Provider.of<Authentication>(context, listen: false).token;
dio.options.headers['content-Type'] = 'application/json';
    var formData = FormData.fromMap({
      'backgroundColor': this._backGroundColor,
      'stretchHeaderImage': this._stretchHeaderImage.toString(),
      'showAvatar': this._showAvatar.toString(),
      'avatar': await MultipartFile.fromFile(avatarPick.path,
          filename: avatarPick.name, contentType: MediaType("image", "jpeg")),
      'headerImage': await MultipartFile.fromFile(headerImagePick.path,
          filename: headerImagePick.name, contentType: MediaType("image", "jpeg")),
    });
    final response = await dio.put(ApiHttpRepository.api + endPoint, data: formData);

    // var responseObject = convert.jsonDecode(response.body);
    //final response =
    //  await ApiHttpRepository.sendPutRequest(endPoint, headers, data);
    //if (response.statusCode == 200) {
    //print(response.statusCode);
  }
}
