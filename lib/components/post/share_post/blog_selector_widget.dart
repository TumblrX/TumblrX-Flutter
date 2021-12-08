import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';

class BlogSelector extends StatefulWidget {
  @override
  State<BlogSelector> createState() => _BlogSelectorState();
}

class _BlogSelectorState extends State<BlogSelector> {
  User user;

  bool selectingBlog = false;
  String selectedBlogName = "virtualwerewolfcat";
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 20,
              child: Image.asset(
                "assets/icon/avatar2.png",
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
          Text(
            selectedBlogName,
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
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              selectedBlogName = "virtualwerewolfcat";
                            });
                          },
                          leading: CircleAvatar(
                              radius: 20,
                              child: Image.asset(
                                "assets/icon/avatar2.png",
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.error),
                              )),
                          title: Text("virtualwerewolfcat"),
                          subtitle: Text("Untitled"),
                          trailing: selectedBlogName == "virtualwerewolfcat"
                              ? Icon(
                                  Icons.check,
                                  color: Colors.blueAccent,
                                )
                              : Container(
                                  width: 0,
                                ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              selectedBlogName = "testtestpass";
                            });
                          },
                          leading: CircleAvatar(
                              radius: 20,
                              child: Image.asset(
                                "assets/icon/avatar2.png",
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.error),
                              )),
                          title: Text("testtestpass"),
                          subtitle: Text("Untitled"),
                          trailing: selectedBlogName == "testtestpass"
                              ? Icon(
                                  Icons.check,
                                  color: Colors.blueAccent,
                                )
                              : Container(
                                  width: 0,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).then((value) => setState(() {
              selectingBlog = false;
            }));
      },
    );
  }
}

