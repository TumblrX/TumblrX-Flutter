import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';

import 'add_tags.dart';
import '../modal_bottom_sheet.dart';

///A bubble shape that contains the tag of a creating post.
///It has multiple views depends on its state whether it is chosen, suggested or chosen during adding more tags.
class HashtagBubble extends StatelessWidget {
  ///The tag value
  final String hashtag;

  ///determines if the bubble is for suggestions
  final bool isSuggested;

  ///determines if the bubble is for post view so have on tap functionality
  final bool isPostView;
  HashtagBubble(
      {this.hashtag, this.isSuggested = false, this.isPostView = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (isPostView) {
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
            } else if (isSuggested)
              Provider.of<CreatingPost>(context, listen: false).addTag(hashtag);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: isSuggested ? Colors.black12 : Colors.lightBlue,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Text(
              '#' + hashtag,
              style: TextStyle(
                color: isSuggested ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        isSuggested
            ? SizedBox.shrink()
            : Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<CreatingPost>(context, listen: false)
                          .deleteTag(hashtag);
                    },
                    child: Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(230, 230, 230, 1),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.blue,
                        size: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
