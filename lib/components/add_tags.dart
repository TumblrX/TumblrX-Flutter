import 'package:flutter/material.dart';
import 'package:tumblrx/components/hashtag_bubble.dart';

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
          title: Wrap(
            children: [
              HashtagBubble(
                hashtag: 'art',
              ),
              HashtagBubble(
                hashtag: 'art',
              ),
              HashtagBubble(
                hashtag: 'art',
              ),
              HashtagBubble(
                hashtag: 'art',
              ),
              HashtagBubble(
                hashtag: 'art',
              ),
              HashtagBubble(
                hashtag: 'art',
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Add tags...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              HashtagBubble(
                hashtag: 'art',
                isSuggested: true,
              ),
              HashtagBubble(
                hashtag: 'art',
                isSuggested: true,
              ),
              HashtagBubble(
                hashtag: 'art',
                isSuggested: true,
              ),
              HashtagBubble(
                hashtag: 'art',
                isSuggested: true,
              ),
              HashtagBubble(
                hashtag: 'art',
                isSuggested: true,
              ),
              HashtagBubble(
                hashtag: 'art',
                isSuggested: true,
              ),
              HashtagBubble(
                hashtag: 'art',
                isSuggested: true,
              ),
              HashtagBubble(
                hashtag: 'art',
                isSuggested: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
