import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/modal_bottom_sheet.dart';
import 'package:tumblrx/services/creating_post.dart';
import 'package:tumblrx/utilities/constants.dart';

import 'create_post_options.dart';

///The Top header of the creating post container shows posting options button and Post button
class CreatePostHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: Icon(
            Icons.close,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Spacer(),
        TextButton(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Provider.of<CreatingPost>(context).postOption ==
                        PostOption.private
                    ? Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                          Icons.lock,
                          size: 16.0,
                          color:
                              Provider.of<CreatingPost>(context).isPostEnabled
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      )
                    : SizedBox.shrink(),
                Text(
                  Provider.of<CreatingPost>(context).postOption ==
                          PostOption.draft
                      ? 'Save draft'
                      : 'Post',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Provider.of<CreatingPost>(context).isPostEnabled
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          style: ButtonStyle(
            backgroundColor: Provider.of<CreatingPost>(context).isPostEnabled
                ? MaterialStateProperty.all<Color>(Colors.blueAccent)
                : MaterialStateProperty.all<Color>(Colors.black12),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          onPressed: Provider.of<CreatingPost>(context).isPostEnabled
              ? () {
                  Provider.of<CreatingPost>(context, listen: false)
                      .postData(context);
                }
              : null,
        ),
        SizedBox(
          width: 20.0,
        ),
        InkWell(
          child: Icon(
            Icons.more_vert,
            size: 30.0,
          ),
          onTap: () {
            showModalBottomSheet(
              constraints:
                  BoxConstraints(maxWidth: kIsWeb ? 500.0 : double.infinity),
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: ModalBottomSheet(
                  content: CreatePostOptions(),
                  title: 'Post options',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
