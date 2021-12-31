import 'package:tumblrx/global.dart';

class ImageBlock {
  /// Type of the block: 'image'
  String _type;

  /// List of media objects in the block
  String _media;

  /// url source of the image
  String _url;

  /// width of the image block
  double _width;

  /// height of the image block
  double _height;

  /* getters */
  String get type => this._type;
  String get media => this._media;
  double get width => this._width;
  double get height => this._height;
  String get url => this._url;

  ImageBlock(
      {String type, String media, String url, double width, double height})
      : _type = type,
        _media = media,
        _url = url,
        _width = width,
        _height = height;

  /// Constructs a new instance using parsed json data
  ImageBlock.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type') && json['type'].toString().trim().isNotEmpty)
      this._type = json['type'];
    else
      throw Exception('missing reuiqred parameter "type"');

    if (json.containsKey('media') && json['type'].toString().trim().isNotEmpty)
      this._media = json['media'];
    else
      this._media = "image/jpeg";

    if (json.containsKey('url') && json['url'].toString().trim().isNotEmpty)
      this._url = json['url'];
    else
      throw Exception('missing required paramter "url"');

    if (json.containsKey('width') && json['width'] != null) {
      this._width = (json['width'] <= 0 ? 512 : json['width']);
      if (json['width'] <= 0) logger.e('width is less than 0');
    }

    if (json.containsKey('height') && json['height'] != null) {
      this._height = (json['height'] <= 0 ? 512 : json['height']);
      if (json['height'] <= 0) logger.e('height is less than 0');
    }
  }

  /// Returns a JSON version of the object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['media'] = this._media;
    data['url'] = this._url;

    if (_width != null) data['width'] = _width;
    if (_height != null) data['height'] = _height;

    return data;
  }
}
