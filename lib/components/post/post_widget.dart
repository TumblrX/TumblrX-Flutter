import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/post/post_content.dart';
import 'package:tumblrx/components/post/post_footer/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
// import 'package:tumblrx/components/post/share_post/blog_post_header.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/user.dart';

class PostWidget extends StatelessWidget {
  // final bool _isLikes;
  final Post _post;
  PostWidget({Key key, @required Post post})
      : _post = post,
        // _isLikes = isLikes,
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
          // (_post != null && _isLikes == false)
          (_post == null)
              ? Container()
              // BlogPostHeader(post: _post)
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
