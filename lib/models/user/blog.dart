import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Blog {
  String name; //the short name of the blog
  String title; //the title of the blog
  String url; //the URL of the blog
  String tweet; //indicate if posts are tweeted auto, Y, N
  String facebook; //indicate if posts are sent to facebook Y, N
  bool primary; //indicates if this is the user's primary blog
  int followers; //total count of followers for this blog
  String blogType; //indicates whether a blog is public or private
  String blogAvatar;
  String description;
  int likes;
  // bool ask;
  // bool ask_anon
  /*
    following => followed blogs
    likes => liked posts

  */
  int posts;

  Blog(
      {this.name,
      this.title,
      this.primary,
      this.followers,
      this.blogType,
      this.blogAvatar});

  Blog.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    primary = json['primary'];
    followers = json['followers'];
    blogType = json['blogType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['primary'] = this.primary;
    data['followers'] = this.followers;
    data['blogType'] = this.blogType;
    return data;
  }

  Future<void> getBlogAvatar() async {
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/blog/$name/avatar';
    final Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final responseParsed = convert.jsonDecode(response.body);
        return responseParsed['avatar_url'];
      } else {
        // handle failed request
      }
    } catch (error) {
      // handle failed request
    }
  }

  void getInfo() async {
    final String key = "api_key";
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/blog/$name/info?api_key={$key}';
    try {} catch (error) {}
  }

  void getPosts() async {
    final String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/blog/$name/posts/';
    try {} catch (error) {}
  }

  void blockBlog(String toBlock) async {
    String url =
        'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/blog/$name/blocks';
    try {} catch (error) {}
  }
}
