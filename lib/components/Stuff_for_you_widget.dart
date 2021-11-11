import 'package:flutter/material.dart';

class StuffForYouWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 16,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(
          'Stuff for You',
          style: TextStyle(fontSize: 20),
        ));
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 12.0,
      ),
    );
  }
}
