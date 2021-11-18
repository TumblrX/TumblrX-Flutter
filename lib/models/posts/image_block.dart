import 'package:tumblrx/models/posts/block_media.dart';

class ImageBlock {
  String type;
  List<Media> media = [];

  ImageBlock({this.type, this.media});

  ImageBlock.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['media'] != null) {
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}