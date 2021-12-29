/*
Author: Passant Abdelgalil
Description: 
    The post header widget that contains blog name, follow button,
    and options icon
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/user_blog_view.dart';
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/utilities/constants.dart';

class PostHeader extends StatelessWidget {
  /// blog object of the post
  final bool _showOptionsIcon;
  final String _blogTitle;
  final String _blogHandle;
  final String _blogAvatar;
  final String _blogId;
  final String _postId;
  final bool _showFollowButton;
  final bool _isReblogged;
  final DateTime _publishedOn;
  // constants to size widgets
  final double avatarSize = 40;
  final double postHeaderHeight = 60;

  PostHeader(
      {@required String id,
      @required String blogTitle,
      @required String blogHandle,
      @required String blogAvatar,
      @required String blogId,
      @required bool showOptionsIcon,
      @required bool showFollowButton,
      @required bool isReblogged,
      @required DateTime publishedOn})
      : _postId = id,
        _publishedOn = publishedOn,
        _showOptionsIcon = showOptionsIcon,
        _blogTitle = blogTitle,
        _blogHandle = blogHandle,
        _blogAvatar = blogAvatar,
        _blogId = blogId,
        _showFollowButton = showFollowButton,
        _isReblogged = isReblogged;
  // PostHeader({@required int index, bool showOptionsIcon = true})
  //     : _index = index,
  //       _showOptionsIcon = showOptionsIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: postHeaderHeight,
      child: _blogTitle == null
          ? Center(
              child: Icon(
                Icons.error,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: InkWell(
                onTap: () => showBlogProfile(context, _blogId),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _showBlogAvatar(_blogAvatar),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: _blogInfo(_blogTitle, _isReblogged, ""),
                          ),
                          _showFollowButton
                              ? TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  onPressed: () =>
                                      Provider.of<User>(context, listen: false)
                                          .followUser(context, _blogId),
                                  child: Text('Follow'),
                                )
                              : emptyContainer(),
                        ],
                      ),
                    ),
                    _showOptionsIcon
                        ? IconButton(
                            onPressed: () => _showBlogOptions(
                                _publishedOn, context,
                                otherBlog: false),
                            icon: Icon(Icons.more_horiz),
                          )
                        : emptyContainer(),
                  ],
                ),
              ),
            ),
    );
  }

  /// navigate to the blog screen to view blog info
  void showBlogProfile(BuildContext context, String blogId) {
    if (Provider.of<User>(context, listen: false).isUserBlog(blogId))
      Navigator.of(context).pushNamed('blog_screen');
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserBlogView(
                  id: blogId,
                )),
      );
    }
  }

  Widget _blogInfo(String blogTitle, bool isRebloged, String reblogKey) =>
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 5.0),
        child: isRebloged
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    blogTitle,
                    style: TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.repeat_outlined,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: Text(
                          reblogKey,
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Text(
                blogTitle,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
      );

  /// callback to open a dialog with blog options
  void _showBlogOptions(DateTime publishedOn, BuildContext context,
      {bool otherBlog = false}) {
    final String muteNotificationMessage =
        'Would you like to mute push notifications for this particular post?';
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.3,
        child: otherBlog
            ? ListView(
                children: [
                  ListTile(
                    title: Text('Copy link'),
                    onTap: () {
                      _copyLink(_postId)
                          .then((value) => showSnackBarMessage(
                              context, 'Copied to clipboard!', Colors.green))
                          .catchError((error) {
                        showSnackBarMessage(
                            context, 'Something wrong happened!', Colors.green);
                      });
                    },
                  )
                ],
              )
            : ListView(
                children: [
                  ListTile(
                    title: Text('Mute notifications'),
                    onTap: () => _showAlert(muteNotificationMessage, context,
                        () => _muteNotifications, 'Mute'),
                  ),
                  ListTile(
                    title: Text('Copy link'),
                    onTap: () {
                      _copyLink(_postId)
                          .then((value) => showSnackBarMessage(
                              context, 'Copied to clipboard!', Colors.green))
                          .catchError((error) {
                        showSnackBarMessage(
                            context, 'Something wrong happened!', Colors.green);
                      });
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Future<bool> _copyLink(String postId) async {
    try {
      await FlutterClipboard.copy('https://tumblrx.me:5000/post/$postId');
      return true;
    } catch (err) {
      return false;
    }
  }

  void _muteNotifications(BuildContext context, String postId) {
    Provider.of<Content>(context, listen: false)
        .posts
        .firstWhere((post) => post.id == postId)
        .mutePushNotification()
        .then((value) => null)
        .catchError((err) {
      showSnackBarMessage(context, 'Something went wrong', Colors.red);
    });
  }

  void _showAlert(String alertMessage, BuildContext context,
      void Function() callBack, String confirmationText) {
    AlertDialog(
      actions: [
        TextButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
            child: Text('Nevermind'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.grey),
            )),
        TextButton(
            onPressed: callBack,
            child: Text(confirmationText),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
            )),
      ],
    );
  }

  Widget errorAvatar() => CircleAvatar(
        child: Icon(Icons.error),
      );

  Widget emptyContainer() => Container(
        width: 0,
        height: 0,
      );

  Widget blogInfo(String blogTitle, bool isRebloged, String reblogKey) =>
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 5.0),
        child: isRebloged
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    blogTitle,
                    style: TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                    softWrap: true,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.repeat_outlined,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: Text(
                          reblogKey,
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Text(
                blogTitle,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
      );

  Widget _showBlogAvatar(String blogAvatar) => CachedNetworkImage(
        width: avatarSize,
        height: avatarSize,
        imageUrl: blogAvatar,
        progressIndicatorBuilder: (context, url, progress) => SizedBox(
          width: avatarSize,
          height: avatarSize,
          child: Center(child: const CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => errorAvatar(),
      );
}


/*

TODOs:
  1. Mute notifications
  2. Pin post  
*/ 