import 'package:flutter/material.dart';
import 'package:tumblrx/models/user/blog.dart';

class SearchResult extends StatelessWidget {
  final ValueNotifier<List<Blog>> _searchResultsNotifier;
  final ValueNotifier<List<Blog>> _selectedBlogsNotifier;
  const SearchResult(
      {Key key,
      @required ValueNotifier<List<Blog>> searchResultsNotifier,
      @required ValueNotifier<List<Blog>> selectedBlogsNotifier})
      : _searchResultsNotifier = searchResultsNotifier,
        _selectedBlogsNotifier = searchResultsNotifier,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _searchResultsNotifier.value.isEmpty
            ? []
            : [
                Text(
                  'Tumblrs',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ..._searchResultsNotifier.value
                    .map((blog) => ListTile(
                          onTap: () => _selectedBlogsNotifier.value.add(blog),
                          title: Text(blog.title),
                          leading: CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(
                              blog.blogAvatar,
                            ),
                          ),
                        ))
                    .toList()
              ],
      ),
    );
  }
}
