/*
Description:this file for tabs bar in Blog 
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/following/following_card.dart';
import 'package:tumblrx/components/post/post_widget.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';
import '../blog_screen_constant.dart';

///Upper tab bar
Widget upperTabBar(
    TabController _tabConroller, BuildContext context, String color) {
  final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
  return Container(

      /// start of Tab Bars

      color: hexToColor(color ?? '#000000') ?? Colors.blue,
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
        controller: _tabConroller,
        indicatorSize: TabBarIndicatorSize.tab,
      ));
}

///body of tabs
Widget bottomTabBar(TabController _tabController, BuildContext context,
    String color, Blog blog) {
  //final blogProvider = Provider.of<BlogScreenConstantProvider>(context);

  return Expanded(

      /// pages which display content of each tab bar
      child: Container(
    color: hexToColor(color ?? '#000000') ?? Colors.blue,
    child: TabBarView(
      children: [
        ///posts
        FutureBuilder<List<Post>>(
          future: blog.blogPosts(context, true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              logger.d(snapshot.data);
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = snapshot.data[index];
                  return Column(
                    children: <Widget>[
                      PostWidget(
                        post: post,
                        // isLikes: false,
                      ),
                      Container(
                        height: 20.0,
                        color: hexToColor(color ?? '#000000') ?? Colors.blue,
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              Text('error');
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
        //Likes
        FutureBuilder<List<Post>>(
            future: Provider.of<User>(context).getUserLikes(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Everyone can see this page')),
                        TextButton(
                          onPressed: () {},
                          child: Text('change',
                              style:
                                  TextStyle(color: BlogScreenConstant.accent)),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post post = snapshot.data[index];
                      return PostWidget(
                        post: post,
                        // isLikes: true,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 20.0, color: Colors.transparent),
                  ))
                ]);
              } else if (snapshot.hasError) {
                Center(
                  child: Text('Turbulent connection.Try again'),
                );
              }

              return Center(child: CircularProgressIndicator());
            }),
        //following
        FutureBuilder<List<Blog>>(
          future: Provider.of<User>(context).getUserBlogFollowing(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Container(
                    color: Color(0xffe6e0df),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text('Everyone can see this page')),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('change',
                                      style: TextStyle(
                                          color: BlogScreenConstant.accent)),
                                )
                              ],
                            ),
                            Text(Provider.of<User>(context)
                                    .getUserFollowing()
                                    .toString() +
                                ' Tumblrs'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return FollowingCard(blog: snapshot.data[index]);
                    },
                  ))
                ],
              );
            } else if (snapshot.hasData) {
              Center(
                child: Text('Turbulent connection.Try again'),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),

        // FollowingCard()
      ],
      controller: _tabController,
    ),
  ));
}
