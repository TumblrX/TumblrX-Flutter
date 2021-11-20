/*
Author: Passant Abdelgalil
Description: 
    This file creates a class as an API for media objects used for image
    blocks, all kinds of posters (GIF, video, etc), native audio, and
    native video
*/
class Media {
  /// The MIME type of the media asse
  String _type;

  /// The canonical URL of the media asset
  String _url;

  /// The width of the media asset, if that makes sense
  ///  (for images and videos, but not for audio)
  double _width;

  /// The height of the media asset, if that makes sense
  ///  (for images and videos, but not for audio)
  double _height;

  /// A poster media object to be displayed for low-bandwidth consumers
  Media poster;

  Media(this._type, this._url,
      [this._width = 540, this._height = 405, this.poster]);

  /// Constructs a new instance usin parsed json data
  Media.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _url = json['url'];
    _width = json['width'].toDouble();
    _height = json['height'].toDouble();
    if (json.containsKey('poster')) poster = Media.fromJson(json['poster']);
  }

  /// Returns a JSON version of the object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['url'] = this._url;
    data['width'] = this._width;
    data['height'] = this._height;
    if (poster != null) data['poster'] = poster.toJson();
    return data;
  }

  /// get url of the media object
  String get url => _url;

  /// get width of the media object frame
  double get width => _width;

  /// get height of the media object frame
  double get height => _height;
}
