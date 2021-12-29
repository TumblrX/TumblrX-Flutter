import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/avatar_shape/square.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_widgets.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/header_image.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_screen_header_text.dart';
import 'package:tumblrx/components/avatar_shape/avatar_image.dart';
import 'package:tumblrx/components/createpost/create_post.dart';
import 'package:tumblrx/components/post/post_widget.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/creating_post.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

///This a initial screen you see when press on profile from navigation bar
class BlogScreen extends StatefulWidget {
  static final String id = 'blog_screen';
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  Future<Post> blogpost;
  TabController _tabController;
  ScrollController _controller;
  @override
  void initState() {
    ///this controller for Tabs bar
    ///function used for Tab bars

    _tabController = new TabController(length: 3, vsync: this);

    super.initState();
    // Provider.of<User>(context, listen: false)
    //   .getUserPosts(context); //esraa added

    Provider.of<User>(context,listen: false).getUserBlogFollowing(context);
    //intialize befor edit

    // print(
    //   Provider.of<User>(context, listen: false).getActiveBlogPosts() == null);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final blogProvider = Provider.of<BlogScreenConstantProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF001935),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit),
        onPressed: () {
          double topPadding = MediaQuery.of(context).padding.top;
          Provider.of<CreatingPost>(context, listen: false)
              .initializePostOptions(context);
          !kIsWeb
              ? showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: CreatePost(
                      topPadding: topPadding,
                    ),
                  ),
                )
              : showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: CreatePost(
                          topPadding: topPadding,
                        ),
                      ));
        },
      ),
      body: Center(
        child: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height +
                  MediaQuery.of(context).size.height / 3),

          /// i will chnge it and make it equal total no of following-3*40

          child: Container(
            color: hexToColor(Provider.of<User>(context, listen: false)
                    .getActiveBlogBackColor()) ??
                Colors.blue,
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

                        HeaderImage(),

                        ///display header image with icons and drop down list

                        TextWriting(
                          title: Provider.of<User>(context, listen: false)
                              .getActiveBlogTitle(),
                          description: Provider.of<User>(context, listen: false)
                              .getActiveBlogDescription(),
                              color: Provider.of<User>(context, listen: false)
                              .getActiveBlogBackColor() ,
                              textColor: Provider.of<User>(context, listen: false)
                          .getActiveBlogTitleColor(),
                        ),
                      ],
                    ),

                    ///show an avatar in square

                    ///show an avatar in square
                    Visibility(
                        visible: Provider.of<User>(context, listen: false)
                                .getActiveBlogShowAvatar() ??
                            true,
                        child: Provider.of<User>(context, listen: false)
                                .getIsAvatarCircle()
                            ? AvatarImage(myBlog: true,color: Provider.of<User>(context, listen: false)
                          .getActiveBlogBackColor(),)
                            : Square(color: Provider.of<User>(context, listen: false)
                                .getActiveBlogBackColor(),))
                  ]),

                  //{

                  if (Provider.of<User>(context).getActiveBlogIsPrimary())
                    upperTabBar(_tabController, context,Provider.of<User>(context, listen: false)
            .getActiveBlogBackColor()),
                  if (Provider.of<User>(context).getActiveBlogIsPrimary())
                    bottomTabBar(_tabController, context,Provider.of<User>(context, listen: false)
            .getActiveBlogBackColor(),Provider.of<User>(context, listen: false).getActiveBlog()),
                  //}
                  if (Provider.of<User>(context).getActiveBlogIsPrimary() ==
                      false)
                    Container(
                      child: FutureBuilder<List<Post>>(
                        future: Provider.of<User>(context).getActiveBlogPosts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data.length != 0) {
                            return Expanded(
                              child: ListView.separated(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Post post = snapshot.data[index];
                                  return PostWidget(
                                    postContent: post.content,
                                    tags: post.tags,
                                    index: 0,
                                    post: snapshot.data[index],
                                    isLikes: false,
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
        )),
      ),
    );
  }
}
