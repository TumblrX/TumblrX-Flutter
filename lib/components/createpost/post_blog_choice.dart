import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/api_provider.dart';

///Shows the blog choice where the post will be added to.
class PostBlogChoice extends StatelessWidget {
  PostBlogChoice({this.username, this.blogTitle, this.avatar});

  ///Username of the blog to be chosen
  final String username;

  ///Title of the blog to be chosen
  final String blogTitle;

  ///user avatar url
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Provider.of<User>(context, listen: false).setActiveBlog(username);
          Provider.of<User>(context, listen: false).updateActiveBlog();
          Navigator.pop(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.0,
              backgroundImage: NetworkImage(
                avatar.startsWith('http')
                    ? avatar
                    : ApiHttpRepository.api + avatar,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  blogTitle,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Spacer(),
            Provider.of<User>(context).getActiveBlogName() == username
                ? Icon(
                    Icons.done,
                    color: Colors.blue,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
