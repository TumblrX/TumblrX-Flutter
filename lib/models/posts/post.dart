/*
Description: 
    A class that serves as an API for post objects with 
    like/unlike, comment, reblog, share, edit and delete funcitonalities.
    
    Also it contains functions to construct the object from JSON
    in addition to build the post widget for rendering
*/

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/create_post.dart';
import 'package:tumblrx/components/post/post_blocks/image_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/link_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/text_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/video_block_widget.dart';
import 'package:tumblrx/components/post/reblogged_post_header.dart';
import 'package:tumblrx/components/post/tags_widget.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/link_block.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/video_block.dart';
import 'package:intl/intl.dart';
import 'package:tumblrx/services/api_provider.dart';

import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/services/creating_post.dart';

class Post {
  /// The short name used to uniquely identify a blog
  String _blogTitle;

  String _blogHandle;

  String _blogAvatar;

  bool _isAvatarCircle;

  /// Post's unique id
  String _id;

  String _blogId;

  /// The location of the post
  String _postUrl;

  /// The GMT date and time of the post
  DateTime _date;

  /// The key used to reblog this post
  String _reblogKey;

  /// Tags applied to the post
  List<String> _tags = [];

  /// Flag for like/unlike
  bool _liked;

  /// Flag for followed/unfollowed
  bool _isFollowed;

  ///
  bool _isReblogged;

  ///  the current state of the post
  String _state;

  String _postType;

  /// The content of the post
  List _content = [];

  ///Original back-end form post content
  List<Map<String, dynamic>> unmappedPostContent = [];

  /// The layout of the post content.
  List _layout = [];

  /// The reblog trail items, if any.
  List _trail = [];

  /// total number of notes
  int _totalNotes = 0;

  /// number of comments on the post
  int _commentsCount = 0;

  /// number of likes on the post
  int _likesCount = 0;

  /// number of reblogs on the post
  int _reblogsCount = 0;

  Post({@required bool liked, @required List content})
      : _liked = liked,
        _content = content;

// ================= getters ===================
  String get id => this._id;
  bool get liked => this._liked;
  bool get isFollowed => this._isFollowed;
  bool get isReblogged => this._isReblogged;
  bool get isAvatarCircle => this._isAvatarCircle;
  int get likesCount => this._likesCount;
  int get commentsCount => this._commentsCount;
  int get reblogsCount => this._reblogsCount;
  int get totalNotes => this._totalNotes;
  List get tags => this._tags;
  List get content => this._content;
  String get blogTitle => this._blogTitle;
  String get postType => this._postType;
  String get blogHandle => this._blogHandle;
  String get blogAvatar => this._blogAvatar;
  String get blogId => this._blogId;
  String get reblogKey => this._reblogKey;
  DateTime get publishedOn => _date;
  String get postUrl => _postUrl;
  List get postLayout => this._layout;
  List get postTrail => this._trail;

  set liked(bool liked) {
    this._liked = liked;
  }

  /// Constructs a new instance usin parsed json data
  Post.fromJson(Map<String, dynamic> parsedJson) {
    logger.d(parsedJson.toString());
    // ==================== post related data =========================
    // post identifier '_id'

    if (parsedJson.containsKey('_id'))
      this._id = parsedJson['_id'];
    else
      throw Exception('missing required paramter "_id"');

    _postUrl = 'http://www.tumblrx.me:5000/post/$id';

    // post type
    if (parsedJson.containsKey('postType'))
      this._postType = parsedJson['postType'];
    else
      throw Exception('missing required parameter "postType"');

    // post state ('published, draft, queued)
    if (parsedJson.containsKey('state'))
      this._state = parsedJson['state'];
    else
      throw Exception('missing required paramter "state"');

    // post publishing data
    if (parsedJson.containsKey('publishedOn')) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(parsedJson['publishedOn'] * 1000);
      this._date = DateFormat('yyyy-MM-dd hh:mm').parse(dateTime.toString());
    } else if (this._state != 'draft')
      throw Exception('missing required paramter "publishedOn"');

    // post reblog key
    if (parsedJson.containsKey('reblog_key') &&
        parsedJson['reblog_key'].toString().trim().isNotEmpty)
      _reblogKey = parsedJson['reblog_key'];

