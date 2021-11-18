import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/tags_list_view.dart';
import 'package:tumblrx/services/post.dart';

import 'chosen_tags_list.dart';

class AddTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.tag,
            color: Colors.black,
            size: 30.0,
          ),
          title: ChosenTagsList(
            chosenTags: Provider.of<Post>(context).chosenHashtags,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          child: TagsListView(
            tagsList: Provider.of<Post>(context).suggestedHashtags,
          ),
        ),
      ],
    );
  }
}
