import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';
import 'package:tumblrx/components/following/following_card.dart';
import 'package:tumblrx/components/post/post_widget.dart';
import 'package:tumblrx/models/post.dart';
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
  Future<Post> blogPost;
  return Expanded(

      /// pages which display content of each tab bar
      child: Container(
    color: hexToColor(Provider.of<User>(context, listen: false)
            .getActiveBlogBackColor()) ??
        Colors.blue,
    child: TabBarView(
      children: [
        FutureBuilder<List<Post>>(
          future: Provider.of<User>(context).getActiveBlogPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
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
                    const Divider(height: 20.0, color: Colors.transparent),
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
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data.length != 0) {
                return  Column(children: <Widget>[  Container(color: Colors.white,child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Everyone can see this page')),
                        TextButton(
                          onPressed: () {},
                          child: Text('change',
                              style:
                                  TextStyle(color: BlogScreenConstant.accent )),
                        )
                      ],
                    ),),Expanded(child:  ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Post post = snapshot.data[index];
                    return PostWidget(
                      postContent: post.content,
                      tags: post.tags,
                      index: 0,
                      post: snapshot.data[index],
                      isLikes: true,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 20.0, color: Colors.transparent),
                ))]);
              } else if (snapshot.hasError) {
                Center(
                  child: Text('Turbulent connection.Try again'),
                );
              } 
             
                return CircularProgressIndicator();
              
            }),
            //followings
           

           
        
         FollowingCard()
      ],
      controller: _tabController,
    ),
  ));
}
