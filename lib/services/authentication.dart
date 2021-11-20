import 'package:flutter/material.dart';

///Contains the user data for login and sign up
///
///And check for valid user data
class Authentication extends ChangeNotifier {
  int userAge = 0;
  String userName;
  String userEmail;
  String userPassword;
  bool isObscure = true; //for the signup to hide the password

  ///Changes the visibility state of the password textfield
  void toggleisObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  ///Returns the visibility state of the password textfield
  bool get isObscurecontent => isObscure;

  /* TODO:
 should also check if this email already exists from the mockservice
 */
  /// Checks if the email is in valid form for signup
  ///
  /// Returns an error message if the email is invalid
  /// And sets the user email if it is valid
  String checkValidEmail(String email) {
    if (email == null || email.isEmpty) {
      return 'Please enter some text';
    } else if (email.contains('@') && email.contains('.com')) {
      userEmail = email;
      notifyListeners();
      return null;
    } else
      return 'unvalid email';
  }

  ///Checks that the user has entered a name
  ///
  ///Returns an error message if the user didn't enter any name
  ///And sets the user name if it is valid
  String checkValidName(String name) {
    if (name == null || name.isEmpty) {
      return 'Please enter some text';
    } else {
      userName = name;
      notifyListeners();
      return null;
    }
  }

  ///Checks that the user has entered a password
  ///
  ///Returns an error message if the user didn't enter any password
  ///And sets the user password if it is valid
  String checkValidPassword(String password) {
    if (password == null || password.isEmpty) {
      return 'Please enter some text';
    } else {
      userPassword = password;
      notifyListeners();
      return null;
    }
  }

  ///Sets the user age
  void setUserAge(String age) {
    // print(age);
    int temp = int.parse(age);
    userAge = temp;
    notifyListeners();
  }
}
