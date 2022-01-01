/*
  Description:
      this file creates a class that extends stateless widget to view
      tags inside explore screen
      list of tagss to be viewed are passed to the constructor

 */
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/tag.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:tumblrx/utilities/constants.dart';

class CheckOutTheseTags extends StatelessWidget {
  final List<Tag> _tags;
  const CheckOutTheseTags({Key key, @required List<Tag> tags})
      : _tags = tags,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // tags card height
    final double height = MediaQuery.of(context).size.height * .25;
    // build tag cards list
    return Container(
      height: height,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          width: 12,
        ),
        itemCount: min(_tags.length, 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final Tag tag = _tags[index];
          // card specs hardcoded
          final Color tagBackgroundColor = Colors.pink;
          final cardHeight = height;
          final cardWidth = MediaQuery.of(context).size.width * 0.34;
          // build card
          return Container(
            decoration: BoxDecoration(
              color: tagBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: cardWidth,
            height: cardHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // tag name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '#${tag.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // tag image
                Container(
                  width: cardWidth,
                  height: cardHeight * .5,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: tag.image,
                    errorWidget: (context, url, error) => Container(
                      width: cardWidth,
                      height: cardHeight * .5,
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                // follow button
                Container(
                  padding: EdgeInsets.only(bottom: 1),
                  width: cardWidth * .9,
                  height: cardHeight * .23,
                  child: TextButton(
                    onPressed: () {
                      final User user =
                          Provider.of<User>(context, listen: false);
                      user.userBlogs[user.activeBlogIndex]
                          .followTag(
                              tag.name,
                              Provider.of<Authentication>(context,
                                      listen: false)
                                  .token)
                          .then((value) {
                        showSnackBarMessage(context,
                            'followed ${tag.name} successfully', Colors.green);
                      }).catchError((err) {
                        logger.e(err);
                        showSnackBarMessage(
                            context, 'something went wrong', Colors.red);
                      });
                    },
                    child: Text('Follow'),
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.pink),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
