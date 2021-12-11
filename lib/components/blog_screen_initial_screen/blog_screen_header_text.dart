import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/blog.dart';

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
        child: FutureBuilder<Blog>(
          future: Blog.getInfo("citriccomics"),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ///title
                    snapshot.data.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
                  ),
                  Text(
                    ///description
                    snapshot.data.description,
                  )
                ],
              );
            return CircularProgressIndicator();
          },
        )

        //child: Text(
        //'Untitled',
        //style:
        //  TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        //),
        );
  }
}
