import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';

class CommentField extends StatefulWidget {
  final String _postId;
  final ValueNotifier<bool> _commentNotifier;
  CommentField(
      {Key key,
      @required String postId,
      @required ValueNotifier commentNotifier})
      : _postId = postId,
        _commentNotifier = commentNotifier,
        super(key: key);

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  TextEditingController _textInputController;

  bool allowReply = false;

  @override
  void initState() {
    super.initState();
    _textInputController = TextEditingController();
  }

  @override
  void dispose() {
    _textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = MediaQuery.of(context).size.width * 0.1;
    return Column(
      children: [
        Divider(thickness: .6),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0, top: 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CachedNetworkImage(
                  width: avatarRadius,
                  height: avatarRadius,
                  imageUrl: Provider.of<User>(context, listen: false)
                      .getActiveBlogAvatar(),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: avatarRadius,
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: imageProvider,
                  ),
                ),
              ),
              Flexible(
                child: TextField(
                  controller: _textInputController,
                  onChanged: (string) {
                    setState(() {
                      allowReply = true;
                    });
                  },
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText: "Unleash a compliment...",
                      focusColor: Colors.transparent,
                      focusedBorder: InputBorder.none),
                ),
              ),
              TextButton(
                  onPressed: allowReply
                      ? () async {
                          final String endPoint =
                              "api/post/${widget._postId}/comment";
                          Map<String, dynamic> response = await apiClient
                              .sendPostRequest(endPoint, headers: {
                            'Authorization': Provider.of<Authentication>(
                                    context,
                                    listen: false)
                                .token
                          }, reqBody: {
                            'commentText': _textInputController.text
                          });
                          logger.d(response);
                          if (!response.containsKey('error')) {
                            widget._commentNotifier.value = true;
                            setState(() {});
                          } else {
                            showSnackBarMessage(
                                context, 'Something went wrong', Colors.red);
                          }
                        }
                      : null,
                  child: Text('Reply'))
            ],
          ),
        )
      ],
    );
  }
}
