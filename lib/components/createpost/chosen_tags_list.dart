import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';

import 'hashtag_bubble.dart';

///The wrap view of the chosen tags during creating post
class ChosenTagsList extends StatelessWidget {
  ///List of the chosen tags during creating post
  final List<String> chosenTags;

  ChosenTagsList({this.chosenTags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: getChosenHashtags(context),
    );
  }

  ///returns the list of chosen tags and shows add more tags text field
  List<Widget> getChosenHashtags(BuildContext context) {
    List<Widget> chosenHashtags = [];
    for (String hashtag in chosenTags) {
      chosenHashtags.add(HashtagBubble(
        hashtag: hashtag,
      ));
    }
    chosenHashtags.add(TextField(
      onChanged: (value) {
        Provider.of<CreatingPost>(context, listen: false)
            .searchSuggestedTags(value);
      },
      decoration: InputDecoration(
        hintText: 'Add tags...',
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ));
    return chosenHashtags;
  }
}
