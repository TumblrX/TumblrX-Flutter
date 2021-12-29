import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_notes/comment_field_widget.dart';
import 'package:tumblrx/models/notes.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:tumblrx/utilities/custom_icons.dart';

class CommentsPage extends StatefulWidget {
  final String _postId;
  CommentsPage({Key key, @required String postId})
      : _postId = postId,
        super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  ValueNotifier<bool> _commentNotifier;
  @override
  void initState() {
    super.initState();
    _commentNotifier = ValueNotifier(false);
    _commentNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _commentNotifier.removeListener(() {});
    _commentNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Notes> comments = [];
    _commentNotifier.value = false;
    return Center(
      child: FutureBuilder(
        // fetch comments on the post
        future: Notes.getNotes(
            'comment',
            Provider.of<Authentication>(context, listen: false).token,
            widget._postId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // if still processing the request, render a circular progress indicator
            case ConnectionState.active:
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            // if request is done, check response
            case ConnectionState.done:
              // if something wrong happened, render an error icon
              if (snapshot.hasError)
                return Center(
                  child: Icon(Icons.error_outline),
                );
              comments = snapshot.data;
              return Column(
                children: [
                  // if no comments on the post, render a placeholder
                  if (comments.length == 0) ...[
                    Expanded(
                      //alignment: Alignment.bottomCenter,
                      //height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              CustomIcons.chat,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Be the first to reply!',
                              style:
                                  kBiggerTextStyle.copyWith(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  // else render comments
                  if (comments.length > 0) ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final Notes note = comments[index];
                          final String blogAvatar = note.blogData.blogAvatar ==
                                      null ||
                                  note.blogData.blogAvatar == 'none'
                              ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
                              : note.blogData.blogAvatar;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // blog avatar
                                note.blogData.isCircleAvatar
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(blogAvatar),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image.network(
                                          blogAvatar,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                // comment text box
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          style: BorderStyle.solid,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            note.blogData.title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              note.commentText,
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  CommentField(
                    commentNotifier: _commentNotifier,
                    postId: widget._postId,
                  ),
                ],
              );
          }
          return Container();
        },
      ),
    );
  }
}
