import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/main_screen.dart';
import 'package:tumblrx/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'package:tumblrx/global.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'dart:convert' as convert;

import 'messaging.dart';

///Contains the user data for login and sign up
///
///And check for valid user data
class Authentication extends ChangeNotifier {
  int userAge = 0;
  String userName;
  String userEmail;
  String userPassword;
  bool isObscureSignUp = true; //for the signup to hide the password
  String token; //for user authorization
  bool emailExist = false;
  String loginErrorMessage = "";

  SharedPreferences _prefs;

  // Future<String> getToken(BuildContext context) async {
  //   if (_token != null) return _token;
  //   //token is null, check for shared preferences
  //   if (_prefs == null || _prefs.getString('token') == null) {
  //     //user is logged out, go to login screen
  //     while (Navigator.canPop(context)) {
  //       Navigator.pop(context);
  //     }
  //     Navigator.popAndPushNamed(context, WelcomeScreen.id);
  //     return null;
  //   }
  //   //Here means that the user is logged in but provider is cleared, restore provider data
  //   _token = _prefs.getString('token');
  //
  //   final Map<String, dynamic> response = await loginGetUserInfo();
  //   Provider.of<User>(context, listen: false)
  //       .setLoginUserData(response, context);
  //   Provider.of<Messaging>(context, listen: false)
  //       .connectToServer(response['id'], _token);
  //   Provider.of<Messaging>(context, listen: false).getConversationsList();
  //   return _token;
  // }

  ///returns error message if the user doesnot exist
  String getLogInErrorMessage() {
    return loginErrorMessage;
  }

  ///Changes the visibility state of the password textfield
  void toggleisObscure() {
    isObscureSignUp = !isObscureSignUp;
    notifyListeners();
  }

  ///Returns the visibility state of the password textfield
  bool get isObscurecontent => isObscureSignUp;

  ///indicates if the user exist or not
  bool get doesEmailExist => emailExist;

  /// Checks if the email is in valid form for signup
  ///
  /// Returns an error message if the email is invalid
  /// And sets the user email if it is valid
  String checkValidEmail(String email) {
    if (email == null || email.isEmpty) {
      return 'Please enter some text';
      // } else if (!emailExist) {
      //   return 'email doesnot exist';
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

  ///sends a post request to the API
  ///
  ///checks if the user exist
  ///And sets the user token
  Future<bool> loginRequest() async {
    Map<String, dynamic> loginRequestBody = {
      "email": userEmail,
      "password": userPassword
    };

    try {
      final response = await http.post(
          Uri.parse('${ApiHttpRepository.api}api/user/login'),
          body: convert.jsonEncode(loginRequestBody),
          headers: {'content-type': 'application/json'});

      //if i get a bad response then this user doesnot exist
      if (response.statusCode == 400) {
        logger.d("400");
        loginErrorMessage = "wrong Email or password please try again";
        notifyListeners();
        return false;
      } else if (response.statusCode != 200) {
        logger.e('!200');
        logger.d(response.body);
        throw Exception('error in the connection');
      } else {
        var responseObject = convert.jsonDecode(response.body);
        print(responseObject);
        token = responseObject['token'];
        emailExist = true;
        _prefs.setString('token', token);
        notifyListeners();

        return true;
      }
    } on SocketException catch (error) {
      logger.e(error);
      throw error;
    } catch (err) {
      logger.e(err);
      return false;
    }
  }

  ///sends a get request to the API
  ///
  ///gets the user info that the user is authorized to access
  Future<Map<String, dynamic>> loginGetUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse(ApiHttpRepository.api + 'api/user/info'),
        // Send authorization headers to the backend.
        headers: {HttpHeaders.authorizationHeader: '$token'},
      );

      if (response.statusCode != 200)
        throw Exception('user is not authorized');
      else {
        Map<String, dynamic> responseObject =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        logger.d(response.statusCode);
        //logger.d(responseObject);
        try {
          // following blogs

          final blogsResponse = await http.get(
            Uri.parse(ApiHttpRepository.api + 'api/user/get-blogs'),
            // Send authorization headers to the backend.
            headers: {HttpHeaders.authorizationHeader: '$token'},
          );
          if (blogsResponse.statusCode != 200)
            throw Exception('error in getting blogs');

          responseObject['blogs'] = convert.jsonDecode(blogsResponse.body);
        } catch (error) {
          throw Exception(error.message.toString());
        }

        logger.d(responseObject);
        return responseObject;
      }
    } catch (error) {
      throw Exception(error.message.toString());
    }
  }

  ///Sets the user age
  void setUserAge(String age) {
    // logger.d(age);
    int temp = int.parse(age);
    userAge = temp;
    notifyListeners();
  }

  ///check if user is authenticated
  Future<void> checkUserAuthentication(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    //await Future.delayed(Duration(seconds: 3));
    if (_prefs.getString('token') == null) return;
    token = _prefs.getString('token');

    await initializeUserData(context);
  }

  ///initialize user Data on login
  Future<void> initializeUserData(BuildContext context) async {
    final Map<String, dynamic> response = await loginGetUserInfo();
    Provider.of<User>(context, listen: false)
        .setLoginUserData(response, context);
    Provider.of<Messaging>(context, listen: false)
        .connectToServer(response['id'], token);
    Provider.of<Messaging>(context, listen: false).getConversationsList();
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.popAndPushNamed(context, MainScreen.id);
  }

  ///Clears data from shared preferences and disconnects from socket server
  Future<void> logout(BuildContext context) async {
    Provider.of<Messaging>(context, listen: false).disconnect();
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.popAndPushNamed(context, WelcomeScreen.id);
  }
}
