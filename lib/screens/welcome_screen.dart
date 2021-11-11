import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/create_post.dart';
import 'package:tumblrx/services/post.dart';

class WelcomeScreen extends StatelessWidget {
  static final String id = 'welcome_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit),
        onPressed: () {
          double topPadding = MediaQuery.of(context).padding.top;
          Provider.of<Post>(context, listen: false).initializePostOptions();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: CreatePost(
                topPadding: topPadding,
              ),
            ),
          );
        },
      ),
    );
  }
}
