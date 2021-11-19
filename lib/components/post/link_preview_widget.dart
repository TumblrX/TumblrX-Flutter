import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;

class LinkPreviewWidget extends StatefulWidget {
  final String _url;
  LinkPreviewWidget(this._url);

  @override
  State<LinkPreviewWidget> createState() => _LinkPreviewWidgetState();
}

class _LinkPreviewWidgetState extends State<LinkPreviewWidget> {
  PreviewData data;

  @override
  Widget build(BuildContext context) {
    return LinkPreview(
      onPreviewDataFetched: (PreviewData prevData) {
        setState(() {
          data = prevData;
        });
      },
      previewData: data,
      text: widget._url,
      width: MediaQuery.of(context).size.width,
    );
  }
}
