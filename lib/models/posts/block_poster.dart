/*
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

  Poster(this.type, this.url, {this.width = 540, this.height = 405});

  /// Constructs a new instance usin parsed json data
  Poster.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type'))
      type = json['type'];
    else
      throw Exception("missing required paramter 'type'");
    if (json.containsKey('url')) if (Uri.parse(json['url']).isAbsolute)
      url = json['url'];
    else
      throw Exception("invalid url");
    else
      throw Exception("missing required paramter 'url'");
    if (json.containsKey('wdith')) width = json['width'];
    if (json.containsKey('height')) height = json['height'];
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
