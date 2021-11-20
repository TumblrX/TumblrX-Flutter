import 'package:flutter/material.dart';
import 'package:tumblrx/Components/blog_screen_constant.dart';
import 'package:tumblrx/Components/avatar_shape/avatar.dart';
import 'package:tumblrx/Components/blog_screen_initial_screen/header_image.dart';
import 'package:tumblrx/Components/blog_screen_initial_screen/blog_screen_header_text.dart';
import 'package:tumblrx/Components/avatar_shape/avatar_image.dart';

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
    ///function used for Tab bars
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(

          /// couloum have(the header image , avatar,title, description and tab bars )
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(alignment: Alignment.center, children: <Widget>[
              Column(
                children: [
                  HeaderImage(),

                  ///display header image with icons and drop down list
                  TextWriting(),
                ],
              ),
              //Square(),   ///show an avatar in square
              Avatar(),

              /// show avatar in circle
              AvatarImage()
            ]),
            Container(

                /// start of Tab Bars
                color: Constant.bottomCoverColor,
                child: TabBar(
                  unselectedLabelColor: Color(0xffc7c1c1),
                  labelColor: Constant.accent,

                  ///color of label of selected item we can change it from edit
                  indicatorColor: Constant.accent,

                  ///color of indicator of selected item releted to label
                  tabs: [
                    Tooltip(
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
              color: Constant.bottomCoverColor,
              child: TabBarView(
                children: [Text('Posts'), Text('Likes'), Text('Following')],
                controller: _tabController,
              ),
            ))
          ]),
    ));
  }
}
