import 'package:flutter/material.dart';
import 'package:tumblrx/Components/constant.dart';

class HeaderImage extends StatefulWidget {
  @override
  _HeaderImageState createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment(1, -0.6),
        //the Top Icons
        child: Row(
          //DropDown Item
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 15.0),
                width: 150,
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  //change color of DropDown icon
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  value: Constant.valueOfDropList,
                  isExpanded: true,

                  items: [
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25,
                            height: 25,
                            color: Colors.black,
                          ),
                          Text('unknown')
                        ],
                      ),
                      value: 'unknown',
                    ),
                    //Constant.createNewTumblr()
                  ],
                  onChanged: (value) {
                    setState(() {
                      Constant.valueOfDropList = value;
                    });
                  },
                )),
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                print('search is pressed');
              },
            ),
            IconButton(
              icon: Icon(Icons.color_lens),
              color: Colors.white,
              onPressed: () {
                print('colors is pressed');
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.white,
              onPressed: () {
                print('share is pressed');
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                print('setting is pressed');
              },
            ),
          ],
        ),
        //color: Colors.green,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/header.png"),
                fit: BoxFit.fill)), //dummy image
        height: 200,
      ),
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            context: context,
            builder: Constant.buildBottomSheetHeaderImage);
      },
    );
  }
}
