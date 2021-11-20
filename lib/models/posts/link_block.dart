/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for link block content
*/
import 'package:flutter/widgets.dart';
import 'package:tumblrx/components/post/link_preview_widget.dart';
import 'package:tumblrx/models/posts/block_poster.dart';

class LinkBlock {
  /// Type of the block: 'link'
  String type;

  /// The URL to use for the link block
  String url;

  /// The title of where the link goes.
  String title;

  /// The description of where the link goes
  String description;

  /// The author of the link's content
  String author;

  /// An image media object to use as a "poster" for the link
  List<Poster> poster = [];

  LinkBlock(
      {this.type,
      this.url,
      this.title,
      this.description,
      this.author,
      this.poster});

  /// Constructs a new instance usin parsed json data
  LinkBlock.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    title = json['title'];
    description = json['description'];
    author = json['author'];
    if (json['poster'] != null) {
      json['poster'].forEach((v) {
        poster.add(new Poster.fromJson(v));
      });
    }
  }

  /// Returns a JSON version of the object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['title'] = this.title;
    data['description'] = this.description;
    data['author'] = this.author;
    if (this.poster != null) {
      data['poster'] = this.poster.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// API for link block object to render it
  Widget showBlock() {
    return Column(children: [
      LinkPreviewWidget(this.url),
      this.description == null ? Container() : Text(this.description),
    ]);
  }
}
