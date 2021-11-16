import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';
import 'package:tumblrx/Components/avatar.dart';
import 'package:tumblrx/Components/constant.dart';
import 'package:tumblrx/Components/headerImage.dart';
import 'package:tumblrx/Components/text.dart';
import 'package:tumblrx/Components/toggleButtons.dart';
import 'package:tumblrx/Components/avatarImage.dart';
import 'package:tumblrx/Components/edit/editBottons.dart';

class TabBars extends StatefulWidget  {
  @override
  _TabBarsState createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars>   with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body:Container(
        child: 
          Column(  
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
           Stack(
              alignment: Alignment.center,
               children: <Widget>[
           Column(
            
                children: [
                
                HeaderImage(),
                  TextWriting(),
              

            ],
              ),
             Avatar(),
              AvatarImage()
           ]),
           Container(color: Constant.bottomCoverColor,child: TabBar(
              
             unselectedLabelColor: Color(0xffc7c1c1),
              labelColor: Constant.accent,
              indicatorColor:Constant.accent,
              tabs: [
                Tab(
                  text: 'Posts'
                ),
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
                
                
              child:Container (color:  Constant.bottomCoverColor,child: TabBarView(
                children: [Text('Posts'), Text('Likes'),Text('Followings')],
                controller: _tabController,
              ),
              
              ))

          ]),
          

          
          
          


          






        




        






      )
    
    
    );
  }
}
