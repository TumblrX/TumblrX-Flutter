/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for link block content
*/
import 'package:tumblrx/models/posts/block_poster.dart';

class LinkBlock {
  /// The URL to use for the link block
  String _url;

  String _type;

  /// The title of where the link goes.
  String _title;

  /// The description of where the link goes
  String _description;

  /// The author of the link's content
  String _author;

  /// An image media object to use as a "poster" for the link
  List<Poster> _poster = [];

  LinkBlock(
      {String url,
      String title,
      String description,
      String author,
      List<Poster> poster})
      : _url = url,
        _title = title,
        _description = description,
        _author = author,
        _poster = poster;

  String get url => _url;
  String get description => _description;

  /// Constructs a new instance usin parsed json data
  LinkBlock.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type') && json['type'].toString().trim().isNotEmpty)
      this._type = json['type'];
    else
      throw Exception('missing required parameter "type"');
    if (json.containsKey('url') && json['url'].toString().trim().isNotEmpty)
      this._url = json['url'];
    else
      throw Exception('missing required parameter "url"');
    if (json.containsKey('title')) this._title = json['title'];
    if (json.containsKey('description'))
      this._description = json['description'];
    if (json.containsKey('author')) this._author = json['author'];
    if (json.containsKey('poster') && json['poster'] != null) {
      json['poster'].forEach((v) {
        this._poster.add(new Poster.fromJson(v));
      });
    }
  }

  /// Returns a JSON version of the object

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['url'] = this._url;
    data['title'] = this._title;
    data['description'] = this._description;
    data['author'] = this._author;
    if (this._poster != null) {
      data['poster'] = this._poster.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
