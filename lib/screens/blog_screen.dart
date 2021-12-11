import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/Components/blog_screen_constant.dart';
import 'package:tumblrx/Components/blog_screen_initial_screen/header_image.dart';
import 'package:tumblrx/Components/blog_screen_initial_screen/blog_screen_header_text.dart';
import 'package:tumblrx/Components/avatar_shape/avatar_image.dart';
import 'package:tumblrx/components/avatar_shape/square.dart';
import 'package:tumblrx/components/following/following_card.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'dart:convert' as convert;

///This a initial screen you see when press on profile from navigation bar
class BlogScreen extends StatefulWidget {
  static final String id = 'blog_screen';
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future<Blog> blog;
  @override
  void initState() {
  
    ///this controller for Tabs bar
    ///function used for Tab bars
    blog = Blog.getInfo("citriccomics");
    _tabController = new TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
    
    return Scaffold(
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height + (12 - 3) * 60),

                /// i will chnge it and make it equal total no of following-3*40

                child: Container(
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
