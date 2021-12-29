import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/welcome_screen_image.dart';
import 'package:tumblrx/screens/main_screen.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:tumblrx/screens/welcome_screen_login.dart';
import 'package:tumblrx/screens/welcome_screen_signup.dart';

class WelcomeScreen extends StatelessWidget {
  static final String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Authentication>(context, listen: false)
          .checkUserAuthentication(context),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.done) {
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(95, 0, 95, 0),
                        child: Text(
                          'Sign up',
                          style: KWelcomeScreenButton,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.of(context).pushNamed('main_screen');
                        Navigator.pushNamed(context, SignupScreen.id);
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                        child: Text(
                          'Log in',
                          style: KWelcomeScreenButton,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
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
        } else {
          return Scaffold(body: WelcomeScreenImage());
        }
      },
    );
  }
}
//WelcomeScreenImage()
