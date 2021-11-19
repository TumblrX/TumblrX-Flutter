import 'package:flutter/material.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/posts/text_block.dart';

class Content extends ChangeNotifier {
  List<Post> _posts = [
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        new TextBlock.fromJson(
          {
            'text': "first text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
          },
        ),
        new TextBlock.fromJson(
          {
            'text': "second text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
          },
        ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        new TextBlock.fromJson(
          {
            'text': "first text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
          },
        ),
        new TextBlock.fromJson(
          {
            'text': "second text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
          },
        ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        new TextBlock.fromJson(
          {
            'text': "first text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
          },
        ),
        new TextBlock.fromJson(
          {
            'text': "second text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
          },
        ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        new TextBlock.fromJson(
          {
            'text': "first text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
          },
        ),
        new TextBlock.fromJson(
          {
            'text': "second text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
          },
        ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        new TextBlock.fromJson(
          {
            'text': "first text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
          },
        ),
        new TextBlock.fromJson(
          {
            'text': "second text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
          },
        ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        new TextBlock.fromJson(
          {
            'text': "first text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
          },
        ),
        new TextBlock.fromJson(
          {
            'text': "second text from passant",
            'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
          },
        ),
      ],
    ),
  ];
  Content();
  Content.fromJson(Map<String, dynamic> parsedJson) {
    _posts = parsedJson['body'];
  }

  // return copy of the posts list
  List<Post> get posts => [..._posts];
}
