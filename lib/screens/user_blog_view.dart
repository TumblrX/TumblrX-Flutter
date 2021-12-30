import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/avatar_shape/avatar_image.dart';
import 'package:tumblrx/components/avatar_shape/square.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_screen_header_text.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_widgets.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/header_image.dart';
import 'package:tumblrx/components/post/post_widget.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

import 'chat_screen.dart';

class UserBlogView extends StatefulWidget {
  final String _blogId;
  UserBlogView({@required String id}) : _blogId = id;

  @override
  _UserBlogViewState createState() => _UserBlogViewState();
}

class _UserBlogViewState extends State<UserBlogView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Blog _blog = Blog();
    _blog.setBlogId(widget._blogId);
    return FutureBuilder<Blog>(
      future: _blog.blogRetrive(context),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return Scaffold(
              appBar: AppBar(
                //elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(snapshot.data.handle),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      if (snapshot.data.isPrimary)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              userId: snapshot.data.ownerId,
                              receiverUsername: snapshot.data.handle,
                              receiverAvatarUrl: snapshot.data.blogAvatar,
                              myAvatarUrl: Provider.of<User>(context)
                                  .getPrimaryBlogAvatar(),
                              myUsername: Provider.of<User>(context).username,
                            ),
                          ),
                        );
                    },
                  ),
                  PopupMenuButton<String>(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: Text('Share'),
                          value: 'Share',
                        ),
                        PopupMenuItem(
                          child: Text('Get notifications'),
                          value: 'Get notifications',
                        ),
                        PopupMenuItem(
                          child: Text('Block'),
                          value: 'Block',
                        ),
                        PopupMenuItem(
                          child: Text('Report'),
                          value: 'Report',
                        ),
                        PopupMenuItem(
                          child: Text('Unfollow'),
                          value: 'Unfollow',
                        ),
                      ];
                    },
                    onSelected: (value) {
                      // add action
                    },
                    icon: Icon(
                      Icons.person,
                    ),
                  ),
                ],
              ),
              body: Center(
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height +
                          MediaQuery.of(context).size.height / 3),
                  child: Container(
                    color: Colors.blue,
                    constraints: !kIsWeb
                        ? BoxConstraints()
                        : BoxConstraints(
                            maxWidth: 750.0,
                            minWidth: MediaQuery.of(context).size.width < 750
                                ? MediaQuery.of(context).size.width * 0.9
                                : 750.0,
                          ),
                    child: Column(

                        /// couloum have(the header image , avatar,title, description and tab bars )

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(alignment: Alignment.center, children: <Widget>[
                            Column(
                              children: <Widget>[
                                ///display header image with icons and drop down list

                                // HeaderImage(),
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              BlogScreenConstant.headerImgPath),
                                          fit: BoxFit.fill)), //dummy image
                                  height: MediaQuery.of(context).size.height /
                                      3.6, //(200)
                                ),

                                ///display header image with icons and drop down list

                                TextWriting(
                                  title: snapshot.data.title,
                                  description: snapshot.data.description,
                                  color: snapshot.data.backGroundColor,
                                  textColor: snapshot.data.titleColor,
                                ),
                              ],
                            ),

                            ///show an avatar in square

                            ///show an avatar in square
                            Visibility(
                                visible: snapshot.data.showAvatar ?? true,
                                child: snapshot.data.isCircleAvatar
                                    ? AvatarImage(
                                        myBlog: false,
                                        path: snapshot.data.blogAvatar,
                                        color: snapshot.data.backGroundColor,
                                      )
                                    : Square(
                                        color: snapshot.data.backGroundColor,
                                        path: snapshot.data.blogAvatar,
                                      ))
                          ]),

                          //{

                          if (snapshot.data.isPrimary)
                            upperTabBar(_tabController, context,
                                snapshot.data.backGroundColor),
                          if (snapshot.data.isPrimary)
                            bottomTabBar(_tabController, context,
                                snapshot.data.backGroundColor, _blog),
                          //}
                          if (!snapshot.data.isPrimary)
                            Container(
                              color: hexToColor(snapshot.data.backGroundColor),
                              child: FutureBuilder<List<Post>>(
                                future: _blog.blogPosts(context, false),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data.length != 0) {
                                    return Expanded(
                                      child: ListView.separated(
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Post post = snapshot.data[index];
                                          return PostWidget(
                                            post: snapshot.data[index],
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                                height: 20.0,
                                                color: Colors.transparent),
                                      ),
                                    );

                                    /* PostWidget(
                              postContent: snapshot.data[0].content,
                              index: 0,
                                post: snapshot.data[0],
                                isLikes: false,
                                );*/
                                    // PostWidget(
                                    //postContent: snapshot.data[0].content,
                                    //index: 0,
                                    //post: snapshot.data[0],
                                    //);
                                  } else if (snapshot.hasError) {
                                    return Text('no');
                                  } else if (snapshot.data == null ||
                                      snapshot.data.length == 0) {
                                    return Column();
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            )
                        ]),
                  ),

                  /// i will chnge it and make it equal total no of following-3*40
                )),
              ));
        else if (snapshot.hasError) return Text('error');
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
