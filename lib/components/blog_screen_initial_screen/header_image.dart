import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/components/edit_blog_screen/edit.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/user/user.dart';
import '../blog_screen_search/blog_screen_search.dart';
import 'create_new_tumblr.dart';

/// this class display header image of blog screen ,icons and drop down list
class HeaderImage extends StatefulWidget {
  @override
  _HeaderImageState createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        ///the Top Icons (search /edit /share/setting)
        child: Container(
            margin: EdgeInsets.only(left: 15.0, top: 25),
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text(Provider.of<User>(context).getActiveBlogName(),
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    PopupMenuButton<dynamic>(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        onSelected: (value) {
                          if (value != 'create') {
                            Provider.of<User>(context, listen: false)
                                .setActiveBlog(value);
                            Provider.of<User>(context, listen: false)
                                .updateActiveBlog();
                          } else if (value == 'create') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewTumblrPage()),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            for (int i = 0;
                                i <
                                    Provider.of<User>(context, listen: false)
                                        .userBlogs
                                        .length;
                                i++)
                              PopupMenuItem(
                                  value:
                                      Provider.of<User>(context, listen: false)
                                          .userBlogs[i]
                                          .handle,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black12))),
                                      child: ListTile(
                                        title: Text(Provider.of<User>(context,
                                                listen: false)
                                            .userBlogs[i]
                                            .handle),
                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          child: Image(
                                            image: NetworkImage(
                                              Provider.of<User>(context,
                                                      listen: false)
                                                  .userBlogs[i]
                                                  .blogAvatar,
                                            ),
                                          ),
                                        ),
                                      ))),
                            PopupMenuItem(
                                value: 'create',
                                child: ListTile(
                                  leading: Icon(
                                    Icons.add_circle_outline,
                                    size: 30,
                                    color: Color(0xffa8a7a7),
                                  ),
                                  title: Text('Create a new Tumblr'),
                                ))
                          ];
                        }),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  /// to start from  begining in vertical
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      tooltip: 'Search blog',
                      icon: Icon(
                        Icons.search,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,

                            ///go to search pages
                            MaterialPageRoute(builder: (context) => Search()));
                      },
                    ),
                    IconButton(
                      tooltip: 'Edit',
                      icon: Icon(Icons.color_lens),
                      color: Colors.white,
                      onPressed: () {
                        ///go to edit page
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Edit()));
                      },
                    ),
                    IconButton(
                      tooltip: 'Share',
                      icon: Icon(Icons.share),
                      color: Colors.white,
                      onPressed: () {
                        logger.e('share is pressed');
                      },
                    ),
                    IconButton(
                      tooltip: 'Account',
                      icon: Icon(Icons.settings),
                      color: Colors.white,
                      onPressed: () {
                        logger.e('setting is pressed');
                      },
                    ),
                  ],
                )
              ],
            )),
        //color: Colors.green,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(BlogScreenConstant.headerImgPath),
                fit:Provider.of<User>(context).getActiveBlogStretchHeaderImage()??true? BoxFit.fill:BoxFit.contain)), //dummy image
        height: MediaQuery.of(context).size.height / 3.6, //(200)
      ),
      onTap: () {
        showModalBottomSheet(

            ///to pop the bottom sheet when when click in header image
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            context: context,
            builder: BlogScreenConstant.buildBottomSheetHeaderImage);
      },
    );
  }
}
