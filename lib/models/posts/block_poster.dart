class Poster {
  String type;
  String url;
  int width;
  int height;

  Poster({this.type, this.url, this.width, this.height});

  Poster.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = this.type;
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
