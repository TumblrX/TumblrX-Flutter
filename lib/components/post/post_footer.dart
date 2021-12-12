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
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/utilities/constants.dart';

class PostFooter extends StatefulWidget {
  final _postIndex;

  PostFooter(this._postIndex);

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  final double _reactionsIconSize = 23;

  final double _interactIocnSize = 15;

  final String errorMessage = 'Something went wrong!';

  OverlayEntry _blogsSelectorPopup;

  /// flag for the user's like/unlike on the post
  bool _liked;

  /// object to hold post data
  Post _post;

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

  /// callback on tap like icon
  void likePost() {
    Future<bool> success = _liked ? _post.unlikePost() : _post.likePost();
    success.then((value) {
      if (value)
        setState(() {
          _liked = !_liked;
        });
      else
        showSnackBarMessage(errorMessage);
    }).catchError((e) {
      showSnackBarMessage(errorMessage);
    });
  }

  /// callback to insert an overlay entry to choose which blog to use in reblogging
  void _showBlogsPicker(context) {
    User user = Provider.of<User>(context, listen: false);
    print(user.userBlogs.length);
    final double avatarSize = 50;
    _blogsSelectorPopup = OverlayEntry(
      builder: (ctx) => Material(
        color: Colors.blue.withOpacity(0.3),
        child: Stack(
          children: user.userBlogs
              .map((blog) => AnimatedAlign(
                    alignment: Alignment(-0.7, -0.4),
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    child: AnimatedContainer(
                      height: avatarSize,
                      width: avatarSize,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: CachedNetworkImage(
                        height: avatarSize,
                        width: avatarSize,
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

    // list of icons
    List<Widget> stacked = [];
    int index = 0;
    // check if any comment => insert the comment icon
    if (_post.commentsCount > 0) {
      print('$index $shiftAmount');
      stacked.add(Container(
        width: _reactionsIconSize,
        height: _reactionsIconSize,
        child: _reactionIcon(commentIcon),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
      index++;
    }
    // check if any reblog => insert the reblog icon
    if (_post.reblogsCount > 0) {
      print('$index $shiftAmount');

      stacked.add(Container(
        width: _reactionsIconSize,
        height: _reactionsIconSize,
        child: _reactionIcon(reblogIcon),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
      index++;
    }
    // check if any like => insert the like icon
    if (_post.likesCount > 0) {
      print('$index $shiftAmount');

      stacked.add(Container(
        width: _reactionsIconSize,
        height: _reactionsIconSize,
        child: _reactionIcon(likeIcon),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
    }
    // stacked notes icon widget
    return Stack(
      children: stacked.reversed.toList(),
    );
  }

  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get active blog name to check the action icons view mode
    String activeBlogTitle = Provider.of<User>(context).activeBlogTitle;
    // get the post object to access its data
    _post = Provider.of<Content>(context).posts[widget._postIndex];

    // store the like state of the post
    _liked = _post.liked;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _post.totalNotes > 0
                ? [
                    InkWell(
                      onTap: () => _post.commentOnPost(),
                      child: notesIcons(),
                    ),
                    TextButton(
                      child: Text(
                        '${_post.totalNotes.toString()} notes',
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                      onPressed: _showNotesPage,
                    ),
                  ]
                : [],
          ),
          Row(children: [
            ...[
              // share icon
              GestureDetector(
                onLongPress: () => _showBlogsPicker(context),
                onLongPressEnd: (details) => _blogsSelectorPopup.remove(),
                child: _actionIcon(
                    shareIcon, () => _showSharePage(context), Colors.white),
              ),
              // notes icon
              _actionIcon(commentIcon, _showNotesPage, Colors.white),
              // reblog icon
              GestureDetector(
                onLongPress: () {},
                onLongPressEnd: null,
                child: _actionIcon(
                    reblogIcon, () => _post.reblogPost(), Colors.white),
              ),
              // like icon
              _actionIcon(likeIcon, () => likePost(),
                  _liked ? Colors.red : Colors.white),
            ],
            if (_post.blogTitle == activeBlogTitle) ...[
              // remove icon
              _actionIcon(deleteIcon, () {
                _post.deletePost().then(
                  (value) {
                    if (!value) {
                      showSnackBarMessage(errorMessage);
                    }
                  },
                ).catchError((error) {
                  showSnackBarMessage(errorMessage);
                });
              }, Colors.white),
              // edit icon
              _actionIcon(editIcon, () => _post.showPost(widget._postIndex),
                  Colors.white),
            ]
          ]),
        ],
      ),
    );
  }
}
