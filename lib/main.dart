import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/screens/welcome_screen.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/services/messaging.dart';
import 'package:tumblrx/services/notifications.dart';
import 'package:tumblrx/services/post.dart';
import 'package:tumblrx/services/settings.dart';
import 'package:tumblrx/services/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Authentication>(
          create: (context) => Authentication(),
        ),
        ChangeNotifierProvider<Post>(
          create: (context) => Post(),
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
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
        },
      ),
    );
  }
}
