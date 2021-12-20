/*
Author: Passant Abdelgalil
Description: 
    A class that serves as an API for post objects with 
    like/unlike, comment, reblog, share, edit and delete funcitonalities.
    
    Also it contains functions to construct the object from JSON
    in addition to build the post widget for rendering
*/

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/create_post.dart';
import 'package:tumblrx/components/post/post_blocks/audio_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/image_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/link_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/text_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/video_block_widget.dart';
import 'package:tumblrx/components/post/post_footer/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/components/post/reblogged_post_header.dart';
import 'package:tumblrx/components/post/tags_widget.dart';
import 'package:tumblrx/models/posts/audio_block.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/link_block.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/video_block.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:intl/intl.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'dart:convert' as convert;

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

  /// post's unique "genesis" ID† as a String
  String _gensisPostId;

  /// The location of the post
  String _postUrl;

  /// The GMT date and time of the post
  DateTime _date;

  /// The key used to reblog this post
  String _reblogKey;

  /// Tags applied to the post
  List<String> _tags = [];

  /// The URL for the source of the content (for quotes, reblogs, etc)
  String _sourceUrl;

  /// The title of the source site
  String _sourceTitle;

  /// Flag for like/unlike
  bool _liked;

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

  /// blog object who published this post
  Blog postBlog;

// ================= getters ===================
  String get id => this._id;
  int get likesCount => this._likesCount;
  int get commentsCount => this._commentsCount;
  int get reblogsCount => this._reblogsCount;
  int get totalNotes => this._totalNotes;
  List get tags => this._tags;
  List get content => this._content;
  String get blogTitle => this._blogTitle;
  String get blogAvatar => this._blogAvatar;
  String get reblogKey => this._reblogKey;
  DateTime get publishedOn => _date;
  String get postUrl => _postUrl;

  /// Constructs a new instance usin parsed json data
  Post.fromJson(Map<String, dynamic> parsedJson) {
    // ==================== post related data =========================
    // post identifier '_id'
    if (parsedJson.containsKey('_id'))
      this._id = parsedJson['_id'];
    else
      throw Exception('missing required paramter "_id"');

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

    if (parsedJson.containsKey('url'))
      _postUrl = parsedJson['url'];
    else
      _postUrl = 'https://google.com';
    // post flag liked (true => user likes, false => user unlikes)
    // if (parsedJson.containsKey('liked'))
    //   liked = parsedJson['liked'];
    // else
    //   throw Exception("missing required paramter liked");
    this._liked = true;

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
    if (blogData.containsKey('avatar'))
      this._blogAvatar = blogData['avatar'] == 'none'
          ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
          : blogData['avatar'];
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
            case 'audio':
              //parsedConent.add(new AudioBlock.fromJson(obj));
              break;
            case 'video':
              //parsedConent.add(new VideoBlock.fromJson(obj));
              break;
            case 'image':
              parsedConent.add(new ImageBlock.fromJson(obj));
              break;
            case 'link':
              //parsedConent.add(new LinkBlock.fromJson(obj));
              break;
            default:
              print(obj);
              throw Exception("invalid post type");
          }
        } catch (err) {
          print('couldn\'t parse $obj');
        }
      });
      this._content.addAll(parsedConent);
    } catch (error) {
      print('err @parseContent $error');
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
          await ApiHttpRepository.sendPostRequest(endPoint, headers: headers);

      if (response.statusCode != 200) {
        print('id is ${this.id}');
        print(response.body);
        throw Exception('post ID or reblog_key was not found');
      } else {
        this._liked = false;
        return true;
      }
    } catch (error) {
      throw Exception(error.message.toString());
    }
  }

  /// API for post object to unlike the post
  Future<bool> unlikePost(BuildContext context) async {
    final String endPoint = 'api/post/${this.id}/like';
    try {
      String token = Provider.of<Authentication>(context, listen: false).token;

      Map<String, String> headers = {'Authorization': token};
      final response =
          await ApiHttpRepository.sendDeleteRequest(endPoint, headers);

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception('post ID or reblog_key was not found');
      } else {
        this._liked = false;
        return true;
      }
    } catch (error) {
      throw Exception(error.message.toString());
    }
  }

  /// API for post object to delete the post
  Future<bool> deletePost(BuildContext context) async {
    final String endPoint = 'api/post/${this.id}';
    String token = Provider.of<Authentication>(context, listen: false).token;
    final Map<String, String> headers = {
      'Authorization':
          '${Provider.of<Authentication>(context, listen: false).token}'
    };

    try {
      final response =
          await ApiHttpRepository.sendDeleteRequest(endPoint, headers);

      if (response.statusCode != 200) {
        print(response.body);
        print('token is $token');
        throw Exception('post ID or reblog_key was not found');
      }
      return true;
    } catch (error) {
      print(error);
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

  void followBlog() async {
    try {} catch (error) {}
  }

  Future<bool> mutePushNotification() async {}

  /// API for post object to edit the post

  void editPost(BuildContext context) async {
    double topPadding = MediaQuery.of(context).padding.top;
    print(unmappedPostContent);
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
      final Response response =
          await MockHttpRepository.sendGetRequest(endPoint);
      if (response.statusCode != 200) throw Exception(response.body.toString());
      final resposeObject =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Post.fromJson(resposeObject);
    } catch (error) {
      throw Exception(error.message);
    }
  }

  void navigateToTag(String tag) {}

  /// API for post object to render the post
  Container showPost(int index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(index: index),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                content.map<Widget>((block) => block.showBlock()).toList(),
          ),
          Divider(
            color: Colors.transparent,
          ),
          TagsWidget(_tags),
          Divider(
            color: Colors.transparent,
          ),
          PostFooter(postIndex: index),
        ],
      ),
    );
  }

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
                    return VideoBlockWidget();
                    break;
                  case AudioBlock:
                    return AudioBlockWidget();
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
