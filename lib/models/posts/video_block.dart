class VideoBlock {
  String type;
  Media media;
  List<Poster> poster = [];
  List<Poster> filmstrip = [];
  bool canAutoplayOnCellular;

  VideoBlock(
      {this.type,
      this.media,
      this.poster,
      this.filmstrip,
      this.canAutoplayOnCellular});

  VideoBlock.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    if (json['poster'] != null) {
      json['poster'].forEach((v) {
        poster.add(new Poster.fromJson(v));
      });
    }
    if (json['filmstrip'] != null) {
      json['filmstrip'].forEach((v) {
        filmstrip.add(new Poster.fromJson(v));
      });
    }
    canAutoplayOnCellular = json['can_autoplay_on_cellular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.media != null) {
      data['media'] = this.media.toJson();
    }
    if (this.poster != null) {
      data['poster'] = this.poster.map((v) => v.toJson()).toList();
    }
    if (this.filmstrip != null) {
      data['filmstrip'] = this.filmstrip.map((v) => v.toJson()).toList();
    }
    data['can_autoplay_on_cellular'] = this.canAutoplayOnCellular;
    return data;
  }
}

class Media {
  String type;
  String url;
  int height;
  int width;
  bool hd;

  Media({this.type, this.url, this.height, this.width, this.hd});

  Media.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    height = json['height'];
    width = json['width'];
    hd = json['hd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['height'] = this.height;
    data['width'] = this.width;
    data['hd'] = this.hd;
    return data;
  }
}

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
