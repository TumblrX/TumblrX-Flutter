import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_widgets.dart';
import 'package:tumblrx/components/edit_blog_screen/edit_app_bar.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/blog_screen.dart';
import '../blog_screen_constant.dart';
import 'cover_image_bottomsheet.dart';
import 'edit_avatar.dart';
import 'edit_bottons.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController titleController;
  TextEditingController descriptionController;
  @override
  
  void initState() {
    titleController = new TextEditingController(
        text: Provider.of<User>(context, listen: false)
            .getActiveBlogTitle()); //i will put initial title here
    descriptionController = new TextEditingController(
        text: Provider.of<User>(context, listen: false)
            .getActiveBlogDescription()); //i will put initial title here

    ///this controller for Tabs bar
    ///function used for Tab bars

    _tabController = new TabController(length: 3, vsync: this);
  }

  Widget build(BuildContext context) {
    @override
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
    return Scaffold(
        body: Container(
            color: blogProvider.getBottomColor(),
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                              height: MediaQuery.of(context).size.height / 3.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/header.png'),
                                      fit: BoxFit.fill)),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                ),
                              )),
                          onTap: () {
                            ///bottom sheet for cover image
                            //showModalBottomSheet(
                              //  context: context,
                                //builder: CoverImageBottomSheet().build);
                          },
                        ),
                      EditAppBar().defaultAppBar(context),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(
                          fontSize: 35,
                          decoration: TextDecoration.underline,
                          decorationColor: BlogScreenConstant.accent,
                          decorationStyle: TextDecorationStyle.dotted,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: TextStyle(
                              color: Colors.black12,
                              fontSize: 35,
                              decoration: TextDecoration.none),
                        ),
                        controller: titleController,
                        onChanged: (value) {
                          Provider.of<User>(context, listen: false)
                              .setActiveBlogTitle(value);
                        },
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: descriptionController,
                      onChanged: (value) {
                        Provider.of<User>(context, listen: false)
                            .setActiveBlogDescription(value);
                      },
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        decorationColor: BlogScreenConstant.accent,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description',
                          hintStyle: TextStyle(
                              color: Colors.black12,
                              fontSize: 15,
                              decoration: TextDecoration.none)),
                    ),
                    EditButtons(),
                    if (Provider.of<User>(context).getActiveBlogIsPrimary())
                      upperTabBar(_tabController, context),
                    if (Provider.of<User>(context).getActiveBlogIsPrimary())
                      bottomTabBar(_tabController, context),
                    if (!Provider.of<User>(context).getActiveBlogIsPrimary())
                      Container(
                        child: Column(),
                      )
                  ],
                ),
                Provider.of<User>(context).getIsAvatarCircle() == true
                    ? EditAvatar().editCircleAvatar(context)
                    : EditAvatar().editSquareAvatar(context),

                // EditAvatar().editSquareAvatar(context)
              ],
            )));
  }
}
