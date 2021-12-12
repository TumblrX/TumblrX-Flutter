import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/components/edit_blog_screen/edit.dart';
import 'package:tumblrx/models/user/user.dart';
import '../blog_screen_search/blog_screen_search.dart';
import 'create_new_tumblr.dart';

/// this class display header image of blog screen ,icons and drop down list
class HeaderImage extends StatefulWidget {
  @override
  _HeaderImageState createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  String selectItem =
      BlogScreenConstant.toLengthFifteen(BlogScreenConstant.tumblrsBlog[0]);
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
                    Text(
                        BlogScreenConstant.toLengthFifteen(
                            Provider.of<User>(context).activeBlogName),
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    PopupMenuButton<dynamic>(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      onSelected: (value) {
                        setState(() {
                          ///every time we select item from drop down list
                          Provider.of<User>(context, listen: false)
                              .setActiveBlog(value);


                              if (value=='create')
                              {
                                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CreateNewTumblrPage()),
  );


                              }

                              ///////////////////////////////////////////////////////////////
                          // selectItem = BlogScreenConstant.toLengthFifteen(
                          //     value.toString());
                        //  Provider.of<User>(context, listen: false)
                          //    .setActiveBlog(value);
                          //Provider.of<User>(context, listen: false)
                            //  .updateActiveBlog();

                        ////////////////////////////////////////////////////////////////////////////////



                          ///function if numbers of character more than 15 make it 15
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          for (var i = 0;
                              i <
                                  Provider.of<User>(context, listen: false)
                                      .userBlogs
                                      .length;
                              i++)

                            ///loop  to display all blogs

                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Container(
                                    child: Image(
                                      height: 30,
                                      width: 30,
                                      image: AssetImage(Provider.of<User>(
                                                  context,
                                                  listen: false)
                                              .userBlogs[i]
                                              .blogAvatar ??
                                          "assets/icon/avatar2.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(Provider.of<User>(context, listen: false)
                                      .userBlogs[i]
                                      .handle)
                                ],
                              ),
                              value: Provider.of<User>(context, listen: false)
                                  .userBlogs[i]
                                  .handle,
                            ),
                          PopupMenuDivider(),
                          PopupMenuItem(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Color(0xffa8a7a7),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Create a new Tumblr')
                              ],
                            ),
                            value: 'create',
                           
                          )

                          ///create new blogs
                        ];
                      },
                      
                    )
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
                        print('share is pressed');
                      },
                    ),
                    IconButton(
                      tooltip: 'Account',
                      icon: Icon(Icons.settings),
                      color: Colors.white,
                      onPressed: () {
                        print('setting is pressed');
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
                fit: BoxFit.fill)), //dummy image
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
