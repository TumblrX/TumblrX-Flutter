import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/Components/blog_screen_constant.dart';
import 'package:tumblrx/services/blog_screen.dart';

  
/// for square avatar
class Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogScreenConstantProvider>(context);

    return Positioned(
        top: 135,
        child: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.height / 8.7,
            height: MediaQuery.of(context).size.height / 8.8,
            child:   ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.asset('images/avatar.png'),
            ),
            //Image(
            //image: AssetImage('images/avatar.png'),
            //fit: BoxFit.fill,
            // )

            decoration: BoxDecoration(
              color: blogProvider.getBottomColor(),
              border: Border.all(width: 3, color:   blogProvider.getBottomColor()),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          onTap: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                builder:  BlogScreenConstant.buildBottomSheetAvatar);
          },
        ));
  }
}
