import 'package:flutter/material.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/screens/user_blog_view.dart';

class FollowingCard extends StatelessWidget {
  ///blog of user
  final Blog _blog; 
  FollowingCard({@required blog}) : _blog = blog;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,

        ///Followings
        child: InkWell(
          child: Column(
            children: [
              ListTile(
                leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          ///avatar image
                      image: (_blog.blogAvatar != 'none')
                          ? NetworkImage(_blog.blogAvatar)
                          : NetworkImage(
                              'https://64.media.tumblr.com/ee9b9564d7e54380837579452cde04f6/tumblr_o51oavbMDx1ugpbmuo5_540.png'),
                    ))),
                tileColor: Colors.white,
                title: Text(_blog.handle),
                subtitle: Text(_blog.title),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserBlogView(
                              id: _blog.id,
                            )),
                  );
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Divider(thickness: 1))
            ],
          ),
        ));
  }
}
