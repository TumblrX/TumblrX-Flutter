import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/utilities/hex_color_value.dart';
import '../blog_screen_constant.dart';

class EditButtons extends StatefulWidget {
  @override
  _EditButtonsState createState() => _EditButtonsState();
}

class _EditButtonsState extends State<EditButtons> {
  @override
  Widget build(BuildContext context) {
    // final blogProvider = Provider.of<BlogScreenConstantProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: MaterialColorPicker(
                            selectedColor: hexToColor(
                                Provider.of<User>(context, listen: false)
                                    .getActiveBlogBackColor()),
                            onColorChange: (Color color) {
                              Provider.of<User>(context, listen: false)
                                  .settActiveBlogBackGroundColorBeforeEdit(
                                      Provider.of<User>(context, listen: false)
                                          .getActiveBlogBackColor());

                              Provider.of<User>(context, listen: false)
                                  .setActiveBlogBackColor(
                                      colorToHexString(color));
                            },
                          ),
                        ));
              },
              child: Text('Background',
                  style: TextStyle(color: Color(0xffc7c1c1))),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  hexToColor(Provider.of<User>(context, listen: false)
                          .getActiveBlogBackColor()) ??
                      Colors.blue,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xffc7c1c1)),
                        borderRadius: BorderRadius.circular(20.0))),
              ),
            )),
        SizedBox(
          width: 25,
        ), //space between 2 button
        SizedBox(
          width: 110,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: MaterialColorPicker(
                          selectedColor: Colors.yellow,
                          onColorChange: (Color color) {},
                        ),
                      ));
            },
            child: Text('Accent', style: TextStyle(color: Color(0xffc7c1c1))),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(BlogScreenConstant.accent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xffc7c1c1)),
                      borderRadius: BorderRadius.circular(20.0))),
            ),
          ),
        )
      ],
    );
  }
}
