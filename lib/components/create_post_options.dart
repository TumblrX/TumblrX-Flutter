import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/post.dart';
import 'package:tumblrx/utilities/constants.dart';

class CreatePostOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.edit_outlined,
            color: Colors.black,
          ),
          title: Text('Post now'),
          trailing: Radio<PostOption>(
            value: PostOption.now,
            groupValue: Provider.of<Post>(context).postOption,
            onChanged: (value) {
              Provider.of<Post>(context, listen: false).choosePostOption(value);
              //setState(() {});
            },
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.drive_folder_upload,
            color: Colors.black,
          ),
          title: Text('Save as Draft'),
          trailing: Radio<PostOption>(
            value: PostOption.draft,
            groupValue: Provider.of<Post>(context).postOption,
            onChanged: (value) {
              Provider.of<Post>(context, listen: false).choosePostOption(value);
              //setState(() {});
            },
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.lock_outline,
            color: Colors.black,
          ),
          title: Text('Post privately'),
          trailing: Radio<PostOption>(
            value: PostOption.private,
            groupValue: Provider.of<Post>(context).postOption,
            onChanged: (value) {
              Provider.of<Post>(context, listen: false).choosePostOption(value);
              //setState(() {});
            },
          ),
        ),
        ListTile(
          title: Text('Share to Twitter'),
          trailing: Switch(
            value: Provider.of<Post>(context).shareToTwitter,
            onChanged: (value) {
              Provider.of<Post>(context, listen: false)
                  .setShareToTwitter(value);
            },
          ),
        ),
      ],
    );
  }
}
