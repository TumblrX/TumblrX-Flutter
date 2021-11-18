import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/screens/Profile_Screen.dart';
import 'package:tumblrx/screens/notifications_screen.dart';
import 'package:tumblrx/screens/search_screen.dart';
import 'package:tumblrx/screens/signup_agecheck.dart';
import 'package:tumblrx/screens/welcome_screen.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/services/messaging.dart';
import 'package:tumblrx/services/notifications.dart';
import 'package:tumblrx/services/settings.dart';
import 'package:tumblrx/services/theme.dart';
import 'package:tumblrx/screens/welcome_screen_login.dart';
import 'package:tumblrx/screens/welcome_screen_signup.dart';
import 'package:tumblrx/screens/signup_pick_tags.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(
          create: (context) => User(),
        ),
        ChangeNotifierProvider<Authentication>(
          create: (context) => Authentication(),
        ),
        ChangeNotifierProvider<Content>(
          create: (context) => Content(),
        ),
        ChangeNotifierProvider<Messaging>(
          create: (context) => Messaging(),
        ),
        ChangeNotifierProvider<Notifications>(
          create: (context) => Notifications(),
        ),
        ChangeNotifierProvider<Settings>(
          create: (context) => Settings(),
        ),
        ChangeNotifierProvider<Themes>(
          create: (context) => Themes(),
        ),
      ],
      child: MaterialApp(
          onUnknownRoute: (RouteSettings settings) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => PageNotFound());
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blueGrey, accentColor: Colors.blueAccent),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          BottomNavBarScreen.id: (context) => BottomNavBarScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          SignUpAgeCheck.id: (context) => SignUpAgeCheck(),
          SignUpPickTags.id: (context) => SignUpPickTags(),
        },
      ),
    );
  }
}
