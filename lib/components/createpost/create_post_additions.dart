import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/font_style_list.dart';
import 'package:tumblrx/services/post.dart';
import 'add_tags.dart';
import '../modal_bottom_sheet.dart';

class CreatePostAdditions extends StatelessWidget {
  CreatePostAdditions({this.addGif, this.addImage});
  final Function addGif;
  final Function addImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Icon(
            Icons.text_format,
            size: 30.0,
          ),
          onTap: () {
            Provider.of<Post>(context, listen: false).nextTextStyle();
          },
          onLongPress: () {
            Provider.of<Post>(context, listen: false).saveFocusedIndex();
            showDialog(
              context: context,
              builder: (_) => FontStyleList(),
            );
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.link,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.gif,
            size: 30.0,
          ),
          onTap: () {
            addGif();
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.photo_outlined,
            size: 30.0,
          ),
          onTap: () {
            addImage();
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.headphones,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Spacer(),
        InkWell(
          child: Icon(
            Icons.tag,
            size: 30.0,
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: ModalBottomSheet(
                    title: 'Add tags',
                    content: AddTags(),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
