class Media {
  String _type;
  String _url;
  double _width;
  double _height;
  Media poster;
  Media(this._type, this._url,
      [this._width = 540, this._height = 405, this.poster]);

  Media.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _url = json['url'];
    _width = json['width'];
    _height = json['height'];
    if (json.containsKey('poster')) poster = Media.fromJson(json['poster']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['url'] = this._url;
    data['width'] = this._width;
    data['height'] = this._height;
    if (poster != null) data['poster'] = poster.toJson();
    return data;
  }

  String get url => _url;
  double get width => _width;
  double get height => _height;
}
