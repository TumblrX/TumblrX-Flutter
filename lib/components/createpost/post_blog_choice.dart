import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';

class PostBlogChoice extends StatelessWidget {
  PostBlogChoice({this.username, this.blogTitle});
  final String username;
  final String blogTitle;

  //final Image userPic;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Provider.of<CreatingPost>(context, listen: false)
              .setPostBlogUsername(username);
          Navigator.pop(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.0,
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
            Provider.of<CreatingPost>(context).blogUsername == username
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
