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

  String getBlogAvatar() {
    return "assets/icon/default_avatar.png";
  }
}
