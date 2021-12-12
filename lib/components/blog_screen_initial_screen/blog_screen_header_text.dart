import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/blog_screen.dart';

class TextWriting extends StatelessWidget {
  ///this area which has title and discription
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);
    return Container(
        alignment: Alignment.center,
        color: blogProvider.getBottomColor(),
        padding: const EdgeInsets.all(25.0),

        ///height: 123,
        child:
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ///title
                    blogProvider.getTitle()
                    ,
                    
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
                  ),
                  Text(
                    ///description
                   blogProvider.getDescription()
                  )
                ],
              )
    
        //child: Text(
        //'Untitled',
        //style:
        //  TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        //),
        );
  }
}
