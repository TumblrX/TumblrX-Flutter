import 'package:flutter/material.dart';

/// Dummy screen to render when things go wrong
class PageNotFound extends StatelessWidget {
  final String id = 'not_found';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'Page Not Found',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
