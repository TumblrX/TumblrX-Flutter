import 'package:flutter/material.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/services/api_provider.dart';

class SearchWidget extends StatefulWidget {
  ValueNotifier<List<Blog>> _searchBlogResultsNotifier;
  SearchWidget(ValueNotifier<List<Blog>> searchResults)
      : _searchBlogResultsNotifier = searchResults;
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool searching = false;
  final String hintText = "Send to...";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              height: 35,
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                onChanged: (value) async {
                  // send request to search for blogs with entered regex=value
                  // update valuenotifier value with returned list
                  String endPoint = "";
                  await ApiHttpRepository.sendGetRequest(endPoint);
                  widget._searchBlogResultsNotifier.value = [];
                },
                textAlignVertical: TextAlignVertical.bottom,
                onTap: () => setState(() {
                  searching = true;
                }),
                controller: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: hintText,
                ),
              ),
            ),
          ),
        ),
        searching
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 10.0, 8.0),
                child: TextButton(
                    style: ButtonStyle(
                        enableFeedback: false,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () => setState(() {
                          searching = false;
                        }),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.grey),
                    )),
              )
            : Container(),
      ],
    );
  }
}
