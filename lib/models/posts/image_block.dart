import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/media_preview_widget.dart';
import 'package:tumblrx/models/posts/block_media.dart';

class ImageBlock {
  /// Type of the block: 'image'
  String type;

  /// List of media objects in the block
  List<Media> media = [];

  ImageBlock({this.type, this.media});

  /// Constructs a new instance usin parsed json data
  ImageBlock.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type'))
      type = json['type'];
    else
      throw Exception('missing reuiqred parameter "type"');

    if (json.containsKey('media')) {
      try {
        json['media'].forEach((v) {
          media.add(new Media.fromJson(v));
        });
      } catch (error) {
        throw Exception(error);
      }
    } else
      throw Exception('missing required paramter "media"');
  }

  /// Returns a JSON version of the object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// API for image block object to render it
  Widget showBlock() {
    return Column(
      children: media != null
          ? media
              .map<Widget>((mediaObj) =>
                  MediaWidget(mediaObj.url, mediaObj.width, mediaObj.height))
              .toList()
          : Container(
              child: Center(
                child: Icon(Icons.error),
              ),
            ),
    );
  }
}
