class InlineFormatting implements Comparable<InlineFormatting> {
  int start;
  int end;
  String type;
  String url;
  String hex;
  String blogUrl;

  InlineFormatting(
      {this.start, this.end, this.type, this.url, this.blogUrl, this.hex});

  @override
  String toString() {
    return 'start: $start, end: $end, type: $type';
  }

  void setHexColor(String hexValue) {
    hex = hexValue;
  }

  InlineFormatting.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson.containsKey('start'))
      this.start = parsedJson['start'];
    else
      throw Exception('missing required parameter "start"');
    if (parsedJson.containsKey('end'))
      this.end = parsedJson['end'];
    else
      throw Exception('missing required parameter "end"');
    if (parsedJson.containsKey('type'))
      this.type = parsedJson['type'];
    else
      throw Exception('missing required parameter "type"');

    if (parsedJson.containsKey('url')) this.url = parsedJson['url'];
    if (parsedJson.containsKey('hex')) this.hex = parsedJson['hex'];

    if (parsedJson.containsKey('blog_url'))
      this.blogUrl = parsedJson['blog_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['start'] = start;
    data['end'] = end;
    data['type'] = type;
    if (hex != null) data['hex'] = hex;
    if (url != null) data['url'] = url;
    if (blogUrl != null) data['blog_url'] = blogUrl;

    return data;
  }

  List applyFormat(String text) {
    int start = this.start;
    int end = this.end + 1;

    int leftPadding, rightPadding = 0;
    String originalText = text.substring(start, end);
    String formattedText;
    switch (type) {
      case 'bold':
        formattedText = "<bold>$originalText</bold>";
        leftPadding = 6;
        rightPadding = 7;
        break;
      case 'italic':
        formattedText = "<italic>$originalText</italic>";
        leftPadding = 8;
        rightPadding = 9;
        break;
      case 'strikethrough':
        formattedText = "<strikethrough>$originalText</strikethrough>";
        leftPadding = 15;
        rightPadding = 16;
        break;
      case 'link':
        formattedText = "<link href=${this.url}>$originalText</link>";
        leftPadding = 11 + this.url.length;
        rightPadding = 7;
        break;
      case 'color':
        formattedText = '<color text="${this.hex}">$originalText</color>';
        leftPadding = 15 + this.hex.length;
        rightPadding = 8;
        break;
      case 'mention': // "uuid": , "name": , "url":
        formattedText = "<mention href=${this.blogUrl}>$originalText</mention>";
        leftPadding = 14 + this.blogUrl.length;
        rightPadding = 10;
        break;
      default:
        formattedText = originalText;
    }
    return [
      text.replaceAll(originalText, formattedText),
      leftPadding,
      rightPadding
    ];
  }

  @override
  int compareTo(InlineFormatting other) {
// case 0: both are applied on the same substring
    if (this.start == other.start &&
        this.end == other.end &&
        this.type == other.type) return 0;
    // case 1: a is applied on a substring that is after b's
    if (this.start < other.start) return -1;
    if (this.start > other.start) return 1;

    if (this.start == other.start) {
      // case 2: a should be the inner format [e.g [<b><a>text</a>restOfText</b>]
      if (this.end > other.end) return 1;

      // case 3: b should be the inner format [e.g [<a><b>text</b>restOfText</a>]
      return -1;
    }
    return 0;
  }
}
