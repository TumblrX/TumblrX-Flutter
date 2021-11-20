import 'package:flutter/material.dart';
import 'package:tumblrx/utilities/constants.dart';

class SignUpPickTags extends StatefulWidget {
  static final String id = 'SignUp_PickTags';
  @override
  _SignUpPickTagsState createState() => _SignUpPickTagsState();
}

class _SignUpPickTagsState extends State<SignUpPickTags> {
  int tagsToPickCount = 5;
  String elvatedbuttontext = 'pick';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: null,
                    /* todo:
                     while(Navigator.canPop()){Navigator.pop()}
                     Navigator.pushNamed('main_screen)*/
                    child: Text(
                      '$elvatedbuttontext$tagsToPickCount',
                      style: KTextButton,
                    ),
                    style: ElevatedButton.styleFrom(onSurface: Colors.black),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
              child: Text(
                'What do you like?',
                style: KHeadLines1,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                '-what ever you into. you will find it here, Follow some the tags bellow.',
                style: KPickTagsInfoText,
              ),
            ),
            Expanded(
              child: Container(
                //color: Colors.indigo[900],
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//rightAge
                   //   ? () {
                     //     Navigator.pushNamed(context, SignUpPickTags.id);
                      //  }
                      //: null,