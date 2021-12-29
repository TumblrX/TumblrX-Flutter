import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';

class CheckOutTheseBlogs extends StatelessWidget {
  final List<Blog> _blogs;
  const CheckOutTheseBlogs({Key key, @required List<Blog> blogs})
      : _blogs = blogs,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          width: 12,
        ),
        itemCount: min(_blogs.length, 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final Blog blog = _blogs[index];
          final String blogAvatar = blog.blogAvatar == 'none'
              ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
              : blog.blogAvatar;
          final String blogHeaderImage = blog.blogTheme != null
              ? blog.blogTheme.headerImage ??
                  "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
              : "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png";
          // final Color blogBackgroundColor = blog.blogTheme != null &&
          //         blog.blogTheme.backgroundColor != null
          //     ? Color(int.parse(
          //             '0xFF${blog.blogTheme.backgroundColor.substring(1, 6)}')) ??
          //         Colors.pink
          //     : Colors.pink;
          final Color blogBackgroundColor = Colors.pink;
          final cardHeight = MediaQuery.of(context).size.height * .2;
          final cardWidth = MediaQuery.of(context).size.width * 0.35;
          return Material(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('blog_screen');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: cardWidth,
                height: cardHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // header image
                    Positioned(
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: blogHeaderImage,
                            imageBuilder: (context, imageProvider) => Container(
                              height: cardHeight * 0.35,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    blogHeaderImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: cardWidth * .375,
                              width: cardWidth,
                              color: Colors.grey,
                              child: Icon(Icons.error),
                            ),
                          ),

                          // header background color
                          Container(
                            color: blogBackgroundColor,
                            height: cardHeight * .65,
                          ),
                        ],
                      ),
                    ),
                    // blog avatar
                    Positioned(
                      top: cardHeight * .15,
                      child: CircleAvatar(
                        radius: cardHeight * .17,
                        backgroundImage: NetworkImage(blogAvatar),
                      ),
                    ),
                    // blog title
                    Positioned(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            blog.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        bottom: cardHeight * .3),
                    // follow button
                    Positioned(
                      width: cardWidth * .9,
                      bottom: 1,
                      child: TextButton(
                        onPressed: () {
                          final User user =
                              Provider.of<User>(context, listen: false);
                          user.userBlogs[user.activeBlogIndex]
                              .followBlog(
                                  blog.id,
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .token)
                              .then((value) {
                            showSnackBarMessage(
                                context,
                                'followed ${blog.title} successfully',
                                Colors.green);
                          }).catchError((err) {
                            logger.e(err);
                            showSnackBarMessage(
                                context, 'something went wrong', Colors.red);
                          });
                        },
                        child: Text('Follow'),
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
