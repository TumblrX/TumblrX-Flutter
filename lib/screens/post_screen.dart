import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostScreen extends StatefulWidget {
  static String id = "post-screen";
  final String _postId;
  PostScreen({Key key, String postId})
      : _postId = postId,
        super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (!kIsWeb)
          return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        Navigator.of(context).pop();
        return Future(() => true);
      },
      child: Scaffold(
          body: Center(
        child: Container(
          child: Text(widget._postId),
        ),
      )),
    );
  }
}
