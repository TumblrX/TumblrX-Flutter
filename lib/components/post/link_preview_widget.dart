/*
  Author: Passant Abdelgalil

  Description:
      A stateless widget to preview link blocks in a post
*/

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class LinkPreviewWidget extends StatelessWidget {
  /// URL of the link to embed
  final String _url;
  LinkPreviewWidget(this._url);

  // PreviewData data;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
