import 'package:flutter/material.dart';
import 'package:tumblrx/models/user/blog.dart';

class SelectedBlogsWidget extends StatefulWidget {
  final ValueNotifier<List<Blog>> _selectedBlogsNotifier;
  SelectedBlogsWidget(ValueNotifier<List<Blog>> selectedBlogsNotifier)
      : _selectedBlogsNotifier = selectedBlogsNotifier;
  @override
  _SelectedBlogsWidgetState createState() => _SelectedBlogsWidgetState();
}

class _SelectedBlogsWidgetState extends State<SelectedBlogsWidget> {
  @override
  void initState() {
    super.initState();
    widget._selectedBlogsNotifier.addListener(() {
      setState(() {});
    });
  }

  Widget selectedBlogIcon(Blog blog) {
    return CircleAvatar(
      backgroundImage: NetworkImage(blog.blogAvatar),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Blog> selectedBlogs = widget._selectedBlogsNotifier.value;
    final int numberOfSelected = selectedBlogs.length;
    ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (context, isExpanded) {
          return RichText(
            text: TextSpan(
              text: 'Send to',
              style: TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: '${selectedBlogs[0].title} and ', children: [
                  numberOfSelected > 2
                      ? TextSpan(text: '${numberOfSelected - 1} others')
                      : numberOfSelected == 2
                          ? TextSpan(
                              text: '${selectedBlogs[1].title}',
                            )
                          : TextSpan(),
                ]),
              ],
            ),
          );
        },
        body: Row(
          children: selectedBlogs
              .map<Widget>((blog) => selectedBlogIcon(blog))
              .toList(),
        ));
    return Container();
  }
}
