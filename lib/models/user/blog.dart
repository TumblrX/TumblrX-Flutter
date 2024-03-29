import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumblrx/services/authentication.dart';
import 'blog_theme.dart';
import 'package:http_parser/http_parser.dart';

///This class handles all blog details and contains all blog data
class Blog {
  /// The user's tumblr short name
  String _handle;

  /// The display title of the blog
  String _title;

  /// The id of the blog
  String _id;

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

  /// list of posts of this blog
  List<Post> _posts = [];

  /// flag to determine avatar shape
  bool _isCircleAvatar;

  ///background color
  String _backGroundColor;

  ///check if show avatar or not
  bool _showAvatar;

  ///show header image
  bool _showHeadeImage;

  ///strech header image
  bool _stretchHeaderImage;

  ///title before Edit
  String _titleBeforeEdit;

  ///decription before Edit
  String _descriptionBeforEdit;

  ///isCircleAvatar
  bool _isCircleBeforEdit;

  ///Color before editing
  String _backGroundColorBeforEdit;

  ///title color
  String _titleColor;

  ///user id
  String _ownerId;

  ///for chooes avatar in gallery
  XFile avatarPick;

  ///for chooes header image in gallery
  XFile headerImagePick;

  /// themes of Blog
  BlogTheme _blogTheme = BlogTheme();

  /// getter in blog class
  String get blogAvatar => _blogAvatar;
  String get handle => _handle;
  String get title => _title;
  String get headerImage => _headerImage;
  String get titleColor => _titleColor;
  String get ownerId => _ownerId;
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

  ///constructor of blog
  Blog(
      [this._handle,
      this._title,
      this._isPrivate,
      this._isPrimary,
      this._blogAvatar]);

  ///from json convert json file to blog
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
          ? 'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
          : json['avatar'].startsWith('http')
              ? json['avatar']
              : ApiHttpRepository.api + json['avatar'];
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

    ///headerImage
    if (json.containsKey('headerImage')) {
      _headerImage = json['headerImage'] == 'none'
          ? 'https://assets.tumblr.com/images/default_header/optica_pattern_10_focused_v3.png'
          : json['headerImage'].startsWith('http')
              ? json['headerImage']
              : ApiHttpRepository.api + json['headerImage'];
    }

    // blog isPrivate flag
    if (json.containsKey('isPrivate')) _isPrivate = json['isPrivate'];

    if (json.containsKey('isAvatarCircle')) {
      _isCircleAvatar = json['isAvatarCircle'];
      _isCircleBeforEdit = json['isAvatarCircle'];
    }

    /// blog isPrimary flag
    if (json.containsKey('isPrimary')) _isPrimary = json['isPrimary'];

