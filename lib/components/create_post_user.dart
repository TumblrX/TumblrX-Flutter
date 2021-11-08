import 'package:flutter/material.dart';

class CreatePostUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'ammarovic21',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
