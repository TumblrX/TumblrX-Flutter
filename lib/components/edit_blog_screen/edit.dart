import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/edit_blog_screen/edit_app_bar.dart';
import 'package:tumblrx/services/blog_screen.dart';
import '../blog_screen_constant.dart';
import 'edit_bottons.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController titleController = new TextEditingController();

  TextEditingController descriptionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
    return Scaffold(
        body: Container(
      color: BlogScreenConstant.bottomCoverColor,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
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
              EditAppBar().defaultAppBar(context),
            ],
          ),
          GestureDetector(
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
                blogProvider.setTitle(value.toString());
              },
            ),
            onTap: () {},
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: descriptionController,
            onChanged: (value) {
              blogProvider.setBlogDescription(value.toString());
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
          EditButtons()
        ],
      ),
    ));
  }
}