    if (json.containsKey('globalParameters')) {
      if (json['globalParameters'].containsKey('backgroundColor'))
        this._backGroundColor = json['globalParameters']['backgroundColor'];

      if (json['globalParameters'].containsKey('showAvatar')) {
        this._showAvatar = json['globalParameters']['showAvatar'];
      }
      if (json['globalParameters'].containsKey('showHeaderImage')) {
        this._showHeadeImage = json['globalParameters']['showHeaderImage'];
      }
      if (json['globalParameters'].containsKey('stretchHeaderImage')) {
        this._stretchHeaderImage =
            json['globalParameters']['stretchHeaderImage'];
      }
      if (json['globalParameters'].containsKey('backgroundColor')) {
        this._backGroundColor = json['globalParameters']['backgroundColor'];
      }
      if (json['globalParameters'].containsKey('titleColor')) {
        this._titleColor = json['globalParameters']['titleColor'];
      }
    }
  }

  ///convert blog to json file
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();

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

  ///get avatar from data base
  Future<String> getBlogAvatar() async {
    final String endPoint = 'blog/';
    final Map<String, dynamic> reqParameters = {
      "blog-identifier": _title,
      "size": 64
    };
    try {
      final Map<String, dynamic> response =
          await apiClient.sendGetRequest(endPoint, query: reqParameters);
      if (response['statuscode'] == 200) {
        print(response['avatar_url']);
        return response['avatar_url'];
      } else {
        // handle failed request
        throw Exception(response.toString());
      }
    } catch (error) {
      // handle failed request
      logger.e(error);
    }
    return null;
  }

  void setBlogId(String id) {
    this._id = id;
  }

  ///Follow another blog request
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

  ///saves title before edit
  void setTitleBeforeEdit(String title) {
    this._titleBeforeEdit = title;
  }

  ///saves description before edit
  void setDescriptionBeforEdit(String description) {
    this._descriptionBeforEdit = description;
  }

  ///saves avatar shape before edoting
  void setIsCircleBeforEditing(bool isCircle) {
    this._isCircleBeforEdit = isCircle;
  }

  ///saves color before editing
  void setBackGroundColorBeforEditing(String color) {
    this._backGroundColorBeforEdit = color;
  }

  ///Sets blog avatar
  void setBlogAvatar(String avatar) {
    _blogAvatar = avatar;
  }

  ///Sets Blog title
  void setBlogtitle(String title) {
    _title = title;
  }

  ///Sets blog description
  void setBlogDescription(String description) {
    _description = description;
  }

  ///Sets Background Color
  void setBlogBackGroundColor(String color) {
    this._backGroundColor = color;
  }

  ///Sets Header Image
  void setHeaderImage(String image) {
    blogTheme.headerImage = image;
  }

  ///Sets Avatar shape
  void setAvatarShape(String shape) {
    blogTheme.avatarShape = shape;
  }

  ///Gets Avatar shape
  String getAvatarShape() {
    return blogTheme.avatarShape;
  }

  ///gets blog Header Image
  String getHeaderImage() {
    return blogTheme.headerImage;
  }

  ///Gets blog description
  String getBlogDescription() {
    return _description;
  }

  ///Sets if the blog avatar is circle
  void setIsCircleAvatar(bool isCircle) {
    _isCircleAvatar = isCircle;
  }

  ///gets if blog is primary
  bool getIsPrimary() {
    return _isPrimary;
  }

  ///returns blog posts
  Future<List<Post>> getBlogPosts() async {
    return _posts;
  }

  ///sets if show avatar is true
  void setShowAvatar(bool show) {
    this._showAvatar = show;
  }

  ///sets if the header image is strecth
  void setStrtchHeaderImage(bool stretch) {
    this._stretchHeaderImage = stretch;
  }

  ///uploads image for blog avatar or header image
  Future pickImage(int indicator) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    logger.d(image.path.toString());
    if (image == null) return null;
    if (indicator == 1) avatarPick = image;
    if (indicator == 2) headerImagePick = image;
  }

  ///Get Blog Posts from data base
  Future<List<Post>> blogPosts(BuildContext context, bool flag) async {
    this._posts = [];
    final String endPoint = 'blog/${this._id}/posts';

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    final response = await apiClient.sendGetRequest(endPoint, headers: headers);
    logger.d(response);
    List<Post> posts = [];
    if (response['statuscode'] == 200) {
      if (response['data'] != {}) {
        posts =
            List<Map<String, dynamic>>.from(response['data']).map((postData) {
          try {
            logger.d(postData);
            return Post.fromJson(postData);
          } catch (e) {
            logger.e(e);
          }
        }).toList();
      } else {
        logger.e('retrieve data is empty');
      }
    } else {
      logger.e(response);
    }
    if (flag) this._posts = posts ?? [];
    return posts;
  }

  ///updates blog by sending getBlog info request to back-end
  void updateBlog(BuildContext context) async {
    final String endPoint = 'api/blog/${this._id}';
    final Map<dynamic, dynamic> body = this.toJson();

    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    final response = await apiClient.sendPutRequest(endPoint, headers, body);

    if (response.statusCode == 200) {
      print(response.statusCode);
    }
  }

  ///this function send get request and get blog's information
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
    final response = await apiClient.sendGetRequest(endPoint, headers: headers);
    logger.d(response);
    if (response['statuscode'] == 200) {
//      return Blog.fromJson(response);

      if (response.containsKey('_id'))
        this._id = response['_id'];
      else
        throw Exception('missing required parameter "_id"');
      // blog title
      if (response.containsKey('title')) {
        _title = response['title'];
        _titleBeforeEdit = response['title'];
      }
      if (response.containsKey('ownerId')) {
        _ownerId = response['ownerId'];
      }

      if (response.containsKey('handle')) {
        this._handle = response['handle'];
      }
      if (response.containsKey('description')) {
        _description = response['description'];
        _descriptionBeforEdit = response['description'];
      }
      if (response.containsKey('isPrimary')) _isPrimary = response['isPrimary'];

      if (response.containsKey('avatar')) {
        _blogAvatar = response['avatar'] == 'none'
            ? ApiHttpRepository.api +
                "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg"
            : response['avatar'];
      }
      if (response.containsKey('headerImage')) {
        _headerImage = response['headerImage'] == 'none'
            ? "https://assets.tumblr.com/images/default_header/optica_pattern_11.png"
            : response['headerImage'];
      }
      if (response.containsKey('isAvatarCircle')) {
        this._isCircleAvatar = response['isAvatarCircle'];
      }
      if (response.containsKey('globalParameters')) {
        if (response['globalParameters'].containsKey('backgroundColor')) {
          this._backGroundColor =
              response['globalParameters']['backgroundColor'];
          this._backGroundColorBeforEdit = this._backGroundColor;
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
        if (response['globalParameters'].containsKey('backgroundColor')) {
          this._backGroundColor =
              response['globalParameters']['backgroundColor'];
        }
        if (response['globalParameters'].containsKey('titleColor')) {
          this._titleColor = response['globalParameters']['titleColor'];
        }
      }

      return this;
    } else {
      logger.e(response['statuscode']);
      return null;
    }
  }

  ///this function send put request and update blog theme
  Future<void> updateBlogTheme(BuildContext context) async {
    final String endPoint = 'api/blog/edit-theme/${this._handle}';
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();

    if (this._backGroundColor != null)
      data['backgroundColor'] = this._backGroundColor;
    data['avatar'] = "none";

    if (this._stretchHeaderImage != null)
      data['stretchHeaderImage'] = this._stretchHeaderImage.toString();
    if (this._showAvatar != null)
      data['showAvatar'] = this._showAvatar.toString();

    logger.d('hellloo');
    try {
      var dio = Dio();
      dio.options.headers["Authorization"] =
          Provider.of<Authentication>(context, listen: false).token;

      dio.options.headers['content-Type'] = 'application/json';

      Map<String, dynamic> requestBody = {
        'backgroundColor': this._backGroundColor,
        'stretchHeaderImage': this._stretchHeaderImage.toString(),
        'showAvatar': this._showAvatar.toString(),
      };

      if (avatarPick != null)
        requestBody['avatar'] = await MultipartFile.fromFile(avatarPick.path,
            filename: avatarPick.name, contentType: MediaType("image", "jpeg"));
      if (headerImagePick != null)
        requestBody['headerImage'] = await MultipartFile.fromFile(
            headerImagePick.path,
            filename: headerImagePick.name,
            contentType: MediaType("image", "jpeg"));

      var formData = FormData.fromMap(requestBody);
      final response =
          await dio.put(ApiHttpRepository.api + endPoint, data: formData);
      logger.d(response);
      this._blogAvatar =
          response.data['updatedBlog']['avatar'].startsWith('http')
              ? response.data['updatedBlog']['avatar']
              : ApiHttpRepository.api + response.data['updatedBlog']['avatar'];

      this._headerImage = response.data['updatedBlog']['headerImage']
              .startsWith('http')
          ? response.data['updatedBlog']['headerImage']
          : ApiHttpRepository.api + response.data['updatedBlog']['headerImage'];
    } catch (e) {
      logger.e(e);
    }
  }
}
