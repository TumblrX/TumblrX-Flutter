/*
Description: 
    A class that implementes share options widget
    options can be [copy to clipboard, share via telegarm, share via others] 
    sharing the post is done by sharing a link to the post
*/
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class ShareMethods extends StatelessWidget {
  final String _postId;
  const ShareMethods({Key key, @required String postId})
      : _postId = postId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final String postUrl = 'tumblrx.me:5000/post/$_postId';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // copy method
        InkWell(
          onTap: () async {
            await FlutterClipboard.copy(postUrl);
            Navigator.of(context).pop();

            showSnackBarMessage(context, 'Copied to clipboard', Colors.green);
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.file_copy_outlined),
              ),
              Text('Copy')
            ],
          ),
        ),
        // telegram method
        InkWell(
          onTap: () async {
            String url =
                'https://t.me/share/url?url=$postUrl&text=Check this out!';
            bool success = false;
            if (await canLaunch(url)) success = await launch(url);
            Navigator.of(context).pop();
            if (!success)
              showSnackBarMessage(context, "Something went wrong!", Colors.red);
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.send),
              ),
              Text('Telegram')
            ],
          ),
        ),
        // share via others
        InkWell(
          onTap: () async {
            try {
              await Share.share(postUrl);
              showSnackBarMessage(
                  context, 'Shared successfully!', Colors.green);
            } catch (err) {
              logger.e(err);
              showSnackBarMessage(context, 'Something went wrong!', Colors.red);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.share),
              ),
              Text('Other')
            ],
          ),
        ),
      ],
    );
  }
}
