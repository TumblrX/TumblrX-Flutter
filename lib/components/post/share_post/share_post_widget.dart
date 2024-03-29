/*
Description: 
    A class that implementes share post widget 
*/
import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/share_post/blog_selector_widget.dart';
import 'package:tumblrx/components/post/share_post/share_methods_widget.dart';
import 'package:tumblrx/models/posts/post.dart';

class SharePostWidget extends StatelessWidget {
  static final String id = "share_post";
  final bool enableSending = false;
  final Post _post;
  SharePostWidget(Post post) : _post = post;
  // value notifier of selected blogs to send the post to
  // final ValueNotifier<List<Blog>> _selectedBlogsNotifier = ValueNotifier([]);
  // value notivifer of search blog results
//  final ValueNotifier<List<Blog>> _searchBlogResultsNotifier =
//      ValueNotifier([]);

  // helper function to draw a thick line
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
          ShareMethods(postId: _post.id),
          const Divider(
            thickness: 2.5,
          ),
          // view search results
          //SearchWidget(_searchBlogResultsNotifier),
          /*SearchResult(
            searchResultsNotifier: _searchBlogResultsNotifier,
            selectedBlogsNotifier: _searchBlogResultsNotifier,
          ),
          Spacer(),
          const Divider(),
          // view list of selected blogs to send the post to them
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              enableSending
                  ? SelectedBlogsWidget(_selectedBlogsNotifier)
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
              // send button
              IconButton(
                color: Colors.blueAccent,
                disabledColor: Colors.blueAccent.withOpacity(0.5),
                onPressed: enableSending ? () {} : null,
                icon: const Icon(
                  Icons.send_outlined,
                ),
              )
            ],
          ),*/
        ],
      ),
    );
  }
}
/*
TODOs:
1. send post as a message
*/ 