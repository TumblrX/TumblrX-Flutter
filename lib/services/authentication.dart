import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tumblrx/services/api_provider.dart';
import 'dart:convert' as convert;

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
    final String endPoint = 'user/login';

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
        print("400");
        loginErrorMessage = "wrong Email or password please try again";
        notifyListeners();
        return false;
      } else if (response.statusCode != 200) {
        print('!200');
        print(response.body);
        throw Exception('error in the connection');
      } else {
        var responseObject = convert.jsonDecode(response.body);
        token = responseObject['token'];
        emailExist = true;
        notifyListeners();
        // print(response.statusCode);
        // print(token);
        // print(emailExist);
        // return User.fromJson(resposeObject);
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  ///sends a get request to the API
  ///
  ///gets the user info that the user is authorized to access
  Future<Map<String, dynamic>> loginGetUserInfo() async {
    final String endPoint = 'user/info';

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
        print(response.statusCode);
        //print(responseObject);
        try {
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
        print(responseObject);
        return responseObject;
      }
    } catch (error) {
      throw Exception(error.message.toString());
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
