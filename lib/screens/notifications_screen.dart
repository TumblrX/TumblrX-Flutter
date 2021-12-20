import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/components/chatting/messaging_screen.dart';
import 'package:tumblrx/components/createpost/create_post_user.dart';
import 'package:tumblrx/screens/main_screen.dart';
import 'package:tumblrx/utilities/constants.dart';

///Notifications Screen that contains Activity and Messaging
class NotificationsScreen extends StatelessWidget {
  static final String id = 'notification_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          constraints: !kIsWeb
              ? BoxConstraints()
              : BoxConstraints(
                  maxWidth: 750.0,
                  minWidth: MediaQuery.of(context).size.width < 750
                      ? MediaQuery.of(context).size.width * 0.9
                      : 750.0,
                ),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              actionsIconTheme: IconThemeData(color: Colors.black),
              title: CreatePostUser(),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Refresh'),
                      value: 'Refresh',
                    ),
                    PopupMenuItem(
                      child: Text('Settings'),
                      value: MainScreen.id, //to be changed for settings screen
                    ),
                  ],
                  onSelected: (choice) {
                    if (choice == MainScreen.id) {
                      Navigator.pushReplacementNamed(
                          context, MainScreen.id); //to be changed
                    } else {
                      Navigator.pushNamed(
                          context, MainScreen.id); //to be changed
                    }
                  },
                )
              ],
            ),
            body: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Activity',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Messages',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                body: TabBarView(
                  children: [
                    Text('Activity'), //to be changed
                    MessagingScreen(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
