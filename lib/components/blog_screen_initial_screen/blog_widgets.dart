import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/following/following_card.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

import '../blog_screen_constant.dart';

Widget upperTabBar(TabController _tabController, BuildContext context) {
  final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
  return Container(

      /// start of Tab Bars
      color: hexToColor(Provider.of<User>(context, listen: false)
              .getActiveBlogBackColor()) ??
          Colors.blue,
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
      ));
}

Widget bottomTabBar(TabController _tabController, BuildContext context) {
  //final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
  return Expanded(

      /// pages which display content of each tab bar
      child: Container(
    color: hexToColor(Provider.of<User>(context, listen: false)
            .getActiveBlogBackColor()) ??
        Colors.blue,
    child: TabBarView(
      children: [Text('Posts'), Text('Likes'), FollowingCard()],
      controller: _tabController,
    ),
  ));
}
