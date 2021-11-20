import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/screens/main_screen.dart';
//import 'package:tumblrx/screens/signup_pick_tags.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';

class SignUpUserData extends StatelessWidget {
  static final String id = 'SignUpUserData';
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff001935),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                // the next button on the upper right of the screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formkey.currentState.validate())
                            return null;
                          else {
                            while (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            Navigator.pushNamed(context, MainScreen.id);
                          }
                        },
                        child: Text(
                          'Next',
                          style: KTextButton,
                        ),
                        style:
                            ElevatedButton.styleFrom(onSurface: Colors.black),
                      ),
                    ),
                  ],
                ),
                //     the title
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    'What should we call you?',
                    style: KHeadLines1,
                    textAlign: TextAlign.center,
                  ),
                ),
                //     some info
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 20, 10),
                  child: Text(
                    'You will need a name to make your own posts, customize your blog, and message people.',
                    style: KTextInfo,
                    textAlign: TextAlign.center,
                  ),
                ),
                // first textfield to enter the email
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    validator: (email) {
                      return Provider.of<Authentication>(context, listen: false)
                          .checkValidEmail(email);
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'email',
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
                //second textfield to enter the password
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    obscureText:
                        Provider.of<Authentication>(context).isObscurecontent,
                    validator: (password) {
                      return Provider.of<Authentication>(context, listen: false)
                          .checkValidPassword(password);
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          Provider.of<Authentication>(context, listen: false)
                              .toggleisObscure();
                        },
                        icon: Icon(
                          Provider.of<Authentication>(context).isObscurecontent
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
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
                //the third textfield to enter the name
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    validator: (name) {
                      return Provider.of<Authentication>(context, listen: false)
                          .checkValidName(name);
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'name',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
