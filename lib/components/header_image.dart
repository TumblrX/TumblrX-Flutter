import 'package:flutter/material.dart';
import 'package:tumblrx/components/constant.dart';
import 'package:tumblrx/components/edit/edit.dart';
import 'blog_screen_search/blog_screen_search.dart';

class HeaderImage extends StatefulWidget {
  @override
  _HeaderImageState createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        //the Top Icons

        child: Container(
            margin: EdgeInsets.only(left: 15.0, top: 25.0),
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    DropdownButton(
                      //isExpanded: true,
                      value: 'first',
                      underline: SizedBox(),
                      //change color of DropDown icon
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      items: [
                        DropdownMenuItem(
                          //child: SizedBox(child: Text(' create new'))
                          child: Text('create a new tumblr'),
                          value: 'first',
                        ),
                      ],
                      onChanged: (selected) {},
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Search()));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.color_lens),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Edit()));
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
                )
              ],
            )),
        //color: Colors.green,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Constant.headerImgPath),
                fit: BoxFit.fill)), //dummy image
        height: MediaQuery.of(context).size.height / 3.6, //(200)
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
