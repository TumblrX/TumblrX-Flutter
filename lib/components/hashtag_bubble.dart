import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HashtagBubble extends StatelessWidget {
  final String hashtag;
  final bool isSuggested;
  HashtagBubble({this.hashtag, this.isSuggested = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: isSuggested ? Colors.black12 : Colors.lightBlue,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            '#' + hashtag,
            style: TextStyle(
              color: isSuggested ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        isSuggested
            ? SizedBox.shrink()
            : Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 18.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 230, 230, 1),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.blue,
                      size: 15.0,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
