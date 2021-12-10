/*
Author: Passant Abdelgalil
Description: 
    The post footer widget that contains reactions count and icons, and 
    post options: share, comment, reblog, and like/unlike
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/share_post/share_post_widget.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/utilities/constants.dart';

class PostFooter extends StatefulWidget {
  /// total number of notes
  final int _notesCount;

  /// flag for the user's like/unlike on the post
  bool _liked;

  PostFooter(this._notesCount, this._liked);

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  final double _reactionsIconSize = 23;

  final double _interactIocnSize = 15;

  OverlayEntry _blogsSelectorPopup;

  /// flag for the user's like/unlike on the post
  bool _liked;

  /// callback on tap notes icon/number
  void _showNotesPage() {}

  /// callback on tap notes icon/number
  _showSharePage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          FractionallySizedBox(heightFactor: 0.9, child: SharePost()),
    );
  }

  void likePost(Post post) {
    Future<bool> success = _liked ? post.unlikePost() : post.likePost();
    success.then((value) {
      if (value)
        setState(() {
          _liked = !_liked;
        });
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong!'),
        ),
      );
      return null;
    });
  }

  void _showBlogsPicker(context) {
    User user = Provider.of<User>(context, listen: false);

    _blogsSelectorPopup = OverlayEntry(
      builder: (ctx) => Material(
        color: Colors.blue.withOpacity(0.3),
        child: Stack(
          children: user.blogs
              .map((blog) => AnimatedAlign(
                    alignment: Alignment(-0.7, -0.4),
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    child: AnimatedContainer(
                      height: 50,
                      width: 50,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        imageUrl: blog.blogAvatar,
                        errorWidget: (context, url, error) => CircleAvatar(
                          child: Icon(Icons.error),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
    Overlay.of(context).insert(_blogsSelectorPopup);
  }

  /// Build the widget of the passed reaction icon
  Widget _reactionIcon(String iconPath) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(2),
        color: Colors.white,
        child: ClipOval(
          child: Image.asset(
            iconPath,
            fit: BoxFit.cover,
            width: _reactionsIconSize,
            height: _reactionsIconSize,
          ),
        ),
      ),
    );
  }

  /// Build the widget with actions icon ['like', 'reblog', 'comment', 'share]
  Widget _actionIcon(String iconPath, Function callback, Color color) {
    return IconButton(
      iconSize: _interactIocnSize,
      onPressed: callback,
      icon: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(
          iconPath,
          fit: BoxFit.fitWidth,
          height: _interactIocnSize,
          colorBlendMode: BlendMode.modulate,
          color: color,
        ),
      ),
      enableFeedback: false,
    );
  }

  /// Builds the widget of stacked notes icon ['likes', 'reblogs', 'comments']
  Widget notesIcons() {
    // constant shifting amount, should be < icon size
    final double shiftAmount = 20.0;

    // list of notes icon widget
    final List<Widget> icons =
        reactionIcons.map((e) => _reactionIcon(e)).toList();

    // generate stacked icons by applying margin = shiftamount * icon index
    List<Widget> stacked = List<Widget>.generate(icons.length, (index) {
      return Container(
        width: _reactionsIconSize,
        height: _reactionsIconSize,
        child: icons[index],
        margin: EdgeInsets.only(left: shiftAmount * index),
      );
    });

    // stacked notes icon widget
    return Stack(
      children: stacked.reversed.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    String activeBlogName = Provider.of<User>(context).activeBlog;
    _liked = widget._liked;
    return Consumer<Post>(
      builder: (context, post, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget._notesCount > 0
                  ? [
                      InkWell(
                        onTap: () => post.commentOnPost(),
                        child: notesIcons(),
                      ),
                      TextButton(
                        child: Text(
                          '${post.totalNotes} notes',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        onPressed: _showNotesPage,
                      ),
                    ]
                  : [],
            ),
            Row(children: [
              ...[
                GestureDetector(
                  onLongPress: () => _showBlogsPicker(context),
                  onLongPressEnd: (details) => _blogsSelectorPopup.remove(),
                  child: _actionIcon("assets/icon/share.png",
                      () => _showSharePage(context), Colors.white),
                ),
                _actionIcon(
                    "assets/icon/chat.png", _showNotesPage, Colors.white),
                GestureDetector(
                  onLongPress: () {},
                  onLongPressEnd: null,
                  child: _actionIcon("assets/icon/reblog.png",
                      () => post.reblogPost(), Colors.white),
                ),
                _actionIcon("assets/icon/like.png", () => likePost(post),
                    widget._liked ? Colors.red : Colors.white),
              ],
              if (post.blogName == activeBlogName) ...[
                _actionIcon("assets/icon/remove.png", () {
                  try {
                    post.deletePost();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Something went wrong!'),
                      ),
                    );
                  }
                }, Colors.white),
                _actionIcon("assets/icon/edit.png", () => post.showPost(),
                    Colors.white),
              ]
            ]),
          ],
        ),
      ),
    );
  }
}
