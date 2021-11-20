/*
Author: Passant Abdelgalil
Description: 
    This file creates a Poster class to define poster field in media
    objects that should be displayed for low-bandwidth consumers
*/
class Poster {
  /// Type of block: 'image/jpeg'
  String type;

  /// The canonical URL of the media asset
  String url;

  /// The width of the media asset, if that makes sense
  ///  (for images and videos, but not for audio)
  int width;

  /// The hdight of the media asset, if that makes sense
  ///  (for images and videos, but not for audio)
  int height;

  Poster({this.type, this.url, this.width, this.height});

  /// Constructs a new instance usin parsed json data
  Poster.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  /// Returns a JSON version of the object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = this.type;
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
