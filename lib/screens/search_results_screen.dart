//api/post?q=test&offset=0&type=image
import 'package:flutter/material.dart';
import 'package:tumblrx/components/search_results/tumblrs_view.dart';

class SearchResultScreen extends StatefulWidget {
  final String _query;
  const SearchResultScreen({Key key, String query})
      : _query = query,
        super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  Widget _searchResultBody = TumblrView(
    blog: null,
  );

  final Color _unSelectedButtonColor = Colors.grey[850];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.white, offset: Offset(0, -10)),
                BoxShadow(color: Colors.white, offset: Offset(0, 10)),
                BoxShadow(blurRadius: 8.0, color: Colors.grey),
                BoxShadow(color: Colors.white, offset: Offset(10, 0)),
                BoxShadow(color: Colors.white, offset: Offset(-10, 0)),
              ],
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * .98,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('GIF'),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(_unSelectedButtonColor)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Tumblrs'),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(_unSelectedButtonColor)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Photo'),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(_unSelectedButtonColor)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Text'),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(_unSelectedButtonColor)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Video'),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(_unSelectedButtonColor)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: _searchResultBody,
          ),
        )
      ],
    );
  }
}
