import 'package:flutter/material.dart';
import 'package:tumblrx/components/bottom_nav_bar/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  static final String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
