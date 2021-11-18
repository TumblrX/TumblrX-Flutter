import 'package:flutter/material.dart';

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
    );
  }
}
