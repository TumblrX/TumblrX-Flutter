import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/models/user/user.dart';

class BlogSelector extends StatefulWidget {
  @override
  State<BlogSelector> createState() => _BlogSelectorState();
}

class _BlogSelectorState extends State<BlogSelector> {
  User user;
  bool selectingBlog = false;
  Blog selectedBlog;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<User>(context);
    selectedBlog = user.userBlogs[user.activeBlogIndex];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                selectedBlog.blogAvatar,
                //errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
          Text(
            selectedBlog.title,
            style: TextStyle(fontSize: 20),
          ),
          Icon(
            selectingBlog
                ? Icons.arrow_drop_up_outlined
                : Icons.arrow_drop_down_outlined,
          ),
        ],
      ),
      onTap: () {
        setState(() {
          selectingBlog = true;
        });
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.blueGrey[900],
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation1, animation2) {
            return Center(
              child: Material(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width - 10,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Blogs",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      ...user.userBlogs
                          .map(
                            (blog) => ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  selectedBlog = blog;
                                  selectingBlog = false;
                                });
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                child: Image.network(
                                  blog.blogAvatar,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              title: Text(blog.title),
                              trailing: selectedBlog.title == blog.title
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.blueAccent,
                                    )
                                  : Container(
                                      width: 0,
                                    ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
