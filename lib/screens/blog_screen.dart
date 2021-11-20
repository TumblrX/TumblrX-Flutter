import 'package:flutter/material.dart';
import 'package:tumblrx/components/constant.dart';
import 'package:tumblrx/components/avatar.dart';
import 'package:tumblrx/components/header_image.dart';
import 'package:tumblrx/components/blog_screen_header_text.dart';
import 'package:tumblrx/components/avatar_image.dart';

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
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(alignment: Alignment.center, children: <Widget>[
              Column(
                children: [
                  HeaderImage(),
                  TextWriting(),
                ],
              ),
              //Square(),
              Avatar(),
              AvatarImage()
            ]),
            Container(
                color: Constant.bottomCoverColor,
                child: TabBar(
                  unselectedLabelColor: Color(0xffc7c1c1),
                  labelColor: Constant.accent,
                  indicatorColor: Constant.accent,
                  tabs: [
                    Tab(text: 'Posts'),
                    Tab(
                      text: 'Likes',
                    ),
                    Tab(
                      text: 'Followings',
                    )
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                )),
            Expanded(
                child: Container(
              color: Constant.bottomCoverColor,
              child: TabBarView(
                children: [Text('Posts'), Text('Likes'), Text('Followings')],
                controller: _tabController,
              ),
            ))
          ]),
    ));
  }
}
