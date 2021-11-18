import 'package:tumblrx/models/posts/block_media.dart';
import 'package:tumblrx/models/posts/block_poster.dart';

class AudioBlock {
  String type;
  String provider;
  String title;
  String artist;
  String url;
  String embedHtml;
  String embedUrl;
  Media media;
  List<Poster> poster;

  AudioBlock(
      {this.type,
      this.provider,
      this.title,
      this.artist,
      this.url,
      this.embedHtml,
      this.embedUrl,
      this.media,
      this.poster});

  AudioBlock.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    provider = json['provider'];
    title = json['title'];
    artist = json['artist'];
    url = json['url'];
    embedHtml = json['embed_html'];
    embedUrl = json['embed_url'];
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    if (json['poster'] != null) {
      json['poster'].forEach((v) {
        poster.add(new Poster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['provider'] = this.provider;
    data['title'] = this.title;
    data['artist'] = this.artist;
    data['url'] = this.url;
    data['embed_html'] = this.embedHtml;
    data['embed_url'] = this.embedUrl;
    if (this.media != null) {
      data['media'] = this.media.toJson();
    }
    if (this.poster != null) {
      data['poster'] = this.poster.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
