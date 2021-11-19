import 'package:flutter/material.dart';

import 'hashtag_bubble.dart';

class TagsListView extends StatelessWidget {
  final List<String> tagsList;
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
