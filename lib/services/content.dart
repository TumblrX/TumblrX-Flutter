import 'package:flutter/material.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/posts/image_block.dart';

class Content extends ChangeNotifier {
  List<Post> _posts = [
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        new ImageBlock.fromJson(
          {
            'type': "image",
            'media': [
              {
                "type": "image/gif",
                "url":
                    "https://media.giphy.com/media/7frSUXgbGqQPKNnJRS/giphy.gif",
              },
              {
                "type": "image/jpeg",
                "url":
                    "https://images.unsplash.com/photo-1597429554033-86c7f86d0cbe?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=800&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYzNzM0NjA1NQ&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1900",
                "width": 1900
              },
            ],
          },
        ),
        // new TextBlock.fromJson(
        //   {
        //     'text': "second text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
        //   },
        // ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        // new TextBlock.fromJson(
        //   {
        //     'text': "first text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
        //   },
        // ),
        // new TextBlock.fromJson(
        //   {
        //     'text': "second text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
        //   },
        // ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        // new TextBlock.fromJson(
        //   {
        //     'text': "first text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
        //   },
        // ),
        // new TextBlock.fromJson(
        //   {
        //     'text': "second text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
        //   },
        // ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        // new TextBlock.fromJson(
        //   {
        //     'text': "first text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
        //   },
        // ),
        // new TextBlock.fromJson(
        //   {
        //     'text': "second text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
        //   },
        // ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        // new TextBlock.fromJson(
        //   {
        //     'text': "first text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
        //   },
        // ),
        // new TextBlock.fromJson(
        //   {
        //     'text': "second text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
        //   },
        // ),
      ],
    ),
    new Post(
      blogName: "passant",
      liked: true,
      content: [
        // new TextBlock.fromJson(
        //   {
        //     'text': "first text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'bold'},
        //   },
        // ),
        // new TextBlock.fromJson(
        //   {
        //     'text': "second text from passant",
        //     'formatting': {'start': 16, 'end': 23, 'type': 'strikethrough'},
        //   },
        // ),
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
