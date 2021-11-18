import 'package:flutter/material.dart';
import 'package:tumblrx/components/welcome_screen_image.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:tumblrx/screens/signup_agecheck.dart';

class SignupScreen extends StatelessWidget {
  static final String id = 'welcome_screen_signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          WelcomeScreenImage(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'tumblrx',
                style: KWelcomeScreenTitle,
              ),
              SizedBox(
                height: 100,
              ),
              TextButton(
                child: Text(
                  '          Sign up with Email           ',
                  style: KWelcomeScreenButton,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, SignUpAgeCheck.id);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                child: Text(
                  '           Sign up with Google               ',
                  style: KWelcomeScreenButton,
                ),
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
