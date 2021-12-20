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
        this._description == null ? Container() : Text(this._description),
      ],
    );
  }
}
