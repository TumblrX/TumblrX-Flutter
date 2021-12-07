import 'package:flutter/material.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';

/// for square avatar
class Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 135,
        child: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.height / 8.7,
            height: MediaQuery.of(context).size.height / 8.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.asset('images/avatar.png'),
            ),
            //Image(
            //image: AssetImage('images/avatar.png'),
            //fit: BoxFit.fill,
            // )

            decoration: BoxDecoration(
              color: BlogScreenConstant.bottomCoverColor,
              border: Border.all(
                  width: 3, color: BlogScreenConstant.bottomCoverColor),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          onTap: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                builder: BlogScreenConstant.buildBottomSheetAvatar);
          },
        ));
  }
}
