import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/blog_screen.dart';
import 'package:tumblrx/screens/main_screen.dart';
import 'package:tumblrx/screens/page_not_found.dart';
import 'package:tumblrx/screens/signup_agecheck.dart';
import 'package:tumblrx/screens/welcome_screen.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/services/content.dart';
import 'package:tumblrx/services/messaging.dart';
import 'package:tumblrx/services/notifications.dart';
import 'package:tumblrx/services/creating_post.dart';
import 'package:tumblrx/services/settings.dart';
import 'package:tumblrx/services/theme.dart';
import 'package:tumblrx/screens/welcome_screen_login.dart';
import 'package:tumblrx/screens/welcome_screen_signup.dart';
import 'package:tumblrx/screens/signup_pick_tags.dart';
import 'package:tumblrx/screens/signup_user_data.dart';
import 'package:tumblrx/screens/login_user_data.dart';
import 'package:tumblrx/utilities/environment.dart';

import 'components/my_custom_scroll_behavior.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
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
        ChangeNotifierProvider<CreatingPost>(
          create: (context) => CreatingPost(),
        ),

        // ChangeNotifierProxyProvider<Authentication, User>(
        //   create: (_) => User(Provider.of<Authentication>(context, listen: false)),
        //   update: (_, authentication, user) =>
        //       user..name = authentication.userName,

        // ),

        ChangeNotifierProvider<User>(
          create: (context) => User(),
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
        ChangeNotifierProvider<BlogScreenConstantProvider>(
          create: (context) => BlogScreenConstantProvider(),
        ),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        onUnknownRoute: (RouteSettings settings) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => PageNotFound());
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 0, 39, 1),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          BlogScreen.id: (context) => BlogScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          MainScreen.id: (context) => MainScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          SignUpAgeCheck.id: (context) => SignUpAgeCheck(),
          SignUpPickTags.id: (context) => SignUpPickTags(),
          SignUpUserData.id: (context) => SignUpUserData(),
          LogInUserData.id: (context) => LogInUserData(),
        },
      ),
    );
  }
}

// ChangeNotifierProvider<User>(
//           create: (context) => User(),

//         ),
