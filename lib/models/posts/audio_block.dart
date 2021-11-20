/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for audio block content
*/

import 'package:dartdoc/dartdoc.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/models/posts/block_media.dart';
import 'package:tumblrx/models/posts/block_poster.dart';

class AudioBlock {
  /// Type of the block 'audio'
  String type;

  /// The provider of the audio source, whether it's tumblr for
  ///  native audio or a trusted third party
  String provider;

  /// The title of the audio asset.
  String title;

  /// The artist of the audio asset.
  String artist;

  /// The URL to use for the audio block, if no media is present.
  String url;

  /// TML code that could be used to embed this audio track into a webpage.
  String embedHtml;

  /// A URL to the embeddable content to use as an iframe.
  String embedUrl;

  /// The Media Object to use for the audio block, if no url is present.
  Media media;

  /// An image media object to use as a "poster" for the audio track.
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

  /// Constructs a new instance usin parsed json data
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

  /// Returns a JSON version of the object
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

  /// API for audio block object to render it
  Widget showBlock() {
    return SizedBox();
  }
}
