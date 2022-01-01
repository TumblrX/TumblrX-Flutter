/*
  Description:
      this file creates a class that extends stateful widget to view
      likes inside the notes page
      post id is passed to the constructor to be used in API requests
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/notes.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:tumblrx/utilities/custom_icons.dart';

class LikesPage extends StatelessWidget {
  final String _postId;
  LikesPage({Key key, @required String postId})
      : _postId = postId,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    //dismiss keyboard if opened
    FocusScope.of(context).requestFocus(FocusNode());

    List<Notes> likes = [];
    return FutureBuilder(
        // fetch likes on this post
        future: Notes.getNotes('like',
            Provider.of<Authentication>(context, listen: false).token, _postId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // if request is still being processed, render a progress indicator
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
            // if request is done, check for likes
            case ConnectionState.done:
              // if something wrong happened, render an error icon
              if (snapshot.hasError)
                return Center(
                  child: Icon(Icons.error_outline),
                );
              if (snapshot.hasData) {
                // if no likes yet, render a placeholder
                if (snapshot.data.length == 0)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          CustomIcons.heart,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'No likes yet',
                          style: kBiggerTextStyle.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  );
                likes = snapshot.data;

                // else, render likes
                return Container(
                  child: ListView.builder(
                      itemCount: likes.length,
                      itemBuilder: (context, index) {
                        Blog blogData = likes[index].blogData;
                        // get blogavatar to be viewed, set to default in case of none
                        String blogAvatar = (blogData.blogAvatar == null ||
                                blogData.blogAvatar == 'none')
                            ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
                            : blogData.blogAvatar;
                        final User user =
                            Provider.of<User>(context, listen: false);
                        final bool showFollowButton =
                            blogData.title != user.getActiveBlogTitle() &&
                                user.getActiveBlogIsPrimary();
                        // build a list tile to view owner of the like
                        return ListTile(
                          leading: blogData.isCircleAvatar
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(blogAvatar),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Image.network(
                                    blogAvatar,
                                    fit: BoxFit.cover,
                                  )),
                          title: Text(blogData.title),
                          subtitle: Text(blogData.handle),
                          // if different blog, and active blog is primary
                          // show follow button
                          trailing: showFollowButton
                              ? TextButton(
                                  onPressed: () {
                                    logger.d('blog id is ${blogData.id}');
                                    user.userBlogs[user.activeBlogIndex]
                                        .followBlog(
                                            blogData.id,
                                            Provider.of<Authentication>(context,
                                                    listen: false)
                                                .token);
                                  },
                                  child: Text('Follow'))
                              : Container(width: 0, height: 0),
                          onTap: () => Navigator.of(context).pushNamed(
                              'blog_screen',
                              arguments: {'blogHandle': blogData.handle}),
                        );
                      }),
                );
              }
          }
          return Center(
            child: Icon(Icons.error_outline),
          );
        });
  }
}
