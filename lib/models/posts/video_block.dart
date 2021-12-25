/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for video block content
*/

import 'package:tumblrx/models/posts/block_poster.dart';

class VideoBlock {
  /// Type of the block 'video'
  String type;

  /// Media object of the block
  String _media;

  /// Provider name: tumblrx, youtube, or vimeo
  String _provider;

  /// url link to video
  String _url;

  /// An image media object to use as a "poster" for the video
  List<Poster> poster;

  /// Whether this video can be played on a cellular connection
  bool canAutoplayOnCellular;

  String get url => this._url;
  String get provider => this._provider;

  VideoBlock(
      {this.type,
      String media,
      String url,
      String provider,
      this.poster,
      this.canAutoplayOnCellular})
      : _url = url,
        _provider = provider,
        _media = media;

  /// Constructs a new instance usin parsed json data
  VideoBlock.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type')) type = json['type'];
    if (json.containsKey('url'))
      _url = json['url'];
    else
      _url = "https://www.youtube.com/watch?v=s_3ak-4u43E";
    if (json.containsKey('provider'))
      _provider = json['provider'];
    else
      _provider = 'youtube';

    if (json.containsKey('media')) _media = json['media'];
    // if (json['poster'] != null) {
    //   json['poster'].forEach((v) {
    //     poster.add(new Poster.fromJson(v));
    //   });
    // }

    // canAutoplayOnCellular = json['can_autoplay_on_cellular'];
  }

  /// Returns a JSON version of the object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this._media != null) {
      data['media'] = this._media;
    }
    if (this.poster != null) {
      data['poster'] = this.poster.map((v) => v.toJson()).toList();
    }

    //data['can_autoplay_on_cellular'] = this.canAutoplayOnCellular;
    return data;
  }
}
