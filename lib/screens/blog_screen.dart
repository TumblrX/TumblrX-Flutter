import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/header_image.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_screen_header_text.dart';
import 'package:tumblrx/components/avatar_shape/avatar_image.dart';
import 'package:tumblrx/components/createpost/create_post.dart';
import 'package:tumblrx/components/following/following_card.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/services/creating_post.dart';

///This a initial screen you see when press on profile from navigation bar
class BlogScreen extends StatefulWidget {
  static final String id = 'blog_screen';
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    ///this controller for Tabs bar
    ///function used for Tab bars

    _tabController = new TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);

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
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height + (12 - 3) * 60),

                /// i will chnge it and make it equal total no of following-3*40

                child: Container(
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

                              TextWriting(),
                            ],
                          ),
                          //Square(),   ///show an avatar in square

                          /// show avatar in circle

                          AvatarImage()
                        ]),
                        Container(

                            /// start of Tab Bars
                            color: blogProvider.getBottomColor(),
                            child: TabBar(
                              unselectedLabelColor: Color(0xffc7c1c1),
                              labelColor: BlogScreenConstant.accent,

                              ///color of label of selected item we can change it from edit
                              indicatorColor: blogProvider.geaccentColor(),

                              ///color of indicator of selected item releted to label

                              tabs: [
                                Tooltip(
                                  ///Tooltip for when press long icon pop label
                                  message: 'Posts',
                                  child: Tab(text: 'Posts'),
                                  preferBelow: false,
                                ),
                                Tooltip(
                                  message: 'Likes',
                                  child: Tab(text: 'Likes'),
                                  preferBelow: false,
                                ),
                                Tooltip(
                                  message: 'Following',
                                  child: Tab(
                                    text: 'Following',
                                  ),
                                  preferBelow: false,
                                )
                              ],
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                            )),
                        Expanded(

                            /// pages which display content of each tab bar
                            child: Container(
                          color: blogProvider.getBottomColor(),
                          child: TabBarView(
                            children: [
                              Text('Posts'),
                              Text('Likes'),
                              FollowingCard()
                            ],
                            controller: _tabController,
                          ),
                        ))
                      ]),
                ))));
  }
}
