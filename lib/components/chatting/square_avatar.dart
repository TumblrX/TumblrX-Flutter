import 'package:flutter/material.dart';

class SquareAvatar extends StatelessWidget {
  SquareAvatar({
    this.avatarUrl,
  });

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        avatarUrl,
        height: 40.0,
        width: 40.0,
        fit: BoxFit.fill,
      ),
    );
  }
}
