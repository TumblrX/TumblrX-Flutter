import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/video_player_widget.dart';
import 'package:tumblrx/models/posts/block_media.dart';
import 'package:tumblrx/models/posts/block_poster.dart';

class VideoBlock {
  String type;
  Media media;
  String provide;
  List<Poster> poster = [];
  List<Poster> filmstrip = [];
  bool canAutoplayOnCellular;

  VideoBlock(
      {this.type,
      this.media,
      this.provide,
      this.poster,
      this.filmstrip,
      this.canAutoplayOnCellular});

  VideoBlock.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    if (json['poster'] != null) {
      json['poster'].forEach((v) {
        poster.add(new Poster.fromJson(v));
      });
    }
    if (json['filmstrip'] != null) {
      json['filmstrip'].forEach((v) {
        filmstrip.add(new Poster.fromJson(v));
      });
    }
    canAutoplayOnCellular = json['can_autoplay_on_cellular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.media != null) {
      data['media'] = this.media.toJson();
    }
    if (this.poster != null) {
      data['poster'] = this.poster.map((v) => v.toJson()).toList();
    }
    if (this.filmstrip != null) {
      data['filmstrip'] = this.filmstrip.map((v) => v.toJson()).toList();
    }
    data['can_autoplay_on_cellular'] = this.canAutoplayOnCellular;
    return data;
  }

  Widget showBlock() {
    return VideoPlayerWidget(this.media.url, this.provide);
  }
}
