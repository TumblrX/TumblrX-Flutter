import 'package:flutter/material.dart';
import 'package:tumblrx/components/welcome_screen_image.dart';
import 'package:tumblrx/utilities/constants.dart';

class LoginScreen extends StatelessWidget {
  static final String id = 'welcome_screen_login';
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
                  '           Log in with Email           ',
                  style: KWelcomeScreenButton,
                ),
                onPressed: () {},
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
                  '           Log in with Google               ',
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
