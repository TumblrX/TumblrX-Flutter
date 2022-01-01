/*
  Description:
      this file creates a class that extends stateless widget to view
      link block
      link url and descriptions are passed to the constructor
 */
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class LinkBlockWidget extends StatelessWidget {
  /// URL of the link to embed
  final String _url;
  final String _description;

  const LinkBlockWidget({Key key, @required String url, String description})
      : _url = url,
        _description = description,
        super(key: key);
  // PreviewData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: AnyLinkPreview(
            link: this._url,
            displayDirection: UIDirection.UIDirectionHorizontal,
            showMultimedia: false,
            bodyMaxLines: 5,
            bodyTextOverflow: TextOverflow.ellipsis,
            titleStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        this._description == null
            ? Container()
            : Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(8.0),
                child: Text(this._description)),
      ],
    );
  }
}
