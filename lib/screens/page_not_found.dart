import 'package:flutter/material.dart';

/// Dummy screen to render when things go wrong
class PageNotFound extends StatelessWidget {
  final String id = 'not_found';
  final String message;
  PageNotFound(this.message);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'from page not found $message',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
