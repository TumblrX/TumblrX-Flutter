import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlerDialgue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Save changes?'),
      actions: [
        TextButton(onPressed: () {}, child: Text('Discard')),
        TextButton(
          onPressed: () {},
          child: Text('save'),
        )
      ],
    );
  }
}
