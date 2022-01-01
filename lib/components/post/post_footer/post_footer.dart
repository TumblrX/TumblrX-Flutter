/*
Description: 
    The post footer widget that contains reactions count and icons, and 
    post options: share, comment, reblog, and like/unlike, [edit, delete]
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_notes/notes_page.dart';
import 'package:tumblrx/components/post/share_post/share_post_widget.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:tumblrx/utilities/custom_icons.dart';

class PostFooter extends StatefulWidget {
  final Post _post;

  PostFooter({@required Post post}) : _post = post;

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  // constants to size icons
  final double _reactionsIconSize = 20;
  final double _interactIocnSize = 18;
  // error message to view in snackBarMessage
  final String errorMessage = 'Something went wrong';
  // flag to indicate it the blog reblogged the post
  bool _reblogged = false;

  // overlay entry to be inserted on top of the content to select blogs
  OverlayEntry _blogsSelectorPopup;

  // string to hold the current active blog title
  String _activeBlogTitle;

  @override
  Widget build(BuildContext context) {
    // get active blog name to check the action icons view mode
    _activeBlogTitle =
        Provider.of<User>(context, listen: false).getActiveBlogTitle();

    // build the post footer widget
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildReactionIcons(),
          _buildOptionsIcons(),
        ],
      ),
    );
  }

  /// private helper function to return row of options icon
  /// [share, comment, reblog, like] and can be extended to include
  /// [edit, delete] icons in case the post owner is the current active blog
  Widget _buildOptionsIcons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ...[
        // share icon
        _optionIcon(
            icon: CustomIcons.share,
            callback: () => _showSharePage(context),
            color: Colors.black),

        // notes icon
        _optionIcon(
            icon: CustomIcons.chat,
            callback: () => _showNotesPage(context),
            color: Colors.black),
        // reblog icon
        GestureDetector(
          onLongPress: () => _showBlogsPicker(context),
          onLongPressEnd: (details) => _blogsSelectorPopup.remove(),
          child: _optionIcon(
              icon: CustomIcons.reblog,
              callback: () => widget._post.reblogPost(context),
              color: _reblogged ? Colors.green : Colors.black),
        ),
        // like icon
        _optionIcon(
            icon: widget._post.liked
                ? CustomIcons.heartFilled
                : CustomIcons.heart,
            callback: () => _likePost(),
            color: widget._post.liked ? Colors.red : Colors.black),
      ],
      if (widget._post.blogTitle == _activeBlogTitle) ..._editAndDeleteIcons()
    ]);
  }

  /// private helper function returns [edit, delete] icons as a list of widgets
  List<Widget> _editAndDeleteIcons() {
    return [
      // remove icon
      _optionIcon(
          icon: CustomIcons.remove,
          callback: () {
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
          },
          color: Colors.black),
      // edit icon
      _optionIcon(
          icon: Icons.edit_outlined,
          callback: () => widget._post.editPost(context),
          color: Colors.black),
    ];
  }

  /// private helper function to return row of total number of notes on the post
  /// next to reaction icons if any [like, reblog, comment]
  Widget _buildReactionIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget._post.totalNotes > 0
          ? [
              InkWell(
                onTap: () => _showNotesPage,
                child: _notesIcons(),
              ),
              TextButton(
                child: Text(
                  '${widget._post.totalNotes.toString()} notes',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                onPressed: () => _showNotesPage(context),
              ),
            ]
          : [],
    );
  }

  /// private hleper function as a callback to be called on tap on notes region
  /// the function pushes to the navigator a page route to view notes
  void _showNotesPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotesPage(
            postId: widget._post.id,
            totlaNotes: widget._post.totalNotes,
            commentCount: widget._post.commentsCount,
            likeCount: widget._post.likesCount,
            reblogCount: widget._post.reblogsCount),
      ),
    );
  }

  /// private hleper function as a callback to be called on tap on share icon
  /// the function opens a bottom sheet to view share widget with share options
  _showSharePage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
          heightFactor: 0.9, child: SharePostWidget(widget._post)),
    );
  }

  /// private helper function to build the widget of the passed reaction icon
  /// with the passed color
  Widget _reactionIcon({@required IconData icon, @required Color color}) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(2),
        color: Colors.white,
        child: ClipOval(
            child: Icon(
          icon,
          color: color,
          size: _reactionsIconSize,
        )),
      ),
    );
  }

  /// callback to insert an overlay entry to choose which blog to use in reblogging
  /// private helper function as a callback to be called on long press on reblog
  /// icon the function constructs the entery with available user blogs and
  ///  insert it in the overlay
  void _showBlogsPicker(context) {
    User user = Provider.of<User>(context, listen: false);
    logger.d(user.userBlogs.length);
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

  /// private helper function as a callback to be called on tap on like icon
  /// it handles like/unlike api requests and sets the state of the widget
  void _likePost() {
    logger.d('like status is ${widget._post.liked.toString()}');
    Future<bool> success = widget._post.liked
        ? widget._post.unlikePost(context)
        : widget._post.likePost(context);
    success.then((value) {
      if (value)
        setState(() {
          logger.d('like status is ${widget._post.liked.toString()}');
        });
      else {
        logger.e('couldn\'t like post');
        showSnackBarMessage(context, errorMessage, Colors.red);
      }
    }).catchError((e) {
      logger.e('error is $e');
      showSnackBarMessage(context, errorMessage, Colors.red);
    });
  }

  /// private helper function to build the widget of the passed reaction icon
  /// with the passed color and passed callback function
  Widget _optionIcon(
      {@required IconData icon,
      @required Function callback,
      @required Color color}) {
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

  /// Builds the widget of stacked notes icon ['likes', 'reblogs', 'comments']
  Widget _notesIcons() {
    // constant shifting amount, should be < icon size
    final double shiftAmount = 20.0;

    // list of icons
    List<Widget> stacked = [];
    int index = 0;
    // check if any comment => insert the comment icon
    if (widget._post.commentsCount > 0) {
      stacked.add(Container(
        child: _reactionIcon(icon: CustomIcons.comment, color: Colors.blue),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
      index++;
    }
    // check if any reblog => insert the reblog icon
    if (widget._post.reblogsCount > 0) {
      stacked.add(Container(
        child: _reactionIcon(icon: CustomIcons.reblogs, color: Colors.green),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
      index++;
    }
    // check if any like => insert the like icon
    if (widget._post.likesCount > 0) {
      stacked.add(Container(
        child: _reactionIcon(icon: CustomIcons.like, color: Colors.red),
        margin: EdgeInsets.only(left: shiftAmount * index),
      ));
    }
    // stacked notes icon widget
    return Stack(
      children: stacked.reversed.toList(),
    );
  }
}
