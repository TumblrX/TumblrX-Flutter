/*
Description: 
    A class that implementes post widget with post header, post conent, and
    post footer
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_content.dart';
import 'package:tumblrx/components/post/post_footer/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/user.dart';

class PostWidget extends StatelessWidget {
  final Post _post;
  PostWidget({Key key, @required Post post})
      : _post = post,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d(_post.blogTitle);
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (_post == null)
              ? Container()
              : PostHeader(
                  id: _post.id,
                  blogAvatar: _post.blogAvatar,
                  blogHandle: _post.blogHandle,
                  blogId: _post.blogId,
                  blogTitle: _post.blogTitle,
                  publishedOn: _post.publishedOn,
                  isReblogged: _post.isReblogged,
                  showOptionsIcon: _post.blogTitle !=
                      Provider.of<User>(context, listen: false)
                          .getActiveBlogTitle(),
                  // show follow button if the active blog is the primary blog
                  // and the post owner is not one of the blog following
                  showFollowButton: Provider.of<User>(context, listen: false)
                          .getActiveBlogIsPrimary() &&
                      Provider.of<User>(context, listen: false)
                              .followingBlogs
                              .singleWhere(
                                (element) => element.id == _post.blogId,
                                orElse: () => null,
                              ) ==
                          null &&
                      !Provider.of<User>(context).isUserBlog(_post.blogId),
                ),
          Divider(),
          PostContentView(postContent: _post.content, tags: _post.tags),
          Divider(
            color: Colors.transparent,
          ),
          PostFooter(post: _post),
        ],
      ),
    );
  }
}
