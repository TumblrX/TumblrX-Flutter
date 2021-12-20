import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class ShareMethods extends StatelessWidget {
  final String _postUrl;
  const ShareMethods({Key key, @required String postUrl})
      : _postUrl = postUrl,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // copy method
        InkWell(
          onTap: () async {
            await FlutterClipboard.copy(_postUrl);
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
                'https://t.me/share/url?url=$_postUrl&text=Check this out!';
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
        // TODO: onedrive method
        InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.cloud),
              ),
              Text('OneDrive')
            ],
          ),
        ),
        // share
        InkWell(
          onTap: () async {
            try {
              await Share.share(_postUrl);
              showSnackBarMessage(
                  context, 'Shared successfully!', Colors.green);
            } catch (err) {
              print(err);
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
