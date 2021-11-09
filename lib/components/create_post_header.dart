import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostHeader extends StatelessWidget {
  final bool isPostEnabled;

  CreatePostHeader({this.isPostEnabled});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: Icon(
            Icons.close,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Spacer(),
        TextButton(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'Post',
              style: TextStyle(
                fontSize: 16.0,
                color: isPostEnabled ? Colors.black : Colors.grey,
              ),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: isPostEnabled
                ? MaterialStateProperty.all<Color>(Colors.lightBlueAccent)
                : MaterialStateProperty.all<Color>(Colors.black12),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          onPressed: isPostEnabled
              ? () {
                  Navigator.pop(context);
                }
              : null,
        ),
        SizedBox(
          width: 20.0,
        ),
        InkWell(
          child: Icon(
            Icons.more_vert,
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
