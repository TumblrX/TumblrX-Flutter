import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/blog_screen_constant.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/blog_screen.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.network( 

               
                Provider.of<User>(context).getActiveBlogAvatar(),
                fit: BoxFit.cover,
            
             
                 
                ),
            ),
            
            //image: AssetImage('images/avatar.png'),
            //fit: BoxFit.fill,
            // )

            decoration: BoxDecoration(
              color:  hexToColor( Provider.of<User>(context,listen: false).getActiveBlogBackColor())??Colors.blue,
              border:
                  Border.all(width: 3, color: hexToColor(( Provider.of<User>(context,listen: false).getActiveBlogBackColor())??Colors.blue,)),
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
