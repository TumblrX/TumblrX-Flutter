import 'package:flutter/material.dart';

class ReblogsPage extends StatefulWidget {
  const ReblogsPage({Key key}) : super(key: key);

  @override
  State<ReblogsPage> createState() => _ReblogsPageState();
}

class _ReblogsPageState extends State<ReblogsPage> {
  String selectedFilter = 'comments and tags';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextButton(
            onPressed: null,
            child: Row(
              children: [
                Text(selectedFilter),
                Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
