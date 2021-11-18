import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';

import 'post_blog_choice.dart';

///Shows the user of Creating post and allows you to choose the blog that post will be added into.
class CreatePostUser extends StatelessWidget {
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
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              Provider.of<CreatingPost>(context).blogUsername,
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
    for (String username in Provider.of<CreatingPost>(context).blogUsernames) {
      blogs.add(
        PostBlogChoice(
          username: username,
          blogTitle:
              Provider.of<CreatingPost>(context).blogUsernamesTitles[username],
        ),
      );
    }
    return blogs;
  }
}
