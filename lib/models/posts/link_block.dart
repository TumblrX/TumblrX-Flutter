import 'package:flutter/widgets.dart';
import 'package:tumblrx/components/post/link_preview_widget.dart';
import 'package:tumblrx/models/posts/block_poster.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

class LinkBlock {
  String type;
  String url;
  String title;
  String description;
  String author;
  List<Poster> poster = [];

  LinkBlock(
      {this.type,
      this.url,
      this.title,
      this.description,
      this.author,
      this.poster});

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

  Widget showBlock() {
    return Column(children: [
      LinkPreviewWidget(this.url),
      this.description == null ? Container() : Text(this.description),
    ]);
  }
}
