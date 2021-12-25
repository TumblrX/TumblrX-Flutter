import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/avatar_shape/square.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_widgets.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/header_image.dart';
import 'package:tumblrx/components/blog_screen_initial_screen/blog_screen_header_text.dart';
import 'package:tumblrx/components/avatar_shape/avatar_image.dart';
import 'package:tumblrx/components/createpost/create_post.dart';
import 'package:tumblrx/components/following/following_card.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/services/creating_post.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

///This a initial screen you see when press on profile from navigation bar
class BlogScreen extends StatefulWidget {
  static final String id = 'blog_screen';
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    ///this controller for Tabs bar
    ///function used for Tab bars

    _tabController = new TabController(length: 3, vsync: this);

    super.initState();

    //intialize befor edit
        

    

  // print(Provider.of<User>(context, listen: false).getActiveBlogPosts()[0].blogTitle);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final blogProvider = Provider.of<BlogScreenConstantProvider>(context);

    return Scaffold(
        backgroundColor: Color(0xFF001935),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.edit),
          onPressed: () {
            double topPadding = MediaQuery.of(context).padding.top;
            Provider.of<CreatingPost>(context, listen: false)
                .initializePostOptions(context);
            !kIsWeb
                ? showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: CreatePost(
                        topPadding: topPadding,
                      ),
                    ),
                  )
                : showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          content: CreatePost(
                            topPadding: topPadding,
                          ),
                        ));
          },
        ),
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height + (12 - 3) * 60),

                /// i will chnge it and make it equal total no of following-3*40

                child: Container(
                  color: hexToColor(Provider.of<User>(context, listen: false)
                          .getActiveBlogBackColor()) ??
                      Colors.blue,
                  constraints: !kIsWeb
                      ? BoxConstraints()
                      : BoxConstraints(
                          maxWidth: 750.0,
                          minWidth: MediaQuery.of(context).size.width < 750
                              ? MediaQuery.of(context).size.width * 0.9
                              : 750.0,
                        ),
                  child: Column(

                      /// couloum have(the header image , avatar,title, description and tab bars )

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(alignment: Alignment.center, children: <Widget>[
                          Column(
                            children: <Widget>[
                              ///display header image with icons and drop down list

                              HeaderImage(),

                              ///display header image with icons and drop down list

                              TextWriting(),
                            ],
                          ),

                          ///show an avatar in square
                          Visibility(
                              visible: Provider.of<User>(context, listen: false)
                                  .getActiveBlogShowAvatar()?? true,
                              child: Provider.of<User>(context, listen: false)
                                      .getIsAvatarCircle()
                                  ? AvatarImage()
                                  : Square())
                        ]),

                        //{
                        if (Provider.of<User>(context).getActiveBlogIsPrimary())
                          upperTabBar(_tabController, context),
                        if (Provider.of<User>(context).getActiveBlogIsPrimary())
                          bottomTabBar(_tabController, context),
                        //}
                        if (!Provider.of<User>(context)
                            .getActiveBlogIsPrimary())
                          Container(
                            child: Column(),
                          )
                      ]),
                ))));
  }
}
