import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/blog_screen.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

class Search extends StatefulWidget {
  ///search of avatar
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
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);

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
                          image: NetworkImage(ApiHttpRepository.api +
                                  Provider.of<User>(context, listen: false)
                                      .getActiveBlogHeaderImage() ??
                              'http://tumblrx.me:3000/uploads/blog/blog-1640803111113-undefined.png'),
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
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => BlogScreen()),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 50, top: 20, right: 20),
                  child: TextField(
                      style: TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.search,
                      showCursor: false,
                      decoration: new InputDecoration(
                        hintStyle:
                            TextStyle(color: Color(0xffffc7c1c1), fontSize: 18),
                        hintText: ('Search ' + BlogScreenConstant.userName),
                        border: InputBorder.none,
                      )),
                )
              ],
            ),
          ),
          Container(
              color: hexToColor(Provider.of<User>(context, listen: false)
                      .getActiveBlogBackColor()) ??
                  Colors.blue,
              child: TabBar(
                unselectedLabelColor: Color(0xffc7c1c1),
                labelColor: blogProvider.geaccentColor(),
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
