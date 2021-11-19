import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/models/posts/audio_block.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/link_block.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/video_block.dart';

class Post {
  String blogName; //The short name used to uniquely identify a blog
  int id; // The post's unique ID
  String gensisPostId; //The post's unique "genesis" ID† as a String
  String postUrl; // The location of the post
  DateTime date; //The GMT date and time of the post
  String reblogKey; //The key used to reblog this post
  List<String> tags; //Tags applied to the post
  String
      sourceUrl; //The URL for the source of the content (for quotes, reblogs, etc.)
  String sourceTitle; //The title of the source site
  bool liked; //Indicates if a user has already liked a post or not
  String state; // Indicates the current state of the post
  List content = []; //The content of the post.
  List layout = []; //The layout of the post content.
  List trail = []; //The reblog trail items, if any.

  Post({this.blogName, this.liked, this.content});
  Post.fromJson(Map<String, dynamic> parsedJson) {
    // identifiers
    blogName = parsedJson['blog_name'];
    id = parsedJson['id'];
    // post info
    date = parsedJson['date'];
    reblogKey = parsedJson['reblog_key'];
    tags = parsedJson['tags'];
    liked = parsedJson['liked'];
    state = parsedJson['state'];
    // post content
    parsePostContent(parsedJson['content']);
  }

  void parsePostContent(json) {
    json.forEach((obj) {
      switch (obj['type']) {
        case 'text':
          content.add(new TextBlock.fromJson(obj));
          break;
        case 'audio':
          content.add(new AudioBlock.fromJson(obj));
          break;
        case 'video':
          content.add(new VideoBlock.fromJson(obj));
          break;
        case 'image':
          content.add(new ImageBlock.fromJson(obj));
          break;
        case 'link':
          content.add(new LinkBlock.fromJson(obj));
          break;
        default:
      }
    });
  }

  Column showPost() {
    return Column(
      children: [
        PostHeader(),
        Divider(),
        Column(
          children: content.map<Widget>((block) => block.showBlock()).toList(),
        ),
        Divider(),
        PostFooter(584, true),
      ],
    );
  }
}
