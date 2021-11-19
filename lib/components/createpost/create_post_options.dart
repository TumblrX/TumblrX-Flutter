import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';
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
            groupValue: Provider.of<CreatingPost>(context).postOption,
            onChanged: (value) {
              Provider.of<CreatingPost>(context, listen: false)
                  .choosePostOption(value);
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
            groupValue: Provider.of<CreatingPost>(context).postOption,
            onChanged: (value) {
              Provider.of<CreatingPost>(context, listen: false)
                  .choosePostOption(value);
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
            groupValue: Provider.of<CreatingPost>(context).postOption,
            onChanged: (value) {
              Provider.of<CreatingPost>(context, listen: false)
                  .choosePostOption(value);
              //setState(() {});
            },
          ),
        ),
        Provider.of<CreatingPost>(context).postOption == PostOption.now
            ? ListTile(
                title: Text('Share to Twitter'),
                trailing: Switch(
                  value: Provider.of<CreatingPost>(context).shareToTwitter,
                  onChanged: (value) {
                    Provider.of<CreatingPost>(context, listen: false)
                        .setShareToTwitter(value);
                  },
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
