import 'package:flutter/material.dart';

class FollowingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 60,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(
          'Following',
          style: TextStyle(fontSize: 20),
        ));
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 12.0,
      ),
    );
  }
}
