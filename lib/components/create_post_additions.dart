import 'package:flutter/material.dart';

class CreatePostAdditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Icon(
            Icons.text_format,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.link,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.gif,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.photo_outlined,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.headphones,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Spacer(),
        InkWell(
          child: Icon(
            Icons.tag,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
