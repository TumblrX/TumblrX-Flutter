import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';

import 'post_blog_choice.dart';

///Shows the user of Creating post and allows you to choose the blog that post will be added into.
class CreatePostUser extends StatelessWidget {
  ///Avatar of current user
  final String userAvatar;

  CreatePostUser({this.userAvatar});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Center(
              child: Text(
                'Blogs',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            actions: getBlogs(context),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.0,
              backgroundImage: AssetImage(
                Provider.of<User>(context, listen: false)
                            .getActiveBlogAvatar() !=
                        null
                    ? Provider.of<User>(context, listen: false)
                        .getActiveBlogAvatar()
                    : "assets/icon/avatar2.png",
              ),
              //will be later to changed to NetworkImage
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              Provider.of<User>(context).activeBlog,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getBlogs(BuildContext context) {
    List<Widget> blogs = [];
    for (int i = 0; i < Provider.of<User>(context).blogs.length; i++) {
      blogs.add(
        PostBlogChoice(
          username: Provider.of<User>(context).blogs[i].name,
          blogTitle: Provider.of<User>(context).blogs[i].title,
          avatar: Provider.of<User>(context).blogs[i].blogAvatar,
        ),
      );
    }
    return blogs;
  }
}
