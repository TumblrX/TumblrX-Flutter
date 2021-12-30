import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'post_blog_choice.dart';

///Shows the user of Creating post and allows you to choose the blog that post will be added into.
class CreatePostUser extends StatelessWidget {
  CreatePostUser();
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
              backgroundImage: NetworkImage(
                Provider.of<User>(context, listen: false)
                        .getActiveBlogAvatar()
                        .startsWith('http')
                    ? Provider.of<User>(context, listen: false)
                        .getActiveBlogAvatar()
                    : ApiHttpRepository.api +
                        Provider.of<User>(context, listen: false)
                            .getActiveBlogAvatar(),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              Provider.of<User>(context).getActiveBlogName(),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 25.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getBlogs(BuildContext context) {
    List<Widget> blogs = [];
    for (int i = 0; i < Provider.of<User>(context).userBlogs.length; i++) {
      blogs.add(
        PostBlogChoice(
          username: Provider.of<User>(context).userBlogs[i].handle,
          blogTitle: Provider.of<User>(context).userBlogs[i].title,
          avatar: Provider.of<User>(context).userBlogs[i].blogAvatar,
        ),
      );
    }
    return blogs;
  }
}
