import 'package:flutter/material.dart';

class PostFooter extends StatelessWidget {
  // void _likePost() {}
  // void _commentOnPost() {}
  // void _reblogPost() {}
  void _sharePost() {}

  Widget notesIcons() {
    final overlap = 20.0;
    final List<Widget> icons = [
      "assets/icon/message.png",
      "assets/icon/repeat.png",
      "assets/icon/love.png"
    ]
        .map((e) => ImageIcon(
              AssetImage(e),
              size: 24,
            ))
        .toList();

    List<Widget> stacked = List<Widget>.generate(icons.length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: icons[index],
      );
    });
    return Stack(
      children: stacked,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> notesImages = [
      "assets/icon/share.png",
      "assets/icon/chat.png",
      "assets/icon/reblog.png",
      "assets/icon/heart.png",
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              notesIcons(),
              TextButton(
                child: Text(
                  '584 notes',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                onPressed: null,
              ),
            ],
          ),
          Row(
              children: notesImages
                  .map((e) => IconButton(
                        enableFeedback: false,
                        onPressed: _sharePost,
                        icon: ImageIcon(
                          AssetImage(e),
                          size: 20,
                        ),
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
