/*
Author:Esraa Gamal
Description:the page of Editing in blog 
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_widgets.dart';
import 'package:tumblrx/components/edit_blog_screen/cover_image_bottomsheet.dart';
import 'package:tumblrx/components/edit_blog_screen/edit_app_bar.dart';
import 'package:tumblrx/components/post/post_widget.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/utilities/constants.dart';
import '../../global.dart';
import '../blog_screen_constant.dart';
import 'edit_avatar.dart';
import 'edit_bottons.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

///the page of Editing in blog
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
    logger.d(
        'active title ${Provider.of<User>(context, listen: false).getActiveBlogTitle()}');
    logger.d(
        'active description ${Provider.of<User>(context, listen: false).getActiveBlogDescription()}');

    ///controller for title
    titleController = new TextEditingController(
        text: Provider.of<User>(context, listen: false).getActiveBlogTitle());

    ///controller for description
    descriptionController = new TextEditingController(
        text: Provider.of<User>(context, listen: false)
            .getActiveBlogDescription());

    ///this controller for Tabs bar
    ///function used for Tab bars
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<BlogScreenConstantProvider>(context);
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
            body: Container(
              color: hexToColor(Provider.of<User>(context, listen: false)
                      .getActiveBlogBackColor()) ??
                  Colors.blue,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height +
                          MediaQuery.of(context).size.height / 2),
                  child: Stack(
                    children: [
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(

                                                ///header image of blog
                                                Provider.of<User>(context,
                                                            listen: false)
                                                        .getActiveBlogHeaderImage()
                                                        .startsWith('http')
                                                    ? Provider.of<User>(context)
                                                        .getActiveBlogHeaderImage()
                                                    : ApiHttpRepository.api +
                                                            Provider.of<User>(
                                                                    context)
                                                                .getActiveBlogHeaderImage() ??
                                                        'http://tumblrx.me:3000/uploads/blog/blog-1640803111113-undefined.png'),
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
                                color: hexToColor(
                                    Provider.of<User>(context, listen: false)
                                            .getActiveBlogTitleColor() ??
                                        "#000000"),
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
                                        Provider.of<User>(context,
                                                listen: false)
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
                              color: hexToColor(
                                  Provider.of<User>(context, listen: false)
                                          .getActiveBlogTitleColor() ??
                                      "#000000"),
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
                          if (Provider.of<User>(context)
                              .getActiveBlogIsPrimary())
                            upperTabBar(
                                _tabController,
                                context,
                                Provider.of<User>(context, listen: false)
                                    .getActiveBlogBackColor()),
                          if (Provider.of<User>(context)
                              .getActiveBlogIsPrimary())
                            bottomTabBar(
                                _tabController,
                                context,
                                Provider.of<User>(context, listen: false)
                                    .getActiveBlogBackColor(),
                                Provider.of<User>(context, listen: false)
                                    .getActiveBlog()),
                          if (!Provider.of<User>(context)
                              .getActiveBlogIsPrimary())
                            Container(
                              child: FutureBuilder<List<Post>>(
                                future: Provider.of<User>(context)
                                    .getActiveBlogPosts(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data.length != 0) {
                                    return Expanded(
                                      child: ListView.separated(
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Post post = snapshot.data[index];
                                          return PostWidget(
                                            post: post,
                                            /// isLikes: false,
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
                     /// check if will show avatar as a circle or square 
                      Provider.of<User>(context).getIsAvatarCircle() == true
                          ? EditAvatar().editCircleAvatar(context)
                          : EditAvatar().editSquareAvatar(context),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
