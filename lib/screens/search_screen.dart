import 'package:flutter/material.dart';
import 'package:tumblrx/components/bottom_nav_bar/bottom_nav_bar.dart';

class SearchScreen extends StatelessWidget {
  static final String id = 'search_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Search Screen',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