    // post flag liked (true => user likes, false => user unlikes)
    if (parsedJson.containsKey('liked'))
      _liked = parsedJson['liked'];
    else
      _liked = false;
    if (parsedJson.containsKey('isFollowed'))
      _isFollowed = parsedJson['isFollowed'];
    else
      _isFollowed = true;

    if (parsedJson.containsKey('isRebloged'))
      _isReblogged = parsedJson['isRebloged'];
    else
      _isReblogged = false;
    // number of comments on the post
    if (parsedJson.containsKey('commentsCount'))
      this._commentsCount = parsedJson['commentsCount'];

    // number of likes on the post
    if (parsedJson.containsKey('likesCount'))
      this._likesCount = parsedJson['likesCount'];

    // number of reblogs on the post
    if (parsedJson.containsKey('reblogsCount'))
      this._reblogsCount = parsedJson['reblogsCount'];

    // calculating total number of notes for viewing purposes
    this._totalNotes = (this._commentsCount ?? 0) +
        (this._likesCount ?? 0) +
        (this._reblogsCount ?? 0);

    List<dynamic> parsedTags = List<dynamic>.from(parsedJson['tags']);
    // post tags
    if (parsedJson.containsKey('tags')) {
      for (var i = 0; i < parsedTags.length; i++)
        this._tags.add(parsedJson['tags'][i].toString());
    }

