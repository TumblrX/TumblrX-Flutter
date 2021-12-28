/*
Author: Passant Abdeljalil
Description: 
    Option icons widget [share, comment, like, reblog, edit, delete], where
    the last two icons only displayed if the blog owner of the post is the
    current active user blog
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/share_post/share_post_widget.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:tumblrx/utilities/custom_icons.dart';

class OptionsWidget extends StatefulWidget {
  final String _activeBlogTitle;
  final Post _post;
  final void Function() _showNotesPage;

  OptionsWidget(
      {Key key,
      String activeBlogTitle,
      @required Post post,
      @required void Function() showNotesPage})
      : _activeBlogTitle = activeBlogTitle,
        _post = post,
        _showNotesPage = showNotesPage,
        super(key: key);
  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  bool _liked = false;
  bool _reblogged = false;
  final double _interactIocnSize = 18;
  OverlayEntry _blogsSelectorPopup;

  final String errorMessage = 'Something went wrong';

  /// callback on tap notes icon/number
  _showSharePage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
          heightFactor: 0.9, child: SharePostWidget(widget._post)),
    );
  }

  /// callback on tap like icon
  void _likePost() {
    Future<bool> success = _liked
        ? widget._post.unlikePost(context)
        : widget._post.likePost(context);
    success.then((value) {
      if (value)
        setState(() {
          _liked = !_liked;
        });
      else {
        logger.e('like post failed');
        showSnackBarMessage(context, errorMessage, Colors.red);
      }
    }).catchError((e) {
      logger.e('error is ${e.toString()}');
      showSnackBarMessage(context, errorMessage, Colors.red);
    });
  }

  /// callback to insert an overlay entry to choose which blog to use in reblogging
  void _showBlogsPicker(context) {
    User user = Provider.of<User>(context, listen: false);
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
                        progressIndicatorBuilder: (context, url, progress) =>
                            LimitedBox(
                                maxHeight: 40,
                                maxWidth: 40,
                                child: CircularProgressIndicator()),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
    Overlay.of(context).insert(_blogsSelectorPopup);
  }

  /// Build the widget with actions icon ['like', 'reblog', 'comment', 'share]
  Widget _optionIcon(IconData icon, Function callback, Color color) {
    return InkWell(
      onTap: callback,
      enableFeedback: false,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Icon(
          icon,
          size: _interactIocnSize,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ...[
        // share icon
        GestureDetector(
          child: _optionIcon(
              CustomIcons.share, () => _showSharePage(context), Colors.black),
        ),
        // notes icon
        _optionIcon(CustomIcons.chat, widget._showNotesPage, Colors.black),
        // reblog icon
        GestureDetector(
          onLongPress: () => _showBlogsPicker(context),
          onLongPressEnd: (details) => _blogsSelectorPopup.remove(),
          child: _optionIcon(
              CustomIcons.reblog,
              () => widget._post.reblogPost(context),
              _reblogged ? Colors.green : Colors.black),
        ),
        // like icon
        _optionIcon(_liked ? CustomIcons.heartFilled : CustomIcons.heart,
            () => _likePost(), _liked ? Colors.red : Colors.black),
      ],
      if (widget._post.blogTitle == widget._activeBlogTitle) ...[
        // remove icon
        _optionIcon(CustomIcons.remove, () {
          widget._post
              .deletePost(context,
                  Provider.of<Authentication>(context, listen: false).token)
              .then(
            (value) {
              if (!value) {
                showSnackBarMessage(context, errorMessage, Colors.red);
              }
            },
          ).catchError((error) {
            logger.e(error.toString());
            showSnackBarMessage(context, errorMessage, Colors.red);
          });
        }, Colors.black),
        // edit icon
        _optionIcon(Icons.edit_outlined, () => widget._post.editPost(context),
            Colors.black),
      ]
    ]);
  }
}
