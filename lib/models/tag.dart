class Tag {
  String _name;
  String _image;

  String get name => this._name;
  String get image => this._image;
  Tag.fromJson(Map<String, dynamic> data) {
    if (data.containsKey('name')) _name = data['name'];
    if (data.containsKey('image')) _image = data['image'];
  }
}
