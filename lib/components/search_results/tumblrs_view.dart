import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/utilities/constants.dart';

class TumblrView extends StatelessWidget {
  final Blog _blog;
  const TumblrView({Key key, @required Blog blog})
      : _blog = blog,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final String blogAvatar = _blog == null ||
            _blog.blogAvatar == 'none' ||
            _blog.blogAvatar == null
        ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
        : _blog.blogAvatar;
    final String blogHeaderImage = _blog != null && _blog.blogTheme != null
        ? _blog.blogTheme.headerImage ??
            "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
        : "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png";
    // final Color blogBackgroundColor = blog.blogTheme != null &&
    //         blog.blogTheme.backgroundColor != null
    //     ? Color(int.parse(
    //             '0xFF${blog.blogTheme.backgroundColor.substring(1, 6)}')) ??
    //         Colors.pink
    //     : Colors.pink;

    final Color blogBackgroundColor = Colors.pink;
    final double cardHeight = MediaQuery.of(context).size.height * .6;
    final double cardWidth = MediaQuery.of(context).size.width;

    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('blog_screen');
        },
        child: Container(
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // header image
              Positioned(
                top: 0,
                height: cardHeight,
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: blogHeaderImage,
                          imageBuilder: (context, imageProvider) => Container(
                            width: cardWidth,
                            height: cardHeight * .2,
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
                            color: Colors.grey,
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    // header background color
                    Container(
                      color: blogBackgroundColor,
                      height: cardHeight * .5,
                      width: cardWidth,
                    ),
                  ],
                ),
              ),
              // blog avatar
              Positioned(
                top: cardHeight * .28,
                child: CircleAvatar(
                  radius: cardHeight * .13,
                  backgroundImage: NetworkImage(blogAvatar),
                ),
              ),
              // blog title
              Positioned(
                top: cardHeight * .57,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    _blog == null ? "untitled" : _blog.title ?? "untitled",
                    style:
                        kBiggerTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // blog description
              Positioned(
                top: cardHeight * .65,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    _blog == null
                        ? "hi there mock description"
                        : _blog.description ?? "hi there mock description",
                  ),
                ),
              ),

              // 3 random images to view for tumblr
              Positioned(
                height: cardHeight * .25,
                top: cardHeight * .73,
                width: cardWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      color: Colors.amber,
                      width: cardHeight * .25,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      color: Colors.blue,
                      width: cardHeight * .25,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      color: Colors.purple,
                      width: cardHeight * .25,
                    ),
                  ],
                ),
              ),

              // // follow button
              // Positioned(
              //   width: cardWidth * .9,
              //   bottom: 1,
              //   child: TextButton(
              //     onPressed: () {
              //       final User user =
              //           Provider.of<User>(context, listen: false);
              //       user.userBlogs[user.activeBlogIndex]
              //           .followBlog(
              //               blog.id,
              //               Provider.of<Authentication>(context,
              //                       listen: false)
              //                   .token)
              //           .then((value) {
              //         showSnackBarMessage(
              //             context,
              //             'followed ${blog.title} successfully',
              //             Colors.green);
              //       }).catchError((err) {
              //         logger.e(err);
              //         showSnackBarMessage(
              //             context, 'something went wrong', Colors.red);
              //       });
              //     },
              //     child: Text('Follow'),
              //     style: ButtonStyle(
              //       alignment: Alignment.center,
              //       backgroundColor:
              //           MaterialStateProperty.all(Colors.black),
              //       foregroundColor:
              //           MaterialStateProperty.all(Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