    // post content
    if (parsedJson.containsKey('content')) {
      unmappedPostContent = (parsedJson['content'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList(); //keeping original json data to be used in edit post
      parsePostContent(List<Map<String, dynamic>>.from(parsedJson['content']));
    } else
      throw Exception('missing required paramter "content"');

    // ========================= post blog data ========================

    if (!parsedJson.containsKey('blogAttribution'))
      throw Exception('missing required paramter "blogAttribution"');
    Map<String, dynamic> blogData =
        parsedJson['blogAttribution'] as Map<String, dynamic>;

    // blog identifier '_id'
    if (blogData.containsKey('_id'))
      this._blogId = blogData['_id'];
    else
      throw Exception('missing required paramter "_id" in blogAttribution');

    // blog title
    if (blogData.containsKey('title')) this._blogTitle = blogData['title'];
    // blog handle
    if (blogData.containsKey('handle')) this._blogHandle = blogData['handle'];
    // blog avatar url
    if (blogData.containsKey('avatar')) {
      this._blogAvatar = blogData['avatar'] == 'none'
          ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
          : blogData['avatar'];
      if (!_blogAvatar.contains('http'))
        _blogAvatar = '${ApiHttpRepository.api}$_blogAvatar';
    }
    // blog avatar shape flag (true => circular, false => rectangular)
    if (blogData.containsKey('isAvatarCircle'))
      this._isAvatarCircle = blogData['isAvatarCircle'];
  }

  /// Construct the right block for each of the Post content
  /// Text, Audio, Video, Image, and Link
  void parsePostContent(List<Map<String, dynamic>> json) {
    List parsedConent = [];
    try {
      json.forEach((obj) {
        try {
          switch (obj['type'].toString().trim()) {
            case 'text':
              parsedConent.add(new TextBlock.fromJson(obj));
              break;
            case 'video':
              parsedConent.add(new VideoBlock.fromJson(obj));
              break;
            case 'image':
              parsedConent.add(new ImageBlock.fromJson(obj));
              break;
            case 'link':
              parsedConent.add(new LinkBlock.fromJson(obj));
              break;
            case 'audio':
              break;

            default:
              throw Exception("invalid post type");
          }
        } catch (err) {
          logger.e('couldn\'t parse $obj');
        }
      });

      this._content.addAll(parsedConent);
    } catch (error) {
      logger.e('err @parseContent $error');
    }
  }

  // ================= API ====================

  /// API for post object to like the post
  Future<bool> likePost(BuildContext context) async {
    final String endPoint = 'api/post/${this.id}/like';
    try {
      String token = Provider.of<Authentication>(context, listen: false).token;

      Map<String, String> headers = {'Authorization': token};
      final response =
          await apiClient.sendPostRequest(endPoint, headers: headers);

      if (response['statuscode'] != 200) {
        //logger.e('id is ${this.id}');
        //logger.e(response);
        return false;
      } else {
        this._liked = true;
        this._likesCount++;
        this._totalNotes++;
        return true;
      }
    } catch (error) {
      logger.e(Exception(error.message.toString()));
      return false;
    }
  }

  /// API for post object to unlike the post
  Future<bool> unlikePost(BuildContext context) async {
    final String endPoint = 'api/post/${this.id}/like';
    try {
      String token = Provider.of<Authentication>(context, listen: false).token;

      Map<String, String> headers = {'Authorization': token};
      final response = await apiClient.sendDeleteRequest(endPoint, headers);

      if (response['statuscode'] != 200) {
        logger.e(response);
        return false;
      } else {
        this._liked = false;
        this._likesCount--;

        this._totalNotes--;
        return true;
      }
    } catch (error) {
      logger.e(Exception(error.message.toString()));
      return false;
    }
  }

  /// API for post object to delete the post
  Future<bool> deletePost(BuildContext context, String token) async {
    final String endPoint = 'api/post/${this.id}';
    final Map<String, String> headers = {'Authorization': token};

    try {
      final response = await apiClient.sendDeleteRequest(endPoint, headers);

      if (response['statuscode'] != 200) {
        logger.d(response);
        throw Exception('post ID or reblog_key was not found');
      }
      return true;
    } catch (error) {
      logger.e(error);
      return false;
    }
  }

  /// API for post object to reblog the post
  void reblogPost(BuildContext context) async {
    double topPadding = MediaQuery.of(context).padding.top;
    Provider.of<CreatingPost>(context, listen: false)
        .initializePostOptions(context, reblog: true, rebloggedPost: this);
    !kIsWeb
        ? showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: CreatePost(
                topPadding: topPadding,
                isReblog: true,
              ),
            ),
          )
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: CreatePost(
                    topPadding: topPadding,
                    isReblog: true,
                  ),
                ));
  }

  /// API for post object to share the post
  void sharePost() async {
    try {} catch (error) {}
  }

  Future<bool> mutePushNotification() async {
    return false;
  }

  /// API for post object to edit the post
  void editPost(BuildContext context) async {
    double topPadding = MediaQuery.of(context).padding.top;
    logger.d(unmappedPostContent);
    Provider.of<CreatingPost>(context, listen: false).initializePostOptions(
        context,
        edit: true,
        editPostContent: unmappedPostContent,
        editPostId: id,
        editPostTags: _tags);
    !kIsWeb
        ? showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: CreatePost(
                topPadding: topPadding,
              ),
            ),
          )
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: CreatePost(
                    topPadding: topPadding,
                  ),
                ));
  }

  /// API for post object to fetch a post
  static Future<Post> fetchPost(String id) async {
    try {
      final String endPoint = 'posts/id=$id';
      final Map<String, dynamic> response =
          await apiClient.sendGetRequest(endPoint);
      if (response['statuscode'] != 200) {
        logger.e('error happened, ${response['body']['error']}');
      }
      return Post.fromJson(response['body']);
    } catch (error) {
      throw Exception(error.message);
    }
  }

  void navigateToTag(String tag) {}

  /// Shows a reblogged post view
  Container showRebloggedPost() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RebloggedPostHeader(blogAvatar: blogAvatar, blogTitle: blogTitle),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _content.map<Widget>(
              (block) {
                switch (block.runtimeType) {
                  case TextBlock:
                    return TextBlockWidget(
                      text: block.formattedText,
                      sharableText: block.text,
                    );
                    break;
                  case LinkBlock:
                    return LinkBlockWidget(
                        url: block.url, description: block.description);
                    break;
                  case ImageBlock:
                    return ImageBlockWidget(
                      media: block,
                    );
                    break;
                  case VideoBlock:
                    return VideoBlockWidget(
                      url: block.url,
                      provider: block.provider,
                    );
                    break;
                  default:
                    return Container(width: 0, height: 0);
                }
              },
            ).toList(),
          ),
          Divider(
            color: Colors.transparent,
          ),
          TagsWidget(_tags),
        ],
      ),
    );
  }
}
