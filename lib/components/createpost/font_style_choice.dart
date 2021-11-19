import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';
import 'package:tumblrx/utilities/constants.dart';

class FontStyleChoice extends StatelessWidget {
  final TextStyleType type;
  FontStyleChoice({this.type});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60.0,
        child: ListTile(
          title: Text(
            type.toString().substring(14, type.toString().length),
            style: kTextStyleMap[type],
          ),
          trailing: Provider.of<CreatingPost>(context).chosenTextStyle == type
              ? Icon(
                  Icons.done,
                  color: Colors.blue,
                )
              : SizedBox.shrink(),
        ),
      ),
      onTap: () {
        Provider.of<CreatingPost>(context, listen: false).setTextStyle(type);
        Navigator.pop(context);
      },
    );
  }
}
