import 'package:flutter/material.dart';

class CreatePostUser extends StatefulWidget {
  @override
  _CreatePostUserState createState() => _CreatePostUserState();
}

class _CreatePostUserState extends State<CreatePostUser> {
  String username;

  @override
  void initState() {
    username = 'ammarovic21';
    super.initState();
  }

  void usernamePicker(String uname) {
    this.username = uname;
    setState(() {});
  }

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
            actions: [
              PostBlogChoice(
                username: 'ammarovic21',
                blogTitle: 'hello',
                isCurrent: username == 'ammarovic21',
                pickUser: usernamePicker,
              ),
              PostBlogChoice(
                username: 'ammmarrr',
                blogTitle: 'hiiii',
                isCurrent: username == 'ammmarrr',
                pickUser: usernamePicker,
              ),
              PostBlogChoice(
                username: 'adadada',
                blogTitle: 'hello',
                isCurrent: username == 'adadada',
                pickUser: usernamePicker,
              ),
            ],
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
              username,
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
}

class PostBlogChoice extends StatelessWidget {
  PostBlogChoice(
      {this.username, this.blogTitle, this.isCurrent, this.pickUser});
  final String username;
  final String blogTitle;
  final bool isCurrent;
  final Function pickUser;
  //final Image userPic;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          pickUser(username);
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
            isCurrent
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
