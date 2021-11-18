import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/post.dart';

class LinkPreviewInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            onSubmitted: (value) async {
              final bool isValid =
                  await Provider.of<Post>(context, listen: false)
                      .isLinkValid(value);
              if (isValid) {
                Provider.of<Post>(context, listen: false).addLinkPreview(value);
                Navigator.pop(context);
              }
            },
            decoration: InputDecoration(
              hintText: "Add a link URL...",
              prefixIcon: Icon(Icons.link),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
