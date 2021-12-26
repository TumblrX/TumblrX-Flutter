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
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/utilities/constants.dart';

class PostHeader extends StatelessWidget {
  /// blog object of the post
  final int _index;
  final bool _showOptionsIcon;

  // constants to size widgets
  final double avatarSize = 40;
  final double postHeaderHeight = 60;

  PostHeader({@required int index, bool showOptionsIcon = true})
      : _index = index,
        _showOptionsIcon = showOptionsIcon;

  @override
  Widget build(BuildContext context) {
    final Post post =
        Provider.of<Content>(context, listen: false).posts[_index];

    final bool isRebloged = post.reblogKey != null && post.reblogKey.isNotEmpty;
    final bool showFollowButton = post.blogTitle !=
        Provider.of<User>(context, listen: false).getActiveBlogTitle();
    return SizedBox(
      height: postHeaderHeight,
      child: post.blogTitle == null
          ? Center(
              child: Icon(
                Icons.error,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: InkWell(
                onTap: () => _showBlogProfile(
                    context: context, blogHandle: post.blogHandle),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _blogAvatar(post.blogAvatar),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _blogInfo(post.blogTitle, isRebloged, post.reblogKey),
                          showFollowButton
                              ? TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  onPressed: () {
                                    final User user = Provider.of<User>(context,
                                        listen: false);
                                    user.userBlogs[user.activeBlogIndex]
                                        .followBlog(post.postBlog.id, context);
                                  },
                                  child: Text('Follow'),
                                )
                              : _emptyContainer(),
                        ],
                      ),
                    ),
                    _showOptionsIcon
                        ? IconButton(
                            onPressed: () => _showBlogOptions(
                                post.publishedOn, context,
                                otherBlog: false, postId: post.id),
                            icon: Icon(Icons.more_horiz),
                          )
                        : _emptyContainer(),
                  ],
                ),
              ),
            ),
    );
  }

  /// navigate to the blog screen to view blog info
  void _showBlogProfile({BuildContext context, @required String blogHandle}) {
    Navigator.of(context)
        .pushNamed('blog_screen', arguments: {'blogHandle': blogHandle});
  }

  /// callback to open a dialog with blog options
  void _showBlogOptions(DateTime publishedOn, BuildContext context,
      {bool otherBlog = false, @required String postId}) {
    final String muteNotificationMessage =
        'Would you like to mute push notifications for this particular post?';
    showModalBottomSheet(
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.3,
        child: otherBlog
            ? ListView(
                children: [
                  ListTile(
                    title: Text('Copy link'),
                    onTap: () {
                      copyLink(postId)
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
                      copyLink(postId)
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

  Future<bool> copyLink(String postId) async {
    try {
      await FlutterClipboard.copy('https://tumblrx.me:5000/post/$postId');
      return true;
    } catch (err) {
      return false;
    }
  }

  void _muteNotifications(BuildContext context) {
    Provider.of<Content>(context, listen: false)
        .posts[_index]
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

  Widget _errorAvatar() => CircleAvatar(
        child: Icon(Icons.error),
      );

  Widget _emptyContainer() => Container(
        width: 0,
        height: 0,
      );

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

  Widget _blogAvatar(String blogAvatar) => CachedNetworkImage(
        width: avatarSize,
        height: avatarSize,
        imageUrl: blogAvatar,
        placeholder: (context, url) => SizedBox(
          width: avatarSize,
          height: avatarSize,
          child: Center(child: const CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => _errorAvatar(),
      );
}

/*

TODOs:
  1. Mute notifications
  2. Pin post  
*/ 