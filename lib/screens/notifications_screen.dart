import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/chatting/messaging_screen.dart';
import 'package:tumblrx/components/createpost/create_post_user.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/screens/main_screen.dart';
import 'package:tumblrx/utilities/constants.dart';

///Notifications Screen that contains Activity and Messaging
class NotificationsScreen extends StatefulWidget {
  static final String id = 'notification_screen';

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
              //automaticallyImplyLeading: false,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              actionsIconTheme: IconThemeData(color: Colors.black),
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                        Provider.of<User>(context, listen: false)
                            .getPrimaryBlogAvatar(),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      Provider.of<User>(context, listen: false)
                          .getPrimaryBlogName(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Refresh'),
                      value: 'Refresh',
                    ),
                  ],
                  onSelected: (choice) {
                    if (choice == 'Refresh') setState(() {}); //to be changed
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
                        'Messages',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Activity',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                body: TabBarView(
                  children: [
                    MessagingScreen(),
                    Text('Activity'), //to be changed
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
