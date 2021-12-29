import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/blog_screen.dart';
import 'package:tumblrx/screens/main_screen.dart';
import 'package:tumblrx/screens/page_not_found.dart';
import 'package:tumblrx/screens/post_screen.dart';
import 'package:tumblrx/screens/search_screen.dart';
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

//bool _initialUriIsHandled = false;
Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//  Uri _initialUri;
//  Uri _latestUri;
  String postId = "";
  StreamSubscription _linkSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // load data from shared preferences
    //_handleIncomingLinks();
    //_handleInitialUri();
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    if (isBackground) {
      // store app current screen data in shared preferences
    } else {
      // app is back
    }
  }

  // void _handleIncomingLinks() {
  //   if (!kIsWeb) {
  //     _linkSubscription = uriLinkStream.listen((event) {
  //       if (!mounted) return;
  //       print('got uri $event');
  //       setState(() {
  //         _latestUri = event;
  //       });
  //     }, onError: (err) {
  //       if (!mounted) return;
  //       print('got error $err');
  //     });
  //   }
  // }

//   void _handleInitialUri() async {
//     if (!_initialUriIsHandled) {
//       _initialUriIsHandled = true;
//       try {
//         final uri = await getInitialUri();
//         if (uri == null) {
// //          print('no initial uri');
//           return;
//         } else
//         //         print('got initial uri: $uri');
//         // if the state is not yet in the tree, return
//         if (!mounted) return;
//         setState(() {
//           _initialUri = uri;
//         });
//       } on PlatformException {
//         //      print('failed to get initial uri');
//       } on FormatException catch (_) {
//         if (!mounted) return;
//         //    print('malformed initial uri');
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Authentication>(
          create: (context) => Authentication(),
        ),
        // ChangeNotifierProvider<Post>(
        //   create: (context) => Post(),
        // ),
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
          return PageRouteBuilder(
              pageBuilder: (_, __, ___) => PageNotFound("Page Not Found"));
        },
        onGenerateRoute: (RouteSettings settings) {
          logger.d(settings.name);
          if (settings.name.contains('posts/')) {
            final String postId = settings.name.split('/').last;
            return PageRouteBuilder(
                settings: RouteSettings(name: settings.name),
                pageBuilder: (context, anumation, secondaryAnimation) =>
                    PostScreen(
                      postId: postId,
                    ));
          } else {
            logger.e(settings.name);
            return null;
          }
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
          SearchScreen.id: (context) => SearchScreen(),
        },
      ),
    );
  }
}

// ChangeNotifierProvider<User>(
//           create: (context) => User(),

//         ),
