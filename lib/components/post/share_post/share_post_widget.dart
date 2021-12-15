import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/share_post/blog_selector_widget.dart';
import 'package:tumblrx/components/post/share_post/search_widget.dart';
import 'package:tumblrx/components/post/share_post/selected_blogs_widget.dart';
//import 'package:tumblrx/components/post/share_post/search_result_widget.dart';

class SharePostWidget extends StatelessWidget {
  static final String id = "share_post";
  final bool enableSending = false;

  Widget topDecoration() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: 40,
            child: Divider(
              thickness: 4,
              color: Colors.grey[800],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topDecoration(),
          BlogSelector(),
          const Divider(
            thickness: 2.5,
          ),
          SearchWidget(),
          Spacer(),
          const Divider(),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              enableSending
                  ? SelectedBlogsWidget()
                  : Container(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Container(
                  height: 35,
                  width: 310,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(20),
                        ),
                      ),
                      hintText: "Say something if you like...",
                    ),
                  ),
                ),
              ),
              IconButton(
                color: Colors.blueAccent,
                disabledColor: Colors.blueAccent.withOpacity(0.5),
                onPressed: enableSending ? () {} : null,
                icon: const Icon(
                  Icons.send_outlined,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
