import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/Components/blog_screen_constant.dart';

class Search extends StatefulWidget {  ///search of avatar
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 9,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/header.png"),
                          fit: BoxFit.fill)),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Container(
              color: BlogScreenConstant.bottomCoverColor,
              child: TabBar(
                unselectedLabelColor: Color(0xffc7c1c1),
                labelColor:BlogScreenConstant.accent,
                indicatorColor: BlogScreenConstant.accent,
                tabs: [
                  Tab(
                    text: 'Posts',
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
            child: TabBarView(
              children: [Text('Posts a lot about'), Text('Followings')],
              controller: _tabController,
            ),
          ))
        ],
      ),
    );
  }
}
