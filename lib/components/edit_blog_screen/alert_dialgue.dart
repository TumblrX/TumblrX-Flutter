import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlerDialgue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text('Save changes?'),
      actions: [
        CupertinoDialogAction(
          child: Text('Discard'),
          onPressed: () {},
        ),
        CupertinoDialogAction(
          child: Text('Save',style: TextStyle(color: Colors.blue),),
          onPressed: () {},
        )
      ],
    );
  }
}
