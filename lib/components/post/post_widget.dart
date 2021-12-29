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
    //final int len = post.trail.length;
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(
            id: _post.id,
            blogAvatar: _post.blogAvatar,
            blogHandle: _post.blogHandle,
            blogId: _post.blogId,
            blogTitle: _post.blogTitle,
            publishedOn: _post.publishedOn,
            isReblogged: _post.isReblogged,
            showOptionsIcon: _post.blogTitle !=
                Provider.of<User>(context, listen: false).getActiveBlogTitle(),
            showFollowButton: Provider.of<User>(context, listen: false)
                    .getActiveBlogIsPrimary() &&
                Provider.of<User>(context, listen: false)
                        .followingBlogs
                        .singleWhere(
                          (element) => element['_id'] == _post.blogId,
                          orElse: () => null,
                        ) ==
                    null,
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
