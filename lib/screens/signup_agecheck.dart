import 'package:flutter/material.dart';
import 'package:tumblrx/screens/signup_pick_tags.dart';
import 'package:tumblrx/utilities/constants.dart';

class SignUpAgeCheck extends StatefulWidget {
  static final String id = 'SignUpAgeCheck';

  @override
  _SignUpAgeCheckState createState() => _SignUpAgeCheckState();
}

class _SignUpAgeCheckState extends State<SignUpAgeCheck> {
  bool rightAge = false;
  int userAge;

  void checkagevalidation(int age) {
    setState(() {
      if (age > 20)
        rightAge = true;
      else
        rightAge = false;
    });
  }

  void func() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: rightAge
                      ? () {
                          Navigator.pushNamed(context, SignUpPickTags.id);
                        }
                      : null,
                  child: Text(
                    'Next',
                    style: KTextButton,
                  ),
                  style: ElevatedButton.styleFrom(onSurface: Colors.black),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 80, 30, 0),
            child: TextFormField(
              onChanged: (age) {
                userAge = int.parse(age);
                checkagevalidation(userAge);
                // print(userAge);
                //print(rightAge);
              },
              decoration: KTextFieldDecoration,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Text(
              'you\'are almost done. Enter your age ,then tap the Next button to idicate that you agree to the terms of service and read the privacy policy.',
              style: KHeadLines,
            ),
          ),
        ],
      ),
    );
  }
}
// rightAge ? () => func() : null
// TextButton(
//                   child: Text(
//                     'Next',
//                     //style: KTextButton,
//                   ),
//                   onPressed: null,
//                   style: TextButton.styleFrom(
//                     primary: Colors.red,
//                     backgroundColor: Colors.indigo[900],
//                   ),
//                 ),