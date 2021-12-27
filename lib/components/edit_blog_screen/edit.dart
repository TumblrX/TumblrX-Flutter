import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_widgets.dart';
import 'package:tumblrx/components/edit_blog_screen/cover_image_bottomsheet.dart';
import 'package:tumblrx/components/edit_blog_screen/edit_app_bar.dart';
import 'package:tumblrx/components/post/post_widget.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/blog_screen.dart';
import '../blog_screen_constant.dart';
import 'edit_avatar.dart';
import 'edit_bottons.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

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
            color: hexToColor(Provider.of<User>(context, listen: false)
                    .getActiveBlogBackColor()) ??
                Colors.blue,
            child:SingleChildScrollView( child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height+ MediaQuery.of(context).size.height/2), child: Stack(
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
                                      fit: Provider.of<User>(context)
                                                  .getActiveBlogStretchHeaderImage() ??
                                              true
                                          ? BoxFit.fill
                                          : BoxFit.contain)),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                ),
                              )),
                          onTap: () {
                            ///bottom sheet for cover image

                            showModalBottomSheet(
                                context: context,
                                builder: CoverImageBottomSheet().build);
                          },
                        ),
                        EditAppBar().defaultAppBar(context),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.done,
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
                        onSubmitted: (value) {
                          Provider.of<User>(context, listen: false)
                              .settActiveBlogTitleBeforeEdit(
                                  Provider.of<User>(context, listen: false)
                                      .getActiveBlogTitle());
                          Provider.of<User>(context, listen: false)
                              .setActiveBlogTitle(value);
                        },
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: descriptionController,
                      onSubmitted: (value) {
                        Provider.of<User>(context, listen: false)
                            .setActiveBlogDescriptionBeforeEdit(
                                Provider.of<User>(context, listen: false)
                                    .getActiveBlogDescription());

                        Provider.of<User>(context, listen: false)
                            .setActiveBlogDescription(value);
                      },
                      textInputAction: TextInputAction.done,
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
                      child: FutureBuilder<List<Post>>(
                        future: Provider.of<User>(context).getActiveBlogPosts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData&&snapshot.data!=null && snapshot.data.length!=0) {
                            return Expanded(
                              child: ListView.separated(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Post post = snapshot.data[index];
                                  return PostWidget(
                                    postContent: post.content,
                                    tags: post.tags,
                                    index: 0,
                                    post: snapshot.data[index],
                                    isLikes: false,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                        height: 20.0,
                                        color: Colors.transparent),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('no');
                          } else if (snapshot.data == null ||
                              snapshot.data.length == 0) {
                            return Column();
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    )
                  ],
                ),
                Provider.of<User>(context).getIsAvatarCircle() == true
                    ? EditAvatar().editCircleAvatar(context)
                    : EditAvatar().editSquareAvatar(context),

                // EditAvatar().editSquareAvatar(context)
              ],
              ),
            ),
            ),
            ),
            );
  }
}
