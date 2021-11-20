import 'package:flutter/material.dart';
import 'package:tumblrx/Components/blog_screen_constant.dart';

class EditButtons extends StatefulWidget {
  @override
  _EditButtonsState createState() => _EditButtonsState();
}
class _EditButtonsState extends State<EditButtons> {
  @override
  Widget build(BuildContext context) {
    return  Row(  
     mainAxisAlignment: MainAxisAlignment.center ,
   crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       SizedBox(width: 120,
         child: ElevatedButton(onPressed: () {}, child: Text('Background',style:TextStyle(color: Color(0xffc7c1c1))),style:ButtonStyle(
        backgroundColor:MaterialStateProperty.all<Color>( BlogScreenConstant.bottomCoverColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          side: BorderSide(color:Color(0xffc7c1c1)),
          borderRadius:BorderRadius.circular(20.0))),
         ) ,
         )),
         SizedBox(width: 25,), //space between 2 button
         SizedBox(
           width: 110,
        child: ElevatedButton(onPressed: () {}, child: Text('Accent',style:TextStyle(color: Color(0xffc7c1c1))),style:ButtonStyle(
        backgroundColor:MaterialStateProperty.all<Color>( BlogScreenConstant. accent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          side: BorderSide(color:Color(0xffc7c1c1)),
          borderRadius:BorderRadius.circular(20.0))),
         ) ,       
         ),)

         ],
    );
  }
}
