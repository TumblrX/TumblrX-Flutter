import 'package:flutter/material.dart';

class PostFooter extends StatelessWidget {
  final int notesCount;
  final bool liked;
  PostFooter(this.notesCount, this.liked);
  final double reactionsIconSize = 25;
  final double interactIocnSize = 20;
  void _likePost() {}
  void _commentOnPost() {}
  void _reblogPost() {}
  void _sharePost() {}

  void _showNotesPage() {}

  Widget notesIcons() {
    final double shiftAmount = 20.0;
    final List<Widget> icons = [
      "assets/icon/message.png",
      "assets/icon/repeat.png",
      "assets/icon/love.png"
    ]
        .map((e) => ClipOval(
              child: Container(
                padding: EdgeInsets.all(2),
                color: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    e,
                    fit: BoxFit.cover,
                    width: reactionsIconSize,
                    height: reactionsIconSize,
                  ),
                ),
              ),
            ))
        .toList();

    List<Widget> stacked = List<Widget>.generate(icons.length, (index) {
      return Container(
        width: reactionsIconSize,
        height: reactionsIconSize,
        child: icons[index],
        margin: EdgeInsets.only(left: shiftAmount * index),
      );
    });
    return Stack(
      textDirection: TextDirection.ltr,
      children: stacked.reversed.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: notesCount > 0
                ? [
                    InkResponse(
                      onTap: _showNotesPage,
                      child: notesIcons(),
                    ),
                    TextButton(
                      child: Text(
                        '$notesCount notes',
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                      onPressed: _showNotesPage,
                    ),
                  ]
                : [],
          ),
          Row(
            children: [
              IconButton(
                iconSize: interactIocnSize,
                onPressed: _sharePost,
                icon: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ImageIcon(
                    AssetImage("assets/icon/share.png"),
                  ),
                ),
                enableFeedback: false,
              ),
              IconButton(
                iconSize: interactIocnSize,
                onPressed: _commentOnPost,
                icon: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ImageIcon(
                    AssetImage("assets/icon/chat.png"),
                  ),
                ),
                enableFeedback: false,
              ),
              IconButton(
                iconSize: interactIocnSize,
                onPressed: _reblogPost,
                icon: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ImageIcon(
                    AssetImage("assets/icon/reblog.png"),
                  ),
                ),
                enableFeedback: false,
              ),
              IconButton(
                onPressed: _likePost,
                icon: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(
                    "assets/icon/heart.png",
                    fit: BoxFit.fitWidth,
                    width: interactIocnSize,
                    height: interactIocnSize,
                    colorBlendMode: BlendMode.modulate,
                    color: liked ? Colors.red : Colors.white,
                  ),
                ),
                enableFeedback: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
