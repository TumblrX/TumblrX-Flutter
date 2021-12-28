import 'package:flutter/material.dart';
import 'package:tumblrx/global.dart';

class FollowingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      //Followings
      child: Column(
        children: [
          ListTile(
            leading: Container(
              color: Colors.black,
              width: 40,
              height: 40,
            ),
            tileColor: Colors.white,
            title: Text('rosemary'),
            subtitle: Text('life is beautiful'),
            trailing: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('Share'),
                    value: 'Share',
                  ),
                  PopupMenuItem(
                    child: Text('Get notifications'),
                    value: 'Get notifications',
                  ),
                  PopupMenuItem(
                    child: Text('Block'),
                    value: 'Block',
                  ),
                  PopupMenuItem(
                    child: Text('Report'),
                    value: 'Report',
                  ),
                  PopupMenuItem(
                    child: Text('Unfollow'),
                    value: 'Unfollow',
                  ),
                ];
              },
              onSelected: (value) {
                // add action
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
            onTap: () {
              logger.d('Blog pressed');
            },
          ),
          Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Divider(thickness: 1))
        ],
      ),
    );
  }
}
