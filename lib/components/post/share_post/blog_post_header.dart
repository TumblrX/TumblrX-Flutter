// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tumblrx/components/post/post_header.dart';
// import 'package:tumblrx/models/posts/post.dart';
// import 'package:tumblrx/models/user/user.dart';

// class  BlogPostHeader extends StatelessWidget {
//    final double avatarSize = 40;
//   final double postHeaderHeight = 60;
//    final Post _post;
//    BlogPostHeader({@required Post post}):_post=post;
     


//   @override
//   Widget build(BuildContext context) {
//     final bool isRebloged = _post.reblogKey != null && _post.reblogKey.isNotEmpty;
//     final bool showFollowButton = _post.blogTitle !=
//         Provider.of<User>(context, listen: false).getActiveBlogTitle();
   
//     return SizedBox(
//       height: postHeaderHeight,
//       child: _post.blogTitle == null
//           ? Center(
//               child: Icon(
//                 Icons.error,
//               ),
//             )
//           : Padding(
//               padding: EdgeInsets.only(left: 15.0),
//               child: InkWell(
//                 onTap: () => PostHeader (index: 0,).showBlogProfile(context,_post.blogId),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     PostHeader (index: 0,).blogAvatar(_post.blogAvatar),
//                     Expanded(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                          PostHeader (index: 0,).blogInfo(_post.blogTitle, isRebloged, _post.reblogKey),
//                           showFollowButton
//                               ? TextButton(
//                                   style: ButtonStyle(
//                                     foregroundColor: MaterialStateProperty.all(
//                                         Theme.of(context)
//                                             .colorScheme
//                                             .secondary),
//                                   ),
//                                   onPressed: () => _post.followBlog(),
//                                   child: Text('Follow'),
//                                 )
//                               :PostHeader (index: 0,).emptyContainer(),
//                         ],
//                       ),
//                     ),
                   
                      
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }


