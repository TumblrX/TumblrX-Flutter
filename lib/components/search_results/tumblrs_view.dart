/*
Description: 
    A class that implementes  widget to view blogs in the search result screen
*/
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_blocks/image_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/text_block_widget.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/utilities/constants.dart';

class TumblrView extends StatelessWidget {
  final Blog _blog;
  const TumblrView({Key key, @required Blog blog})
      : _blog = blog,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // get blog avatar link, set to default in case of none
    final String blogAvatar = _blog == null ||
            _blog.blogAvatar == 'none' ||
            _blog.blogAvatar == null
        ? "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
        : _blog.blogAvatar;
    // get blog header image link, set to default in case of none
    final String blogHeaderImage = _blog != null
        ? _blog.headerImage ??
            "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
        : "https://64.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png";
    // get blog background color, set to default in case of none
    // final Color blogBackgroundColor = blog.blogTheme != null &&
    //         blog.blogTheme.backgroundColor != null
    //     ? Color(int.parse(
    //             '0xFF${blog.blogTheme.backgroundColor.substring(1, 6)}')) ??
    //         Colors.pink
    //     : Colors.pink;

    final Color blogBackgroundColor = Colors.pink;
    // card dimensions
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
                            width: cardWidth,
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
                child: CachedNetworkImage(
                  imageUrl: blogAvatar,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: cardHeight * .13,
                    backgroundImage: imageProvider,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: cardHeight * .13,
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              // blog title
              Positioned(
                top: cardHeight * .57,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    _blog == null ? "" : _blog.title ?? "",
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
                    _blog == null ? "" : _blog.description ?? "",
                  ),
                ),
              ),

              // 3 random images from blog posts to view for tumblr
              Positioned(
                height: cardHeight * .25,
                top: cardHeight * .73,
                width: cardWidth,
                child: FutureBuilder(
                  future: _blog.blogPosts(context, false),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasError)
                          return Center(
                            child: Icon(Icons.error),
                          );
                        if (!snapshot.hasData)
                          return Container(
                            child: Center(
                              child: Text('no posts yet'),
                            ),
                          );
                        if (snapshot.data.length == 0)
                          return Container(
                            child: Center(
                              child: Text('no posts yet'),
                            ),
                          );
                        List<Post> posts = snapshot.data;
                        logger.e(posts);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _showBlogPostSamples(posts, cardHeight),
                        );
                    }
                    return Center(
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// private helper function to select and view blog posts
  List<Widget> _showBlogPostSamples(List<Post> posts, double cardHeight) {
    List<Widget> blocks = [];
    for (var post in posts) {
      if (blocks.length == 3) break;
      // get a post from blog posts if it contains text/image block
      final blockContent = post.content.firstWhere(
        (element) =>
            element.runtimeType == TextBlock ||
            element.runtimeType == ImageBlock,
        orElse: () => null,
      );
      // if no block met the condition, skip this post
      if (blockContent == null) {
        logger.e('no block');
        continue;
      }
      // if the block is textblock call the right widget
      if (blockContent.runtimeType == TextBlock)
        blocks.add(
          Container(
            padding: EdgeInsets.all(4),
            color: Colors.white,
            width: cardHeight * .25,
            height: cardHeight * .25,
            child: TextBlockWidget(
                text: blockContent.formattedText,
                sharableText: blockContent.text),
          ),
        );
      // if the block is imageblock call the right widget
      if (blockContent.runtimeType == ImageBlock)
        blocks.add(
          Container(
            padding: EdgeInsets.all(4),
            color: Colors.white,
            width: cardHeight * .25,
            height: cardHeight * .25,
            child: ImageBlockWidget(
              media: blockContent.media,
            ),
          ),
        );
    }
    // if no blocks are found, inform the user
    if (blocks.length == 0) {
      logger.e('blocks are empty');
      blocks.add(Center(
        child: Text('Visit blog profile to view posts'),
      ));
    }
    return blocks;
  }
}
