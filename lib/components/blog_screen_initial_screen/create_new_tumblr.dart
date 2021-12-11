import 'package:flutter/material.dart';

class CreateNewTumblrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xff0c1b3b),
      appBar: AppBar(
          backgroundColor: Color(0xff0c1b3b),
          title: Text('Create a new Tumblr'),
          actions: [TextButton(onPressed: () {}, child: Text('Save'))],
          elevation: 0.0),
      body: Center(
        child: Row(
          children: <Widget>[
          

           
          ],
          //add text field
        ),
      ),
    );
  }
}
