/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for video block content
*/

import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_blocks/video_player_widget.dart';
import 'package:tumblrx/models/posts/block_media.dart';
import 'package:tumblrx/models/posts/block_poster.dart';

class VideoBlock {
  /// Type of the block 'video'
  String type;

  /// Media object of the block
  Media media;

  /// Provider name: tumblrx, youtube, or vimeo
  String provider;

  /// An image media object to use as a "poster" for the video
  List<Poster> poster = [];

  /// Whether this video can be played on a cellular connection
  bool canAutoplayOnCellular;

  VideoBlock(
      {this.type,
      this.media,
      this.provider,
      this.poster,
      this.canAutoplayOnCellular});

  /// Constructs a new instance usin parsed json data
  VideoBlock.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    if (json['poster'] != null) {
      json['poster'].forEach((v) {
        poster.add(new Poster.fromJson(v));
      });
    }

    canAutoplayOnCellular = json['can_autoplay_on_cellular'];
  }

  /// Returns a JSON version of the object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.media != null) {
      data['media'] = this.media.toJson();
    }
    if (this.poster != null) {
      data['poster'] = this.poster.map((v) => v.toJson()).toList();
    }

    data['can_autoplay_on_cellular'] = this.canAutoplayOnCellular;
    return data;
  }

  /// API for video block object to render it
  Widget showBlock() {
    return VideoPlayerWidget(this.media.url, this.provider);
  }
}
