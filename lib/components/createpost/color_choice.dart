import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';

class ColorChoice extends StatelessWidget {
  final int textFieldIndex;
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
