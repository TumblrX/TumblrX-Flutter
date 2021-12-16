import 'package:flutter/material.dart';
import 'package:tumblrx/screens/blog_screen.dart';

class EditAppBar {
  bool isswitched = true;
  Widget defaultAppBar(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: 80,
        padding: EdgeInsets.only(top: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => BlogScreen()),
                  );
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white),
            Text('Edit appearance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ))
          ],
        ));
  }

  Widget editTitleAppBar() {
    return Container(
      color: Colors.white,
      height: 80,
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              )),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check,
                    size: 35,
                  ),
                  color: Color(0xff33de04))),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'Title',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            width: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: TextButton(
                onPressed: () {},
                child: Text('Font', style: TextStyle(fontSize: 18))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: TextButton(
                onPressed: () {},
                child: Text('Color', style: TextStyle(fontSize: 18))),
          )
        ],
      ),
    );
  }

  Widget editHeaderImage() {
    return Container(
      color: Colors.white,
      height: 80,
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              )),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check,
                    size: 35,
                  ),
                  color: Color(0xff33de04))),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'Background color',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget editDescriptionAppBar() {
    return Container(
      color: Colors.white,
      height: 80,
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              )),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check,
                    size: 35,
                  ),
                  color: Color(0xff33de04))),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'Description',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(width: 140),
          Switch(value: isswitched, onChanged: (value) {})
        ],
      ),
    );
  }
}
