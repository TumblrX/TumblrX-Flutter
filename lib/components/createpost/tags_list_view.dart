import 'package:flutter/material.dart';

import 'hashtag_bubble.dart';

///Horizontal ListView of chosen or suggested tags depending on boolean value isPostView.
class TagsListView extends StatelessWidget {
  ///List of tags to be shown.
  final List<String> tagsList;

  ///Boolean value that determines if the tag is chosen or suggested.
  final bool isPostView;
  TagsListView({this.tagsList, this.isPostView = false});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: getSuggestedHashtags(context),
    );
  }

  List<Widget> getSuggestedHashtags(BuildContext context) {
    List<Widget> tags = [];
    for (String hashtag in tagsList) {
      tags.add(HashtagBubble(
        hashtag: hashtag,
        isSuggested: true,
        isPostView: isPostView,
      ));
    }

    return tags;
  }
}
