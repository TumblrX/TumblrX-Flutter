/*
Author:Esraa Gamal
Description:All App Bar in Editing page 
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/edit_blog_screen/alert_dialgue.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/blog_screen.dart';
///this class for App bars in editing
class EditAppBar {
  bool isswitched = true;
  ///default app bar
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
                  ///show dialgue when return to blog screen
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) => AlerDialgue(),
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
                onPressed: () {
                  Provider.of<User>(context, listen: false)
                      .updateActiveBlogInfo(context);
                  Provider.of<User>(context, listen: false).updateBlog(context);

                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => BlogScreen()),
                  );
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ))
          ],
        ));
  }
///App bar for Editing title
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
                onPressed: null,
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
  ///App bar in Editing header image
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
///App bar when editing Description
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
