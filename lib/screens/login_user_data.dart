import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/main_screen.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';

class LogInUserData extends StatelessWidget {
  static final String id = 'LogInUserData';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //     the title
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 70, 10),
                      child: Text(
                        't',
                        style: KWelcomeScreenTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // the next button on the upper right of the screen
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!_formkey.currentState.validate() ||
                              !await Provider.of<Authentication>(context,
                                      listen: false)
                                  .loginRequest())
                            return null;
                          else {
                            final Map<String, dynamic> response =
                                await Provider.of<Authentication>(context,
                                        listen: false)
                                    .loginGetUserInfo(context);
                            Provider.of<User>(context, listen: false)
                                .setLoginUserData(response);
                            while (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            Navigator.pushNamed(context, MainScreen.id);
                          }
                        },
                        child: Text(
                          'Login',
                          style: KTextButton,
                        ),
                        style:
                            ElevatedButton.styleFrom(onSurface: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
