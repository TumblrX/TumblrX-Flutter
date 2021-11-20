import 'package:flutter/material.dart';
import 'package:tumblrx/screens/signup_user_data.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/authentication.dart';

class SignUpAgeCheck extends StatefulWidget {
  static final String id = 'SignUpAgeCheck';

  @override
  _SignUpAgeCheckState createState() => _SignUpAgeCheckState();
}

class _SignUpAgeCheckState extends State<SignUpAgeCheck> {
  bool rightAge = false;
  int userAge;

  ///Checks if the user age is suitable
  ///
  ///changes [rightAge] value to true is the userage is above 15
  void checkUserAge(String age) {
    setState(() {
      userAge = int.parse(age);
      if (userAge > 15)
        rightAge = true;
      else
        rightAge = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff001935),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: rightAge
                        ? () {
                            Navigator.pushNamed(context, SignUpUserData.id);
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
                  Provider.of<Authentication>(context, listen: false)
                      .setUserAge(age);
                  checkUserAge(age);
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'How old are you?',
                  labelStyle: KHintTextForTextField,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}
// rightAge
//                         ? () {
//                             Navigator.pushNamed(context, SignUpUserData.id);
//                           }
//                         : null,