import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static final String id = 'notification_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Notification Screen',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
