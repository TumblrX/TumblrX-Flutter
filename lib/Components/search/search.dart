import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
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
              child:  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back),color: Colors.white,)),
              
              
              ],
            ),
          )
        ],
      ),
    );
  }
}
