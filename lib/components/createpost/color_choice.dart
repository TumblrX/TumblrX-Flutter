import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';

///The Circle Button of a single color to be selected for creating post text style
class ColorChoice extends StatelessWidget {
  ///The index of the text field to have its color edited in post content list
  final int textFieldIndex;

  ///The color of the button that will be reflected on the text field
  final Color color;
  ColorChoice({this.textFieldIndex, this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<CreatingPost>(context, listen: false)
            .setTextColor(textFieldIndex, color);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 16.0,
            backgroundColor: color,
          ),
          Provider.of<CreatingPost>(context)
                      .postContent[textFieldIndex]['content']['data']
                      .color ==
                  color
              ? CircleAvatar(
                  radius: 20.0,
                  backgroundColor: color.withOpacity(0.4),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
