import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/screens/welcome_screen.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/services/messaging.dart';
import 'package:tumblrx/services/notifications.dart';
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
        Provider<Authentication>(
          create: (context) => Authentication(),
        ),
        Provider<Content>(
          create: (context) => Content(),
        ),
        Provider<Messaging>(
          create: (context) => Messaging(),
        ),
        Provider<Notifications>(
          create: (context) => Notifications(),
        ),
        Provider<Settings>(
          create: (context) => Settings(),
        ),
        Provider<Themes>(
          create: (context) => Themes(),
        ),
      ],
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
        },
      ),
    );
  }
}
