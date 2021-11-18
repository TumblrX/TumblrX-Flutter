class TextBlock {
  String _subtype;
  String _text;
  List<InlineFormatting> _formatting;

  TextBlock.fromJson(Map<String, dynamic> parsedJson) {
    _text = parsedJson['text'];
    _subtype = parsedJson['subtype'];
    if (parsedJson['formatting'] != null) {
      _formatting.add(new InlineFormatting.fromJson(parsedJson['formatting']));
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['subtype'] = _subtype;
    data['text'] = _text;
    data['formatting'] = _formatting;
    return data;
  }

  String formatText() {
    for (var format in _formatting) {
      _text = format.applyFormat(_text);
    }
    return _text;
  }
}

class InlineFormatting {
  int start;
  int end;
  String type;
  String url;
  String hex;
  String blog_url;

  InlineFormatting({this.start, this.end, this.type});

  InlineFormatting.fromJson(Map<String, dynamic> parsedJson) {
    start = parsedJson['start'];
    end = parsedJson['end'];
    type = parsedJson['type'];
    if (parsedJson.containsKey('url')) url = parsedJson['url'];
    if (parsedJson.containsKey('hex')) url = parsedJson['hex'];

    if (parsedJson.containsKey('blog_url')) blog_url = parsedJson['blog_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['start'] = start;
    data['end'] = end;
    data['type'] = type;
    if (hex != null) data['hex'] = hex;
    if (url != null) data['url'] = url;
    if (blog_url != null) data['blog_url'] = blog_url;

    return data;
  }

  String applyFormat(String text) {
    int start = this.start;
    int end = this.end;
    String originalText = text.substring(start, end);
    String formattedText;
    switch (type) {
      case 'bold':
        formattedText = "<b>$originalText</b>";
        break;
      case 'italic':
        formattedText = "<italic>$originalText</italic>";
        break;
      case 'strikethrough':
        formattedText = "<strikethrough>$originalText</strikethrough>";
        break;
      case 'link':
        formattedText = "<link href=${this.url}>$originalText</link>";
        break;
      case 'color':
        formattedText = "<color text=\"${this.hex}\">$originalText</color>";
        break;
      case 'mention': // "uuid": , "name": , "url":
        formattedText =
            "<mention href=${this.blog_url}>$originalText</mention>";
        break;
      default:
        formattedText = originalText;
    }
    return text.replaceRange(start, end, formattedText);
  }
}