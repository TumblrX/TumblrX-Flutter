/*
Description: 
    A class that implementes tags widget 
*/

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TagsWidget extends StatefulWidget {
  final List<String> _tags;
  TagsWidget(this._tags);

  @override
  _TagsWidgetState createState() => _TagsWidgetState();
}

void navigateToTag(String tag, BuildContext context) {
//  Navigator.of(context).pushNamed('tag_screen');
}

class _TagsWidgetState extends State<TagsWidget> {
  bool readMore;

  @override
  Widget build(BuildContext context) {
    int stringLength = 0;
    widget._tags.forEach((tag) {
      stringLength += tag.length;
    });
    readMore = stringLength > 150;

    if (widget._tags.isEmpty)
      return Container(
        height: 0,
      );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ConstrainedBox(
            constraints:
                readMore ? BoxConstraints(maxHeight: 50.0) : BoxConstraints(),
            child: RichText(
              text: TextSpan(
                text: '#${widget._tags[0]}',
                style: TextStyle(color: Colors.grey),
                children: widget._tags
                    .getRange(1, widget._tags.length)
                    .map(
                      // view each tag with callback on tap that navigates to
                      // tag page
                      (tag) => TextSpan(
                        text: ' $tag ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            navigateToTag(tag, context);
                          },
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                    .toList(),
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          readMore
              ? InkWell(
                  child: Text(
                    'readmore',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () => setState(() {
                    readMore = false;
                  }),
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }
}
